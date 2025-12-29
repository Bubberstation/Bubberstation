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

#define STORY_REP_PENALTY_MAX 0.5

#define THINK_THREAT_WEIGHT 0.05
#define STORY_PRIORITY_BOOST_SCALE 0.4
#define STORY_MAX_FREQ_MULT 1.2
#define STORY_MAX_THREAT_BONUS 0.4
#define STORY_MAX_REP_PENALTY 1.0


/datum/storyteller_behevour
	VAR_PRIVATE/datum/storyteller/owner

/datum/storyteller_behevour/New(datum/storyteller/owner_storyteller)
	. = ..()
	owner = owner_storyteller

// Review tags and return a list of tags that are relevant to the storyteller's behevour
/datum/storyteller_behevour/proc/review_tags(list/tags, datum/storyteller_balance_snapshot/bal, datum/storyteller_inputs/inputs)
	return tags

/datum/storyteller_behevour/proc/is_event_valid_for_behevour(datum/round_event_control/evt, datum/storyteller_balance_snapshot/bal, datum/storyteller_inputs/inputs)
	return TRUE


/datum/storyteller_behevour/proc/get_next_event(datum/storyteller_balance_snapshot/bal, datum/storyteller_inputs/inputs)
	var/category = determine_category(bal)
	var/tag_filter = tokenize(category, inputs, bal, owner.mood)
	if(!length(tag_filter))
		return null
	review_tags(tag_filter, bal, inputs)
	var/list/candidates = SSstorytellers.filter_goals(category, tag_filter, null, FALSE)
	if(!candidates.len)
		candidates = SSstorytellers.filter_goals(STORY_GOAL_RANDOM)
	return select_weighted_goal(inputs, bal, candidates, owner.population_factor, tag_filter)


/datum/storyteller_behevour/proc/get_category_bias(category, datum/storyteller_mood/mood)
	PRIVATE_PROC(TRUE)

	var/bias = 1
	if(category & STORY_GOAL_GOOD)
		if(mood.get_variance_multiplier() > 1)
			bias = 0.8
		else
			bias = 1.1
	else if(category & STORY_GOAL_BAD)
		if(mood.get_threat_multiplier() > 1)
			bias = 1.4
		else
			bias = 0.8
	else if(category && STORY_GOAL_NEUTRAL)
		bias = 0.6
	else
		bias = 0.5
	return bias


/datum/storyteller_behevour/proc/add_tag_with_bias(list/tags, tag, bias, probability)
	if(prob(probability * bias))
		LAZYADD(tags, tag)


/datum/storyteller_behevour/proc/tokenize( \
	category, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood)

	if(!category)
		category = determine_category(bal)

	var/bias = get_category_bias(category, mood)
	. = list()
	/**
	 * Okay, here we are basicly perform storyteller thinking by anylizing the content of inputs.
	 */
	// First of of all - we select tone of the event
	var/list/tones = list(
		STORY_TAG_EPIC = 1 * owner.get_effective_pace(),
		STORY_TAG_TRAGIC = 1 * mood.get_threat_multiplier(),
		STORY_TAG_HUMOROUS = 1 * mood.get_variance_multiplier(),
	)
	add_tag_with_bias(., pick_weight(tones), bias, 80)

	// Then let's select targeting level




	if(category & STORY_GOAL_BAD)
		add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 40 * mood.get_threat_multiplier())

	var/security_forces = inputs.get_entry(STORY_VAULT_SECURITY_STRENGTH)
	if(security_forces >= STORY_VAULT_WEAK_SECURITY)
		add_tag_with_bias(., STORY_TAG_REQUIRES_SECURITY, bias, 30 * security_forces)


	return .

/*

	// Category-based tags
	if(category & STORY_GOAL_BAD)
		desired_tags += STORY_TAG_ESCALATION
		if(prob(60))
			desired_tags += STORY_TAG_COMBAT
	else if(category & STORY_GOAL_GOOD)
		desired_tags += STORY_TAG_DEESCALATION
		if(prob(40))
			desired_tags += STORY_TAG_SOCIAL

	// Tension-based tags
	if(bal.overall_tension > owner.target_tension)
		if(prob(70))
			desired_tags += STORY_TAG_DEESCALATION
	else if(bal.overall_tension < owner.target_tension * 0.7)
		if(prob(70))
			desired_tags += STORY_TAG_ESCALATION

	// Health-based tags
	var/crew_health = inputs.vault[STORY_VAULT_AVG_CREW_HEALTH] || 100
	if(crew_health < 50)
		if(prob(60))
			desired_tags += STORY_TAG_AFFECTS_CREW_HEALTH
			if(category & STORY_GOAL_GOOD)
				desired_tags += STORY_TAG_REQUIRES_MEDICAL

	// Infrastructure-based tags
	var/infra_damage = inputs.vault[STORY_VAULT_INFRA_DAMAGE] || STORY_VAULT_NO_DAMAGE
	if(infra_damage >= STORY_VAULT_MINOR_DAMAGE)
		if(prob(50))
			desired_tags += STORY_TAG_ENVIRONMENTAL
			if(category & STORY_GOAL_GOOD)
				desired_tags += STORY_TAG_REQUIRES_ENGINEERING

	// Antagonist-based tags
	var/antag_activity = inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || STORY_VAULT_NO_ACTIVITY
	if(antag_activity >= STORY_VAULT_MODERATE_ACTIVITY)
		if(prob(50))
			desired_tags += STORY_TAG_AFFECTS_SECURITY
			desired_tags += STORY_TAG_REQUIRES_SECURITY

/*
	// Resource-based tags
	var/minerals = inputs.vault[STORY_VAULT_RESOURCE_MINERALS] || 0
	if(minerals < 100)
		if(prob(40))
			desired_tags += STORY_TAG_AFFECTS_RESOURCES

	// Volatility random tags
	if(mood.volatility > 1.2 && prob(30))
		desired_tags += STORY_TAG_CHAOTIC
*/

