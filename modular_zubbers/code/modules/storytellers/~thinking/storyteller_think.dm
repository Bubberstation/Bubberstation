//Here's where is magic begin
#define CONTEXT_TAGS "tags"
#define CONTEXT_CATEGORY "category"
#define CONTEXT_BIAS "bias"
#define STORY_REPETITION_DECAY_TIME (20 MINUTES)
#define STORY_TAG_MATCH_BONUS 0.2
#define STORY_VOLATILITY_NEUTRAL_CHANCE 10  // Percent chance to pick neutral in high volatility
#define STORY_TENSION_THRESHOLD 15 // Threshold for balanced tension
#define THINK_TAG_BASE_MULT 1.0
#define THINK_VOLATILITY_WEIGHT 0.6
#define THINK_TENSION_WEIGHT 1.0
#define THINK_MOOD_WEIGHT 1.0
#define THINK_ADAPTATION_WEIGHT 1.0



/datum/storyteller_think
	var/list/think_stages = list(
		/datum/think_stage/apply_category_bias,
		/datum/think_stage/base_health_tags,
		/datum/think_stage/base_antag_tags,
		/datum/think_stage/base_resource_tags,
		/datum/think_stage/mid_aggregation,
		/datum/think_stage/high_implications,
		/datum/think_stage/additional_influences,
		/datum/think_stage/volatility_random,
	)


/datum/storyteller_think/New()
	. = ..()
	for(var/i = 1 to length(think_stages))
		var/stage = think_stages[i]
		think_stages[i] = new stage



// Derive universal tags, incorporating balancer snapshot for antag/station dynamics
// Builds hierarchy: Base from metrics (influenced by category for bias), mid from aggregation, high from balance implications.
// Category biases derivation: e.g., GOAL_BAD favors ESCALATION/AFFECTS_CREW_HEALTH harm; GOAL_GOOD favors DEESCALATION/recovery.
/datum/storyteller_think/proc/tokenize( \
	category, \
	datum/storyteller/ctl, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood)

	SHOULD_NOT_OVERRIDE(TRUE)
	if(!category)
		category = determine_category(ctl, bal)


	var/list/context = list(
		CONTEXT_TAGS = 0,
		CONTEXT_CATEGORY = 0,
		CONTEXT_BIAS = 1.0,
	)
	for(var/datum/think_stage/stage as anything in think_stages)
		stage.execute(ctl, inputs, bal, mood, context)
	return context[CONTEXT_TAGS]


