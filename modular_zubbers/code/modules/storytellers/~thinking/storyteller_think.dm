//Here's where is magic begin
#define CONTEXT_TAGS "tags"
#define CONTEXT_CATEGORY "category"
#define CONTEXT_BIAS "bias"

#define STORY_REPETITION_DECAY_TIME (20 MINUTES)
#define STORY_TAG_MATCH_BONUS 0.45
#define STORY_VOLATILITY_NEUTRAL_CHANCE 13
#define STORY_TENSION_THRESHOLD 14
#define THINK_TAG_BASE_MULT 1.0
#define THINK_VOLATILITY_WEIGHT 0.6
#define THINK_TENSION_WEIGHT 0.8
#define THINK_MOOD_WEIGHT 1.0
#define THINK_ADAPTATION_WEIGHT 1.0

#define THINK_THREAT_WEIGHT 0.05
#define STORY_PRIORITY_BOOST_SCALE 0.4
#define STORY_MAX_FREQ_MULT 0.5
#define STORY_MAX_THREAT_BONUS 0.4

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


// Helper to add jitter to score: uniform rand in range for variability
/datum/storyteller_think/proc/add_jitter(score, min_val = 0, max_val = 0.1)
	PRIVATE_PROC(TRUE)
	return score + (rand(min_val * 100, max_val * 100) / 100.0)



// Method to select goal category (GOOD/BAD/NEUTRAL/RANDOM) based on storyteller state
// Uses mood (aggression/pace), balance tension, adaptation_factor, threat_points, and population_factor.
// E.g., high tension/adaptation -> GOOD/NEUTRAL (recovery/grace); low threat/relaxed mood -> BAD (challenge); balanced tension -> NEUTRAL (RP filler).
// Called in planner before filtering goals, to bias directionality (STORY_GOAL_GOOD/GOAL_BAD/GOAL_NEUTRAL).
// Inspired by RimWorld: Balances like Cassandra (tension-targeted), with Randy's volatility for flips/neutrals.
/datum/storyteller_think/proc/determine_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	var/tension = bal.overall_tension
	var/target = ctl.target_tension

	var/tension_norm = clamp((tension / 100.0), 0, 1)
	var/tension_diff_norm = clamp(abs(tension - target) / 100.0, 0, 1)
	var/mood_aggr = ctl.mood.get_threat_multiplier() * 0.9
	var/mood_vol = ctl.mood.get_variance_multiplier()
	var/pace = ctl.get_effective_pace()
	var/adapt = clamp(ctl.adaptation_factor, 0, 1)
	var/threat_rel = clamp(ctl.threat_points / max(1, ctl.max_threat_scale), 0, 1)
	var/pop = clamp(ctl.population_factor, 0.1, 1.0)

	// Scores for each category (higher -> more likely)
	var/score_good = 0
	var/score_bad = 0
	var/score_neutral = 0
	var/score_random = 0


	var/good_base_bias = 0.12
	var/bad_tension_mult = 0.3
	var/good_tension_mult = 0.8
	var/good_adapt_mult = 0.8


	score_good += tension_norm * THINK_TENSION_WEIGHT * good_tension_mult
	score_good += adapt * THINK_ADAPTATION_WEIGHT * good_adapt_mult
	score_good += mood_aggr < (0.70 * pace) ? 0.7 : 0.0
	score_good += good_base_bias
	// Boost good events at low population (mercy mode)
	if(pop < 0.5)
		score_good += 0.2
	score_good = min(score_good, 2.0)

	score_bad += (1.0 - tension_norm) * THINK_TENSION_WEIGHT * bad_tension_mult
	score_bad += mood_aggr * THINK_MOOD_WEIGHT * 0.4
	score_bad += threat_rel * THINK_THREAT_WEIGHT * 0.4
	score_bad += pace * THINK_MOOD_WEIGHT * 0.1
	// Scale bad events by population: low pop = fewer bad events
	score_bad *= clamp(pop, 0.5, 1.0)
	score_bad = min(score_bad, 2.0)

	// Neutral events are more common at low population (less intense gameplay)
	score_neutral += (1.0 - tension_diff_norm) * 0.8 * pop
	score_neutral += 0.2 * (1.0 - mood_aggr)
	// Boost neutral score for low population
	if(pop < 0.5)
		score_neutral += 0.3
	score_neutral = min(score_neutral, 2.0)

	score_random += (mood_vol - 1.0) * THINK_VOLATILITY_WEIGHT
	if(score_random < 0)
		score_random = 0

	if(tension_diff_norm > 0.45)
		score_good += 0.15

	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_GOOD_EVENTS))
		score_good = 0
	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_KIND))
		score_good += add_jitter(0, 0.02, 0.2)
	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_FORCE_TENSION))
		if(ctl.current_tension < ctl.target_tension)
			score_bad += add_jitter(0, 0.02, 0.2)
	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_BALANCING_TENSTION))
		if(abs(ctl.current_tension - ctl.target_tension) > 10)
			score_neutral += add_jitter(0, 0.02, 0.2)
	if(!HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_MERCY) && ctl.population_factor <= 0.5)
		if(tension_diff_norm > 0.5)
			score_good += add_jitter(0, 0.02, 0.2)
		else
			score_neutral += add_jitter(0, 0.02, 0.2)
	if(tension_diff_norm <= 0.2)
		score_neutral += add_jitter(0, 0.04, 0.2)

	score_good = max(score_good + add_jitter(0, 0, 0.2), 0.02)
	score_bad  = max(score_bad  + add_jitter(0, 0, 0.2), 0.02)
	score_neutral = max(score_neutral + add_jitter(0, 0, 0.2), 0.02)
	score_random  = max(score_random  + add_jitter(0, 0, 0.2), 0.0)

	// Normalize scores to probs
	var/total_score = score_good + score_bad + score_neutral + score_random
	if(total_score <= 0)
		return STORY_GOAL_NEUTRAL  // fallback

	var/prob_good = score_good / total_score
	var/prob_bad = score_bad / total_score
	var/prob_neutral = score_neutral / total_score
	var/prob_random = score_random / total_score

	// Roll (rand returns 0..1) with cumulative check
	var/roll = rand()
	var/cum_prob = 0

	cum_prob += prob_good
	if(roll < cum_prob && !HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_GOOD_EVENTS))
		if(SSstorytellers.hard_debug)
			message_admins("Storyteller [ctl.name] selected category: GOOD (roll=[roll], probs: G=[prob_good], B=[prob_bad], N=[prob_neutral], R=[prob_random])")
		return STORY_GOAL_GOOD

	cum_prob += prob_bad
	if(roll < cum_prob)
		if(SSstorytellers.hard_debug)
			message_admins("Storyteller [ctl.name] selected category: BAD (roll=[roll], probs: G=[prob_good], B=[prob_bad], N=[prob_neutral], R=[prob_random])")
		return STORY_GOAL_BAD

	cum_prob += prob_neutral
	if(roll < cum_prob)
		if(SSstorytellers.hard_debug)
			message_admins("Storyteller [ctl.name] selected category: NEUTRAL (roll=[roll], probs: G=[prob_good], B=[prob_bad], N=[prob_neutral], R=[prob_random])")
		return STORY_GOAL_NEUTRAL

	cum_prob += prob_random
	if(roll < cum_prob)
		if(SSstorytellers.hard_debug)
			message_admins("Storyteller [ctl.name] selected category: RANDOM (roll=[roll], probs: G=[prob_good], B=[prob_bad], N=[prob_neutral], R=[prob_random])")
		return STORY_GOAL_RANDOM

	return STORY_GOAL_NEUTRAL


