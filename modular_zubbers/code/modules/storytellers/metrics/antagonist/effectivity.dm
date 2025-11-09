/datum/antagonist
	var/initial_weight = STORY_DEFAULT_ANTAG_WEIGHT


// Base antag effectiveness from 0 to 2, where 1 is average
/datum/antagonist/proc/get_effectivity()
	if(antag_flags & ANTAG_FAKE)
		return 0

	// Base effectiveness derived from tracker aggregation, normalized to 0..1
	var/datum/component/antag_metric_tracker/T = owner.GetComponent(/datum/component/antag_metric_tracker)
	if(!T)
		return 0.5
	var/score = 0
	// Weights tuned for general case
	score += clamp(T.damage_dealt / 300, 0, 1) * 0.25
	score += clamp(T.activity_time / (world.time / 20), 0, 1) * 0.25
	score += clamp(T.kills / 3, 0, 1) * 0.15
	score += clamp(T.objectives_completed / 3, 0, 1) * 0.2
	score += clamp(T.disruption_score / 50, 0, 1) * 0.1
	score += clamp(T.influence_score / 50, 0, 1) * 0.05
	return clamp(score, 0, 2)

/datum/antagonist/proc/get_weight()
	if(antag_flags & ANTAG_FAKE)
		return 0
	return can_elimination_hijack == ELIMINATION_PREVENT ? STORY_DEFAULT_WEIGHT : initial_weight

// Attach tracker when an antagonist datum is gained
/datum/antagonist/on_gain()
	. = ..()

#ifdef UNIT_TESTS
	return
#endif

	if(antag_flags & ANTAG_FAKE)
		return
	var/mob/living/tracked = owner?.current
	if(!tracked)
		return

	AddComponent(/datum/component/antag_metric_tracker, owner)


/datum/antagonist/abductor
	initial_weight = STORY_MINOR_ANTAG_WEIGHT * 1.4


/datum/antagonist/abductor/get_effectivity()
	var/datum/team/abductor_team/team = get_team()
	if(!team)
		return 0.5
	var/total_abductees = max(1, team.abductees.len)
	if(total_abductees == 0)
		return 0.5
	return round(0.5 + ((2 / total_abductees) * 0.5), 2)


/datum/antagonist/blob
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT * 0.8


/datum/antagonist/blob/get_effectivity()
	if(!isovermind(owner?.current))
		return 0.5
	var/mob/eye/blob/overmind = owner.current
	var/total_blobs = overmind.blobs_legit.len || 1
	var/total_points = overmind.blob_points || 1
	var/core_health = overmind.blob_core ? overmind.blob_core.max_integrity / overmind.blob_core.integrity_failure : 0
	return clamp(0.25 + (total_blobs / 10) * 0.35 + (total_points / 100) * 0.25 + core_health * 0.15, 0, 2)

/datum/antagonist/blob/get_weight()
	if(!isovermind(owner?.current))
		return 0.5
	var/mob/eye/blob/overmind = owner.current
	return clamp(1 + (overmind.blobs_legit.len / 5), 1, STORY_DEFAULT_ANTAG_WEIGHT * 5)



/datum/antagonist/brother
	initial_weight = STORY_MINOR_ANTAG_WEIGHT

/datum/antagonist/brother/get_effectivity()
	var/datum/team/brother_team/team = get_team()
	if(!team)
		return 0.5
	var/total_brothers = max(1, team.brothers_left)
	if(total_brothers == 1)
		return 0.5
	return clamp(0.5 + ((2 / total_brothers) * 0.5), 0.1, 2)



/datum/antagonist/changeling
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT

/datum/antagonist/changeling/get_effectivity()
	var/datum/component/antag_metric_tracker/T = owner.GetComponent(/datum/component/antag_metric_tracker)
	var/base = 0.5
	base = round((true_absorbs / absorbed_count) * purchased_powers ? \
			clamp(base + (0.5 * (true_absorbs / absorbed_count)), 0, 1) : base, 2)
	return base / T.activity_time * 0.01

/datum/antagonist/cult
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT

/datum/antagonist/cult/get_effectivity()
	var/datum/team/cult/team = get_team()
	if(!team)
		return 0.5
	var/base = clamp(0.25 + (team.size_at_maximum / 10) + (2 * team.cult_risen ? 0.4 : 0) + (2 * team.cult_ascendent ? 0.5 : 0) , 0, 2)
	return base / team.size_at_maximum //Determinate of effectivity of each cultist