*/


/datum/storyteller_behevour/proc/select_weighted_goal( \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	list/candidates, \
	population_scale = 1.0, \
	desired_tags = null)

	if(!candidates.len)
		return null

	var/list/weighted = list()

	for(var/datum/round_event_control/evt in candidates)
		if(!evt.is_avaible(inputs, owner))
			continue

		if(!(evt.story_category & STORY_GOAL_MAJOR) && HAS_TRAIT(owner, STORYTELLER_TRAIT_NO_MAJOR_EVENTS))
			continue

		if(!is_event_valid_for_behevour(evt))
			continue

		// Base weight
		var/weight = evt.get_story_weight(inputs, owner)

		// Repetition penalty (simplified)
		var/list/rep_info = owner.get_repeat_info(evt.id)
		if(rep_info["count"] > 0)
			var/age = world.time - rep_info["last_time"]
			var/decay = clamp(1 - (age / STORY_REPETITION_DECAY_TIME), 0, 1)
			weight *= (1 - decay * STORY_REP_PENALTY_MAX)

		// Tag match bonus
		if(desired_tags && length(desired_tags))
			var/matches = 0
			for(var/tag in desired_tags)
				if(evt.has_tag(tag))
					matches += 1
			if(matches > 0)
				weight *= (1 + matches * STORY_TAG_MATCH_BONUS)

		var/tension_diff = abs(bal.overall_tension - owner.target_tension) / 100.0
		if(tension_diff > 0.2)
			// Check if event helps balance
			var/has_escalation = evt.has_tag(STORY_TAG_ESCALATION)
			var/has_deescalation = evt.has_tag(STORY_TAG_DEESCALATION)

			if(bal.overall_tension > owner.target_tension && has_deescalation)
				weight *= (1 + tension_diff * 0.3)
			else if(bal.overall_tension < owner.target_tension && has_escalation)
				weight *= (1 + tension_diff * 0.3)

		// Population scaling
		weight *= clamp(population_scale, 0.5, 1.0)

		// Difficulty scaling
		weight *= owner.difficulty_multiplier

		// Duplicate check
		if(owner.planner.is_event_in_timeline(evt))
			weight *= 0.3

		weighted[evt] = max(0.1, weight)

	if(!length(weighted))
		return null

	// Random mode
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_HARDCORE_RANDOM))
		return pick(weighted)

	// Weighted selection
	return pick_weight(weighted)


/datum/storyteller_behevour/proc/determine_category(datum/storyteller_balance_snapshot/bal)
	var/tension = bal.overall_tension
	var/target = owner.target_tension
	var/tension_diff = abs(tension - target) / 100.0

	// Simple scoring
	var/score_good = 0
	var/score_bad = 0
	var/score_neutral = 0.3 // Base neutral chance

	// High tension -> prefer good events (recovery)
	if(tension > target)
		score_good += tension_diff * 0.8
	// Low tension -> prefer bad events (challenge)
	else if(tension < target)
		score_bad += (1 - tension_diff) * 0.6

	// Mood influence
	var/mood_aggr = owner.mood.get_threat_multiplier()
	score_bad += (mood_aggr - 1.0) * 0.3

	// Population scaling
	var/pop = clamp(owner.population_factor, 0.3, 1.0)
	score_bad *= pop
	if(pop < 0.5)
		score_good += 0.2

	// Trait modifiers
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_NO_GOOD_EVENTS))
		score_good = 0
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_MORE_GOOD_EVENTS))
		score_good += 0.3
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_MORE_BAD_EVENTS))
		score_bad += 0.3
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_MORE_NEUTRAL_EVENTS))
		score_neutral += 0.3

	// Random volatility
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_HARDCORE_RANDOM))
		return pick(STORY_GOAL_GOOD, STORY_GOAL_BAD, STORY_GOAL_NEUTRAL)

	// Normalize and pick
	var/total = score_good + score_bad + score_neutral
	if(total <= 0)
		return STORY_GOAL_NEUTRAL

	var/roll = rand()
	if(roll < score_good / total)
		return STORY_GOAL_GOOD
	else if(roll < (score_good + score_bad) / total)
		return STORY_GOAL_BAD
	else
		return STORY_GOAL_NEUTRAL
