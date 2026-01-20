//Here's where is magic begin
#define STORY_REPETITION_DECAY_TIME (20 MINUTES)
#define STORY_TAG_MATCH_BONUS 0.5
#define STORY_REP_PENALTY_MAX 0.5


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
	else if(category & STORY_GOAL_NEUTRAL)
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
	// First of all - we select tone of the event
	var/list/tones = list(
		STORY_TAG_EPIC = 1 * owner.get_effective_pace(),
		STORY_TAG_TRAGIC = 1 * mood.get_threat_multiplier(),
		STORY_TAG_HUMOROUS = 1 * mood.get_variance_multiplier(),
	)
	add_tag_with_bias(., pick_weight(tones), bias, 80)

	// Category-based tags
	if(category & STORY_GOAL_BAD)
		add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 40 * mood.get_threat_multiplier())
		if(prob(60 * bias))
			add_tag_with_bias(., STORY_TAG_COMBAT, bias, 50)
	else if(category & STORY_GOAL_GOOD)
		add_tag_with_bias(., STORY_TAG_DEESCALATION, bias, 50)
		if(prob(40 * bias))
			add_tag_with_bias(., STORY_TAG_SOCIAL, bias, 40)

	// Tension-based tags
	var/tension_diff = abs(bal.overall_tension - owner.target_tension) / 100.0
	if(tension_diff > 0.2)
		if(bal.overall_tension > owner.target_tension)
			add_tag_with_bias(., STORY_TAG_DEESCALATION, bias, 70 * tension_diff)
		else if(bal.overall_tension < owner.target_tension * 0.7)
			add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 70 * (1 - tension_diff))

	// Health-based tags (only if not ignored by trait)
	if(!HAS_TRAIT(owner, STORYTELLER_TRAIT_IGNORE_CREW_HEALTH))
		var/crew_health = inputs.get_entry(STORY_VAULT_AVG_CREW_HEALTH) || 100
		if(crew_health < 50)
			add_tag_with_bias(., STORY_TAG_HEALTH, bias, 60)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_MEDICAL, bias, 70)
			else if(category & STORY_GOAL_BAD)
				add_tag_with_bias(., STORY_TAG_COMBAT, bias, 40)

		var/crew_wounding = inputs.get_entry(STORY_VAULT_CREW_WOUNDING) || STORY_VAULT_NO_WOUNDS
		if(crew_wounding >= STORY_VAULT_MANY_WOUNDED)
			add_tag_with_bias(., STORY_TAG_HEALTH, bias, 50)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_MEDICAL, bias, 60)

		var/crew_diseases = inputs.get_entry(STORY_VAULT_CREW_DISEASES) || STORY_VAULT_NO_DISEASES
		if(crew_diseases >= STORY_VAULT_MAJOR_DISEASES)
			add_tag_with_bias(., STORY_TAG_HEALTH, bias, 70)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_MEDICAL, bias, 80)

	// Infrastructure-based tags (only if not ignored by trait)
	if(!HAS_TRAIT(owner, STORYTELLER_TRAIT_IGNORE_ENGI))
		var/infra_damage = inputs.get_entry(STORY_VAULT_INFRA_DAMAGE) || STORY_VAULT_NO_DAMAGE
		if(infra_damage >= STORY_VAULT_MINOR_DAMAGE)
			add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 50)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_ENGINEERING, bias, 60)
			else if(category & STORY_GOAL_BAD)
				add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 40)

		var/station_integrity = inputs.get_entry(STORY_VAULT_STATION_INTEGRITY) || 100
		if(station_integrity < 50)
			add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 60)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_ENGINEERING, bias, 70)

		var/power_status = inputs.get_entry(STORY_VAULT_POWER_STATUS) || STORY_VAULT_FULL_POWER
		if(power_status >= STORY_VAULT_LOW_POWER)
			add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 50)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_ENGINEERING, bias, 60)

		var/power_grid_damage = inputs.get_entry(STORY_VAULT_POWER_GRID_DAMAGE) || STORY_VAULT_POWER_GRID_NOMINAL
		if(power_grid_damage >= STORY_VAULT_POWER_GRID_FAILURES)
			add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 55)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_REQUIRES_ENGINEERING, bias, 65)

	// Antagonist-based tags
	var/antag_activity = inputs.get_entry(STORY_VAULT_ANTAGONIST_ACTIVITY) || STORY_VAULT_NO_ACTIVITY
	if(antag_activity >= STORY_VAULT_MODERATE_ACTIVITY)
		add_tag_with_bias(., STORY_TAG_ANTAGONIST, bias, 50)
		add_tag_with_bias(., STORY_TAG_COMBAT, bias, 40)
		if(!HAS_TRAIT(owner, STORYTELLER_TRAIT_IGNORE_SECURITY))
			add_tag_with_bias(., STORY_TAG_REQUIRES_SECURITY, bias, 50 * antag_activity)

	var/antag_count = inputs.get_entry(STORY_VAULT_ANTAG_ALIVE_COUNT) || 0
	if(antag_count > 0)
		var/antag_kills = inputs.get_entry(STORY_VAULT_ANTAG_KILLS) || STORY_VAULT_NO_KILLS
		if(antag_kills >= STORY_VAULT_MODERATE_KILLS)
			add_tag_with_bias(., STORY_TAG_COMBAT, bias, 60)
			add_tag_with_bias(., STORY_TAG_TRAGIC, bias, 50)

		if(bal.antag_weak)
			if(category & STORY_GOAL_BAD)
				add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 40)
		else if(bal.antag_inactive)
			if(category & STORY_GOAL_BAD)
				add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 30)

	// Security-based tags (only if not ignored by trait)
	if(!HAS_TRAIT(owner, STORYTELLER_TRAIT_IGNORE_SECURITY))
		var/security_strength = inputs.get_entry(STORY_VAULT_SECURITY_STRENGTH) || STORY_VAULT_NO_SECURITY
		if(security_strength >= STORY_VAULT_WEAK_SECURITY)
			add_tag_with_bias(., STORY_TAG_REQUIRES_SECURITY, bias, 30 * security_strength)
		else if(security_strength == STORY_VAULT_NO_SECURITY && category & STORY_GOAL_BAD)
			// No security - prefer events that don't require security
			add_tag_with_bias(., STORY_TAG_COMBAT, bias, 40)

		var/security_alert = inputs.get_entry(STORY_VAULT_SECURITY_ALERT) || STORY_VAULT_GREEN_ALERT
		if(security_alert >= STORY_VAULT_RED_ALERT)
			add_tag_with_bias(., STORY_TAG_COMBAT, bias, 50)
			add_tag_with_bias(., STORY_TAG_TRAGIC, bias, 40)

	// Resource-based tags (only if not ignored by trait)
	if(!HAS_TRAIT(owner, STORYTELLER_TRAIT_IGNORE_RESOURCES))
		var/minerals = inputs.get_entry(STORY_VAULT_RESOURCE_MINERALS) || 0
		if(minerals < 1000)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 40)

		var/cargo_points = inputs.get_entry(STORY_VAULT_RESOURCE_OTHER) || 0
		if(cargo_points < 5000)
			if(category & STORY_GOAL_GOOD)
				add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 35)

	// Research-based tags
	var/research_progress = inputs.get_entry(STORY_VAULT_RESEARCH_PROGRESS) || STORY_VAULT_LOW_RESEARCH
	if(research_progress >= STORY_VAULT_HIGH_RESEARCH && category & STORY_GOAL_BAD)
		add_tag_with_bias(., STORY_TAG_ENVIRONMENTAL, bias, 30)

	// Impact level tags (based on station state and tension)
	if(bal.overall_tension > 70 || bal.strengths["station"] < 0.3)
		add_tag_with_bias(., STORY_TAG_AFFECTS_WHOLE_STATION, bias, 50)
	else if(bal.overall_tension < 30)
		add_tag_with_bias(., STORY_TAG_TARGETS_INDIVIDUALS, bias, 40)
	else
		add_tag_with_bias(., STORY_TAG_WIDE_IMPACT, bias, 45)

	// Volatility random tags
	var/volatility = mood.get_variance_multiplier()
	if(volatility > 1.2 && prob(30 * bias))
		add_tag_with_bias(., STORY_TAG_CHAOTIC, bias, 30)

	// Trait-based tag modifications
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_KIND) && category & STORY_GOAL_GOOD)
		add_tag_with_bias(., STORY_TAG_SOCIAL, bias, 30)
		add_tag_with_bias(., STORY_TAG_DEESCALATION, bias, 40)

	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_NO_MERCY) && category & STORY_GOAL_BAD)
		add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 50)
		add_tag_with_bias(., STORY_TAG_COMBAT, bias, 40)

	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_BALANCING_TENSTION))
		// More aggressive balancing
		if(tension_diff > 0.15)
			if(bal.overall_tension > owner.target_tension)
				add_tag_with_bias(., STORY_TAG_DEESCALATION, bias, 80)
			else
				add_tag_with_bias(., STORY_TAG_ESCALATION, bias, 80)

	// Round progression tags
	var/round_prog = owner.round_progression || 0
	if(round_prog < 0.2)
		add_tag_with_bias(., STORY_TAG_ROUNDSTART, bias, 40)
	else if(round_prog > 0.5)
		add_tag_with_bias(., STORY_TAG_MIDROUND, bias, 50)

	// Major event tag (based on tension and station state)
	if(bal.overall_tension > 80 || bal.strengths["station"] < 0.2)
		if(category & STORY_GOAL_BAD)
			add_tag_with_bias(., STORY_TAG_MAJOR, bias, 30)

	return .


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
		score_bad += (1 - tension_diff) * 0.8

	// Mood influence
	var/mood_aggr = owner.get_effective_threat()
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
		score_good += 0.25
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_MORE_BAD_EVENTS))
		score_bad += 0.25
	if(HAS_TRAIT(owner, STORYTELLER_TRAIT_MORE_NEUTRAL_EVENTS))
		score_neutral += 0.25

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