// Helper to add jitter to weight: uniform rand in range for variability, scaled by volatility
/datum/storyteller_think/proc/add_weight_jitter(weight, volatility = 1.0, min_val = -0.1, max_val = 0.1)
	PRIVATE_PROC(TRUE)
	return weight + (rand(min_val * 100, max_val * 100) / 100.0) * volatility


// Helper to get repetition info for a goal id: Returns list("count"=N, "last_time"=T) from history
/datum/storyteller_think/proc/get_repeat_info(goal_id, list/recent_history)
	PRIVATE_PROC(TRUE)
	var/id_prefix = goal_id + "_"
	var/count = 0
	var/last_time = 0
	for(var/hist_id in recent_history)
		if(findtext(hist_id, id_prefix, 1, 0))
			count++
			var/list/details = recent_history[hist_id]
			var/fire_time = details["fired_ts"]
			if(fire_time > last_time)
				last_time = fire_time
	return list("count" = count, "last_time" = last_time)


// Helper for bitflag popcount: Counts set bits in a number (tags intersection)
/datum/storyteller_think/proc/popcount_tags(bits)
	PRIVATE_PROC(TRUE)
	var/count = 0
	var/temp = bits
	while(temp)
		count += (temp & 1)
		temp >>= 1
	return count


// Basic select_weighted_goal with integration to goal procs
// Computes final weight using G.get_weight (which can access vault/inputs for custom logic),
// then applies storyteller vars (difficulty, adaptation, repetition) for adaptation.
// Enhanced repetition: Gradient penalty based on recency (time since last similar) and frequency (count in history),
// scaled by adaptation (stronger post-recovery) and population (tolerable in big crews).
// Inspired by RimWorld's event weighting: base chance + modifiers from colony state (here, station metrics + history avoidance).
/datum/storyteller_think/proc/select_weighted_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, list/candidates, population_scale = 1.0, desired_tags = null)
	if(!candidates.len)
		return null

	var/list/weighted = list()
	for(var/datum/round_event_control/evt in candidates)
		if(!evt.is_avaible(inputs, ctl) && !SSstorytellers.hard_debug)
			continue

		var/base_weight = evt.get_story_weight(inputs, ctl)
		var/priority_boost = evt.get_story_priority(inputs, ctl) * STORY_PRIORITY_BOOST_SCALE
		// Adjust weight by difficulty and population: low pop = lower weight for intense events
		var/diff_adjust = ctl.difficulty_multiplier * population_scale

		// Enhanced repetition penalty: Recency (time-based decay) + frequency (count in history)
		var/rep_penalty = 0
		var/list/rep_info = get_repeat_info(evt.id, ctl.recent_events)
		var/repeat_count = rep_info["count"]
		var/last_fire_time = rep_info["last_time"]


		if(repeat_count > 0)
			var/age = world.time - last_fire_time
			var/recency_factor = clamp(1 - (age / STORY_REPETITION_DECAY_TIME), 0, 1)
			var/freq_mult = clamp(1 + (repeat_count - 1) * 0.5, 1, STORY_MAX_FREQ_MULT)
			rep_penalty = ctl.repetition_penalty * recency_factor * freq_mult


		rep_penalty *= (1 + ctl.adaptation_factor * 0.5)
		rep_penalty /= max(0.5, ctl.population_factor)


		// Threat bonus scales with population_factor: low pop = smaller threat bonus
		var/threat_mult = clamp(ctl.population_factor, 0.3, 1.0)
		var/threat_bonus = clamp(ctl.threat_points * ctl.mood.get_threat_multiplier() * STORY_PICK_THREAT_BONUS_SCALE * threat_mult, 0, STORY_MAX_THREAT_BONUS)
		var/adapt_reduce = 1.0 - ctl.adaptation_factor

		var/balance_bonus = 0
		var/tension_diff_norm = abs(bal.overall_tension - ctl.target_tension) / 100.0
		if(bal.overall_tension > ctl.target_tension && (evt.tags & STORY_TAG_DEESCALATION))
			balance_bonus += STORY_BALANCE_BONUS * tension_diff_norm
		else if(bal.overall_tension < ctl.target_tension && (evt.tags & STORY_TAG_ESCALATION))
			balance_bonus += STORY_BALANCE_BONUS * tension_diff_norm  // Scaled

		var/tag_match_bonus = 0
		if(desired_tags && evt.tags)
			var/matches = evt.tags & desired_tags
			var/num_matches = popcount_tags(matches)
			tag_match_bonus = STORY_TAG_MATCH_BONUS * num_matches

		// Final weight calculation: base weight + bonuses - penalties, scaled by difficulty and population
		// Low population reduces overall weight for intense events (bad/escalation tags)
		var/intensity_penalty = 1.0
		if((evt.tags & STORY_TAG_ESCALATION) && ctl.population_factor < 0.5)
			intensity_penalty = 0.7  // Reduce weight of escalation events at low pop

		var/duplicate_debuf = 1.0
		if(ctl.planner.is_event_in_timeline(evt))
			duplicate_debuf *= 0.4

		var/final_weight = max(0.1, ((base_weight + priority_boost + threat_bonus + balance_bonus + tag_match_bonus - rep_penalty) * diff_adjust * adapt_reduce * intensity_penalty) * duplicate_debuf)
		final_weight = add_weight_jitter(final_weight, ctl.mood.volatility)
		weighted[evt] = final_weight

	var/datum/round_event_control/selected = pick_weight_f(weighted)
	if(!selected)
		return null

	if(SSstorytellers.hard_debug)
		message_admins("Storyteller [ctl.name] selected event: [selected.id || selected.name] (final_weight=[weighted[selected]])")

	return selected

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


/datum/think_stage/proc/execute( \
	datum/storyteller/ctl,
	datum/storyteller_inputs/inputs,
	datum/storyteller_balance_snapshot/bal,
	datum/storyteller_mood/mood,
	list/context
)
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

	if(bal.antag_weak && bal.balance_ratio < 0.8)
		_apply_tag_with_context(context, mood, STORY_TAG_AFFECTS_ANTAGONIST, 80 * context[CONTEXT_BIAS])

	if(bal.get_station_resilience() < 0.5)
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

	if(bal.balance_ratio < 0.8)
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
#undef THINK_THREAT_WEIGHT
#undef STORY_PRIORITY_BOOST_SCALE
#undef STORY_MAX_FREQ_MULT
#undef STORY_MAX_THREAT_BONUS