// Method to select goal category (GOOD/BAD/NEUTRAL/RANDOM) based on storyteller state
// Uses mood (aggression/pace), balance tension, adaptation_factor, threat_points, and population_factor.
// E.g., high tension/adaptation -> GOOD/NEUTRAL (recovery/grace); low threat/relaxed mood -> BAD (challenge); balanced tension -> NEUTRAL (RP filler).
// Called in planner before filtering goals, to bias directionality (STORY_GOAL_GOOD/GOAL_BAD/GOAL_NEUTRAL).
// Inspired by RimWorld: Balances like Cassandra (tension-targeted), with Randy's volatility for flips/neutrals.
/datum/storyteller_think/proc/determine_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	var/tension = bal.overall_tension // 0..100
	var/target = ctl.target_tension

	var/tension_norm = clamp((tension / 100.0), 0, 1)
	var/tension_diff_norm = clamp(abs(tension - target) / 100.0, 0, 1)
	var/mood_aggr = ctl.mood.get_threat_multiplier() // 0..2
	var/mood_vol = ctl.mood.get_variance_multiplier() // 0..2
	var/pace = ctl.get_effective_pace()
	var/adapt = clamp(ctl.adaptation_factor, 0, 1)
	var/threat_rel = clamp(ctl.threat_points / max(1, ctl.max_threat_scale), 0, 1)
	var/pop = clamp(ctl.population_factor, 0.1, 1.0)

	// Scores for each category (higher -> more likely)
	var/score_good = 0
	var/score_bad = 0
	var/score_neutral = 0
	var/score_random = 0

	// GOOD (recovery) becomes more likely when tension is high (we want deescalation) and/or adaptation active
	score_good += tension_norm * THINK_TENSION_WEIGHT * 0.8
	score_good += adapt * THINK_ADAPTATION_WEIGHT * 0.6
	score_good += mood_aggr < (0.8 * pace) ? 0.4 : 0.0 // calm bias slightly towards good
	score_good += pace * THINK_MOOD_WEIGHT * 0.8
	score_good = min(score_good, 2.0)

	// BAD (escalation) more likely when tension is low (need to push), when mood_aggression high or threat_rel high
	score_bad += (1.0 - tension_norm) * THINK_TENSION_WEIGHT * 0.9
	score_bad += mood_aggr * THINK_MOOD_WEIGHT * 0.8
	score_bad += threat_rel * 0.6
	score_bad = min(score_bad, 2.0)

	// NEUTRAL more likely when tension close to target and population large
	score_neutral += (1.0 - tension_diff_norm) * 0.8 * pop
	score_neutral += 0.2 * (1.0 - mood_aggr) // calm -> RP filler
	score_neutral = min(score_neutral, 2.0)

	// RANDOM becomes more attractive when volatility high
	score_random += (mood_vol - 1.0) * THINK_VOLATILITY_WEIGHT
	if(score_random < 0)
		score_random = 0

	// Small random jitter to avoid strict ties and add variability
	score_good += rand(0,10)/100.0
	score_bad += rand(0,10)/100.0
	score_neutral += rand(0,10)/100.0
	score_random += rand(0,10)/100.0

	// Applying storyteller traits with jitter
	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_KIND))
		score_good += rand(2, 20)/100.0  // Bias to good, but not deterministic

	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_FORCE_TENSION))
		if(ctl.current_tension < ctl.target_tension)
			score_bad += rand(2, 20)/100.0  // Bias to bad for escalation

	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_BALANCING_TENSTION))
		if(abs(ctl.current_tension - ctl.target_tension) > 10)
			score_neutral += rand(2, 20)/100.0  // Bias to neutral for balance

	if(!HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_MERCY) && ctl.population_factor <= 0.5)
		if(tension_diff_norm > 0.5)  // Mercy in high diff
			score_good += rand(2, 20)/100.0  // Chance for good even in diff
		else
			score_neutral += rand(2, 20)/100.0

	// Weighted pick instead of max: allows chance for lower scores (e.g., good even if bad high)
	// Normalize scores to probs (softmax-like, but simple sum)
	var/total_score = score_good + score_bad + score_neutral + score_random
	if(total_score <= 0)
		return STORY_GOAL_NEUTRAL  // Fallback

	var/prob_good = score_good / total_score
	var/prob_bad = score_bad / total_score
	var/prob_neutral = score_neutral / total_score
	var/prob_random = score_random / total_score

	// Roll (rand for chance)
	var/roll = rand()
	if(roll < prob_good && !HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_GOOD_EVENTS))
		return STORY_GOAL_GOOD
	else if(roll < prob_good + prob_bad)
		return STORY_GOAL_BAD
	else if(roll < prob_good + prob_bad + prob_neutral)
		return STORY_GOAL_NEUTRAL
	else if(roll < prob_random)
		return STORY_GOAL_RANDOM
	else
		return STORY_GOAL_RANDOM