// Random behaviour: completely random tags
/datum/storyteller_behevour/random
/datum/storyteller_behevour/random/tokenize( \
	category, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood)

	if(!category)
		category = determine_category(bal)

	. = list()
	// Completely random tag selection
	var/list/all_tags = list(
		STORY_TAG_EPIC,
		STORY_TAG_TRAGIC,
		STORY_TAG_HUMOROUS,
		STORY_TAG_COMBAT,
		STORY_TAG_SOCIAL,
		STORY_TAG_ENVIRONMENTAL,
		STORY_TAG_CHAOTIC,
		STORY_TAG_HEALTH,
		STORY_TAG_WIDE_IMPACT,
		STORY_TAG_TARGETS_INDIVIDUALS,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_REQUIRES_ENGINEERING,
		STORY_TAG_REQUIRES_MEDICAL,
		STORY_TAG_ANTAGONIST,
		STORY_TAG_MAJOR,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_MIDROUND,
	)

	// Add random tags (3-6 tags)
	var/tag_count = rand(3, 6)
	for(var/i in 1 to tag_count)
		var/selected_tag = pick(all_tags)
		if(!(selected_tag in .))
			. += selected_tag

	// Add escalation/deescalation based on category
	if(category & STORY_GOAL_BAD)
		. += STORY_TAG_ESCALATION
	else if(category & STORY_GOAL_GOOD)
		. += STORY_TAG_DEESCALATION

	return .