/datum/antagonist/cult/get_weight()
	var/datum/team/cult/team = get_team()
	if(!team)
		return 0.5
	return clamp(1 + (team.size_at_maximum / 2), 1, STORY_DEFAULT_ANTAG_WEIGHT * 5)


/datum/antagonist/heretic
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT

/datum/antagonist/heretic/get_effectivity()
	if(ascended)
		return 2
	return clamp(high_value_sacrifices / total_sacrifices * 2, 0, 2)

/datum/antagonist/heretic/get_weight()
	return ascended ? STORY_MAJOR_ANTAG_WEIGHT : initial_weight * get_effectivity()


/datum/antagonist/malf_ai
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT * 1.2


/datum/antagonist/malf_ai/get_effectivity()
	if(!isAI(owner?.current))
		return 0
	var/datum/component/antag_metric_tracker/M = owner.GetComponent(/datum/component/antag_metric_tracker)
	var/mob/living/silicon/ai/ai = owner.current
	var/hacked_apcs = ai.hacked_apcs.len
	var/hacked_borgs = length(ai.connected_robots)
	if(!hacked_apcs || hacked_apcs <= 0)
		return 0.5
	return clamp(hacked_apcs * 0.1 * hacked_borgs * 0.3 / M.activity_time * 0.01 + 0.5, 0, 2)

/datum/antagonist/malf_ai/get_weight()
	return clamp(STORY_MAJOR_ANTAG_WEIGHT * get_effectivity(), 0, STORY_DEFAULT_ANTAG_WEIGHT * 5)


/datum/antagonist/nightmare
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT * 0.7

/datum/antagonist/nightmare/get_effectivity()
	var/base = ..()
	var/datum/component/antag_metric_tracker/M = owner.GetComponent(/datum/component/antag_metric_tracker)
	return clamp(base + (M.activity_time * 0.01) * (M.kills * 0.2), 0, 2)

/datum/antagonist/nightmare/get_weight()
	return clamp(STORY_MEDIUM_ANTAG_WEIGHT * get_effectivity(), 0, STORY_MAJOR_ANTAG_WEIGHT)


/datum/antagonist/ninja
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT * 1.2

/datum/antagonist/ninja/get_effectivity()
	var/base = ..()
	var/datum/component/antag_metric_tracker/M = owner.GetComponent(/datum/component/antag_metric_tracker)
	return clamp(base + (M.activity_time * 0.01) * (M.objectives_completed * 0.2), 0, 2)

/datum/antagonist/ninja/get_weight()
	return clamp(STORY_MEDIUM_ANTAG_WEIGHT * get_effectivity(), 0, STORY_MAJOR_ANTAG_WEIGHT)


/datum/antagonist/nukeop
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT * 1.5 // They're a big deal

// It's calculate for whole team
/datum/antagonist/nukeop/get_effectivity()
	var/base = 1
	var/datum/component/antag_metric_tracker/M = owner.GetComponent(/datum/component/antag_metric_tracker)
	if(!M)
		return base * 0.5
	var/datum/team/nuclear/nuke_team = get_team()

	var/war_declared = FALSE
	if(!nuke_team)
		var/obj/item/nuclear_challenge/challenge = nuke_team.war_button_ref.resolve()
		if(challenge)
			war_declared = !!challenge?.declaring_war
	return clamp(base + (M.activity_time * 0.01) * (M.kills * 0.2) + (war_declared ? 0.5 : 0), 0, 2)

/datum/antagonist/nukeop/get_weight()
	return clamp(STORY_MAJOR_ANTAG_WEIGHT * get_effectivity(), 0, STORY_MAJOR_ANTAG_WEIGHT * 2)


/datum/antagonist/traitor
	initial_weight = STORY_MINOR_ANTAG_WEIGHT * 1.1


/datum/antagonist/traitor/get_effectivity()
	. = ..()
	var/datum/component/antag_metric_tracker/M = owner.GetComponent(/datum/component/antag_metric_tracker)
	if(M.activity_time < 20 MINUTES)
		return 0.5
	return clamp(0.5 + (M.objectives_completed * 0.3) + (M.kills * 0.2) + (M.activity_time / world.time) * 0.1, 0, 2)

/datum/antagonist/traitor/get_weight()
	return clamp(ending_objective ? STORY_MAJOR_ANTAG_WEIGHT : initial_weight * get_effectivity(), 0, STORY_MAJOR_ANTAG_WEIGHT)