// Basic select_weighted_goal with integration to goal procs
// Computes final weight using G.get_weight (which can access vault/inputs for custom logic),
// then applies storyteller vars (difficulty, adaptation, repetition) for adaptation.
// Enhanced repetition: Gradient penalty based on recency (time since last similar) and frequency (count in history),
// scaled by adaptation (stronger post-recovery) and population (tolerable in big crews).
// Inspired by RimWorld's event weighting: base chance + modifiers from colony state (here(Nova), station metrics + history avoidance).
/datum/storyteller_think/proc/select_weighted_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, list/candidates, population_scale = 1.0, desired_tags = null)
	if(!candidates.len)
		return null

	var/list/weighted = list()
	for(var/datum/storyteller_goal/G in candidates)
		if(!G.is_available(inputs.vault, inputs, ctl) && !SSstorytellers.hard_debug)
			continue

		var/base_weight = G.get_weight(inputs.vault, inputs, ctl)
		var/priority_boost = G.get_priority(inputs.vault, inputs, ctl) * 0.5
		var/diff_adjust = ctl.difficulty_multiplier * population_scale

		// Enhanced repetition penalty: Recency (time-based decay) + frequency (count in history)
		var/rep_penalty = 0
		var/list/recent_history = ctl.recent_events  // Assoc [unique_id = details], unique_id = G.id + "_time"
		var/id_prefix = G.id + "_"
		var/last_fire_time = 0
		var/repeat_count = 0

		for(var/hist_id in recent_history)
			if(findtext(hist_id, id_prefix, 1, 0))
				repeat_count++
				var/list/details = recent_history[hist_id]
				var/fire_time = details["fired_ts"]
				if(fire_time > last_fire_time)
					last_fire_time = fire_time

		if(repeat_count > 0)
			var/age = world.time - last_fire_time
			var/recency_factor = clamp(1 - (age / STORY_REPETITION_DECAY_TIME), 0, 1)
			var/freq_mult = 1 + (repeat_count - 1) * 0.5
			rep_penalty = ctl.repetition_penalty * recency_factor * freq_mult

		// Adaptation scaling: Stronger penalty when crew adapted (avoid boring repeats post-recovery)
		rep_penalty *= (1 + ctl.adaptation_factor * 0.5)
		// Population tolerance: Weaker in big crews (more players = less notice repeats)
		rep_penalty /= max(1.0, ctl.population_factor)

		// Threat/adaptation influence: Boost aggressive/escalation if threat high, reduce if adapted (post-damage grace)
		var/threat_bonus = ctl.threat_points * ctl.mood.get_threat_multiplier() * STORY_PICK_THREAT_BONUS_SCALE  // Small scaling for gradual escalation
		var/adapt_reduce = 1.0 - ctl.adaptation_factor

		// Balance tension: If tension high, boost deescalation goals; low -> escalation
		var/balance_bonus = 0
		if(bal.overall_tension > ctl.target_tension && (G.tags & STORY_TAG_DEESCALATION))
			balance_bonus += STORY_BALANCE_BONUS
		else if(bal.overall_tension < ctl.target_tension && (G.tags & STORY_TAG_ESCALATION))
			balance_bonus += STORY_BALANCE_BONUS


		var/tag_match_bonus = 0
		if(desired_tags && G.tags)
			var/matches = G.tags & desired_tags  // Bitfield intersection (assuming tags are bitflags)
			var/num_matches = 0
			var/temp = matches
			while(temp)
				num_matches += (temp & 1)
				temp >>= 1  // Manual popcount via bitshift loop
			tag_match_bonus = num_matches * STORY_TAG_MATCH_BONUS

		// Final weight: Combine all, ensure minimum to avoid zero-weight goals
		var/final_weight = max(0.1, (base_weight + priority_boost + threat_bonus + balance_bonus + tag_match_bonus - rep_penalty) * diff_adjust * adapt_reduce)
		weighted[G] = final_weight

	var/datum/storyteller_goal/selected = pick_weight(weighted)
	if(!selected)
		return null

	// Use pick_weight helper for selection
	return new selected.type

/datum/think_stage
	var/description = "Base think stage"

/datum/think_stage/proc/_apply_tag_with_context(list/context, datum/storyteller_mood/mood, tag, base_chance_percent)
	if(!context) return
	var/bias = context[CONTEXT_BIAS] || 1.0
	var/vol = mood ? mood.get_variance_multiplier() : 1.0
	var/final_chance = base_chance_percent * bias * (1.0 + (vol - 1.0) * THINK_VOLATILITY_WEIGHT)
	final_chance = clamp(final_chance, 0, 100)
	if(prob(final_chance))
		context[CONTEXT_TAGS] |= tag


/datum/think_stage/proc/execute(datum/storyteller/ctl, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood, \
	list/context)
	return

/datum/think_stage/apply_category_bias
	description = "Applies category bias and initial tags"

/datum/think_stage/apply_category_bias/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	context[CONTEXT_BIAS] = 1.0
	// always ensure tags is integer bitfield
	if(!context[CONTEXT_TAGS])
		context[CONTEXT_TAGS] = 0

	if(category & STORY_GOAL_BAD)
		context[CONTEXT_BIAS] = 1.5
		context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION
	else if(category & STORY_GOAL_GOOD)
		context[CONTEXT_BIAS] = 1.3
		context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION
	else if(category & STORY_GOAL_RANDOM)
		context[CONTEXT_BIAS] = 1.1
		// random gets a chance to be chaotic
		_apply_tag_with_context(context, mood, STORY_TAG_CHAOTIC, 30)
	else if(category & STORY_GOAL_NEUTRAL)
		context[CONTEXT_BIAS] = 0.85
		// neutral generally avoids escalation/deescalation, but may affect morale or roleplay tags
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_MORALE, 40)

	if(category & STORY_GOAL_GLOBAL)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_WHOLE_STATION