// Inverted behaviour: every third bad event becomes good
/datum/storyteller_behevour/inverted
	var/bad_event_counter = 0
	var/was_inverted = FALSE

/datum/storyteller_behevour/inverted/determine_category(datum/storyteller_balance_snapshot/bal)
	was_inverted = FALSE
	// Call parent first
	var/category = ..()

	// If it's a bad event, check if we should invert it
	if(category & STORY_GOAL_BAD)
		bad_event_counter++
		// Every third bad event becomes good
		if(bad_event_counter % 3 == 0)
			was_inverted = TRUE
			return STORY_GOAL_GOOD

	return category

/datum/storyteller_behevour/inverted/tokenize( \
	category, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood)

	// Call parent tokenize with potentially inverted category
	. = ..()

	// If this was an inverted bad event (now GOOD), adjust tags
	if(was_inverted)
		// Remove bad event tags and add good event tags
		. -= STORY_TAG_ESCALATION
		. -= STORY_TAG_COMBAT
		. -= STORY_TAG_TRAGIC
		. += STORY_TAG_DEESCALATION
		if(prob(50))
			. += STORY_TAG_SOCIAL
		if(prob(40))
			. += STORY_TAG_HUMOROUS

	return .

#undef STORY_REPETITION_DECAY_TIME
#undef STORY_TAG_MATCH_BONUS
#undef STORY_REP_PENALTY_MAX