/datum/think_stage/base_health_tags
	description = "Adds base tags from crew health metrics"

/datum/think_stage/base_health_tags/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category_bias = context[CONTEXT_BIAS]
	var/crew_health = inputs.vault[STORY_VAULT_CREW_HEALTH] || STORY_VAULT_HEALTH_HEALTHY
	var/crew_wounding = inputs.vault[STORY_VAULT_CREW_WOUNDING] || STORY_VAULT_NO_WOUNDS
	var/crew_diseases = inputs.vault[STORY_VAULT_CREW_DISEASES] || STORY_VAULT_NO_DISEASES
	var/crew_dead_ratio = inputs.vault[STORY_VAULT_CREW_DEAD_RATIO] || STORY_VAULT_LOW_DEAD_RATIO

	// higher base chances for worse states
	if(crew_health >= STORY_VAULT_HEALTH_DAMAGED)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_CREW_HEALTH, 65 * category_bias)
	if(crew_wounding >= STORY_VAULT_SOME_WOUNDED)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_CREW_HEALTH, 55 * category_bias)
	if(crew_diseases >= STORY_VAULT_MINOR_DISEASES)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_AFFECTS_ENVIRONMENT, 50 * category_bias)
	if(crew_dead_ratio >= STORY_VAULT_MODERATE_DEAD_RATIO)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_MORALE, 75 * category_bias)


/datum/think_stage/base_antag_tags
	description = "Adds base tags from antagonist metrics"

/datum/think_stage/base_antag_tags/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category_bias = context[CONTEXT_BIAS]
	var/antag_presence = inputs.vault[STORY_VAULT_ANTAGONIST_PRESENCE] || STORY_VAULT_NO_ANTAGONISTS
	var/antag_activity = inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || STORY_VAULT_NO_ACTIVITY
	var/antag_kills = inputs.vault[STORY_VAULT_ANTAG_KILLS] || STORY_VAULT_NO_KILLS
	var/antag_objectives = inputs.vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] || STORY_VAULT_NO_OBJECTIVES
	var/antag_influence = inputs.vault[STORY_VAULT_ANTAG_INFLUENCE] || STORY_VAULT_LOW_INFLUENCE
	var/antag_disruption = inputs.vault[STORY_VAULT_ANTAG_DISRUPTION] || STORY_VAULT_NO_DISRUPTION

	if(antag_presence >= STORY_VAULT_FEW_ANTAGONISTS)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_ANTAGONIST, 50 * category_bias)
	if(antag_presence >= STORY_VAULT_MANY_ANTAGONISTS)
		// many antags -> either escalation or deescalation depending on category
		if(context[CONTEXT_CATEGORY] & STORY_GOAL_BAD)
			context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION
		else
			context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION

	if(antag_activity >= STORY_VAULT_MODERATE_ACTIVITY)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_SECURITY | STORY_TAG_ESCALATION, 70 * category_bias)
	if(antag_kills >= STORY_VAULT_MODERATE_KILLS)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_MORALE | STORY_TAG_ESCALATION, 80 * category_bias)
	if(antag_objectives >= STORY_VAULT_MODERATE_OBJECTIVES)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_ANTAGONIST, 55 * category_bias)
	if(antag_influence >= STORY_VAULT_HIGH_INFLUENCE)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_AFFECTS_POLITICS, 60 * category_bias)
	if(antag_disruption >= STORY_VAULT_MAJOR_DISRUPTION)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_ESCALATION


/datum/think_stage/base_resource_tags
	description = "Adds base tags from resources and additional metrics"

/datum/think_stage/base_resource_tags/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category_bias = context[CONTEXT_BIAS]
	var/research_progress = inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] || STORY_VAULT_LOW_RESEARCH
	var/resource_minerals = inputs.vault[STORY_VAULT_RESOURCE_MINERALS] || 0

	if(resource_minerals >= 2)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_RESOURCES | STORY_TAG_AFFECTS_ECONOMY, 60 * category_bias)
	if(inputs.vault[STORY_VAULT_POWER_STATUS] >= STORY_VAULT_LOW_POWER)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_TECHNOLOGY, 70 * category_bias)
	if(inputs.vault[STORY_VAULT_INFRA_DAMAGE] >= STORY_VAULT_MINOR_DAMAGE)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_ENVIRONMENT | STORY_TAG_AFFECTS_CREW_HEALTH, 65 * category_bias)
	if(research_progress >= STORY_VAULT_HIGH_RESEARCH)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_RESEARCH | (context[CONTEXT_CATEGORY] & STORY_GOAL_BAD ? STORY_TAG_ESCALATION : STORY_TAG_DEESCALATION), 55 * category_bias)
	if(inputs.vault[STORY_VAULT_CREW_MORALE] >= STORY_VAULT_LOW_MORALE)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_MORALE
	if(inputs.vault[STORY_VAULT_SECURITY_ALERT] >= STORY_VAULT_RED_ALERT)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_SECURITY | STORY_TAG_ESCALATION

/datum/think_stage/mid_aggregation
	description = "Aggregates mid-level crises and antag dynamics"

/datum/think_stage/mid_aggregation/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/tags = context[CONTEXT_TAGS]
	var/health_crisis = (tags & STORY_TAG_AFFECTS_CREW_HEALTH)
	var/morale_crisis = (tags & STORY_TAG_AFFECTS_MORALE)

	if(health_crisis || morale_crisis)
		if((context[CONTEXT_CATEGORY] & STORY_GOAL_BAD) || bal.overall_tension > ctl.target_tension)
			context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION
		else
			context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION

	if(bal.antag_effectiveness < ctl.balancer.weak_antag_threshold && bal.ratio < 0.8)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_ANTAGONIST, 80 * context[CONTEXT_BIAS])

	if(bal.station_strength < 0.5)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_RESOURCES | STORY_TAG_AFFECTS_INFRASTRUCTURE, 70 * context[CONTEXT_BIAS])

/datum/think_stage/high_implications
	description = "Applies high-level narrative adjustments"

/datum/think_stage/high_implications/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/tags = context[CONTEXT_TAGS]
	var/health_crisis = (tags & STORY_TAG_AFFECTS_CREW_HEALTH)
	var/morale_crisis = (tags & STORY_TAG_AFFECTS_MORALE)

	if(health_crisis)
		if((context[CONTEXT_CATEGORY] & STORY_GOAL_GOOD) || bal.overall_tension > ctl.target_tension)
			context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH
		else
			context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH

	if(morale_crisis)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_MORALE | ((context[CONTEXT_CATEGORY] & STORY_GOAL_BAD) ? STORY_TAG_ESCALATION : STORY_TAG_DEESCALATION)

	if(bal.ratio < 0.8)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ANTAGONIST | STORY_TAG_DEESCALATION

	if(bal.overall_tension > ctl.target_tension)
		context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION
	else if(bal.overall_tension < ctl.target_tension * 0.7)
		context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION

/datum/think_stage/additional_influences
	description = "Adds additional category-specific influences"

/datum/think_stage/additional_influences/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	if(context[CONTEXT_CATEGORY] & STORY_GOAL_GLOBAL)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_WHOLE_STATION
	if(STORY_VAULT_LOW_RESOURCE in inputs.vault)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ECONOMY | STORY_TAG_AFFECTS_RESOURCES
	if((context[CONTEXT_CATEGORY] & STORY_GOAL_BAD) && (inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] >= STORY_VAULT_MODERATE_RESEARCH))
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_RESEARCH | STORY_TAG_AFFECTS_SECURITY

/datum/think_stage/volatility_random
	description = "Adds random tags based on mood volatility"

/datum/think_stage/volatility_random/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	if(mood.volatility > 1.1)
		for(var/i in 1 to rand(1, 3))
			var/random_tag = get_random_bitflag("story_universal_tags")
			if(random_tag)
				context[CONTEXT_TAGS] |= random_tag
		if(mood.volatility > 1.5 && prob(50))
			context[CONTEXT_TAGS] |= STORY_TAG_CHAOTIC


#undef STORY_VOLATILITY_NEUTRAL_CHANCE
#undef STORY_TENSION_THRESHOLD
#undef CONTEXT_TAGS
#undef CONTEXT_CATEGORY
#undef CONTEXT_BIAS
#undef STORY_REPETITION_DECAY_TIME
#undef STORY_TAG_MATCH_BONUS
#undef THINK_TAG_BASE_MULT
#undef THINK_VOLATILITY_WEIGHT
#undef THINK_TENSION_WEIGHT
#undef THINK_MOOD_WEIGHT
#undef THINK_ADAPTATION_WEIGHT
