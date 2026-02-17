// Базовый /datum/antagonist

/datum/antagonist
	var/initial_weight = STORY_DEFAULT_ANTAG_WEIGHT
	var/datum/component/antag_metric_tracker/tracker

/datum/antagonist/proc/get_effectivity()
	if(antag_flags & ANTAG_FAKE || !tracker)
		return 0.5

	var/datum/component/antag_metric_tracker/T = tracker
	if(!T || T.is_dead)
		return 0.3

	var/time_factor = T.lifetime > 0 ? clamp(T.lifetime / (world.time * 0.5), 0, 1) : 0
	var/kill_factor  = clamp(T.kills / 4, 0, 1)

	return round(0.5 + time_factor * 0.75 + kill_factor * 0.75, 0.1)

/datum/antagonist/proc/get_weight()
	if(antag_flags & ANTAG_FAKE || !tracker)
		return initial_weight * 0.5

	return initial_weight * get_effectivity()


/datum/antagonist/on_gain()
	. = ..()
#ifdef UNIT_TESTS
	return
#endif
	if(antag_flags & ANTAG_FAKE)
		return
	var/mob/living/L = owner?.current
	if(istype(L))
		tracker = owner.GetComponent(/datum/component/antag_metric_tracker)
		if(!tracker)
			tracker = owner.AddComponent(/datum/component/antag_metric_tracker, owner)


/datum/antagonist/abductor
	initial_weight = STORY_MINOR_ANTAG_WEIGHT * 1.4

/datum/antagonist/abductor/get_effectivity()
	var/datum/team/abductor_team/team = get_team()
	if(!team || team.abductees.len <= 0)
		return 0.5

	var/total_abductees = max(1, team.abductees.len)
	return round(0.5 + (2 / total_abductees) * 0.5, 2)


/datum/antagonist/blob
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT * 0.8

/datum/antagonist/blob/get_effectivity()
	if(!isovermind(owner?.current))
		return 0.5

	var/mob/eye/blob/overmind = owner.current
	var/total_blobs   = max(1, overmind.blobs_legit.len)
	var/total_points  = max(1, overmind.blob_points)
	var/core_health   = overmind.blob_core ? (overmind.blob_core.max_integrity / max(1, overmind.blob_core.integrity_failure)) : 0

	var/tracker_factor = tracker ? clamp(tracker.lifetime / 600, 0, 1.5) : 0.5  // ~10 минут = 1.0

	return clamp(0.25 + (total_blobs / 10)*0.35 + (total_points / 100)*0.25 + core_health*0.15 + tracker_factor*0.2, 0, 2)

/datum/antagonist/blob/get_weight()
	if(!isovermind(owner?.current))
		return 0.5
	var/mob/eye/blob/overmind = owner.current
	return clamp(1 + (overmind.blobs_legit.len / 5), 1, STORY_MAJOR_ANTAG_WEIGHT * 2)


/datum/antagonist/brother
	initial_weight = STORY_MINOR_ANTAG_WEIGHT

/datum/antagonist/brother/get_effectivity()
	var/datum/team/brother_team/team = get_team()
	if(!team || team.brothers_left <= 0)
		return 0.5

	var/total_brothers = max(1, team.brothers_left)
	if(total_brothers == 1)
		return 0.5
	return clamp(0.5 + (2 / total_brothers) * 0.5, 0.1, 2)


/datum/antagonist/changeling
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT

/datum/antagonist/changeling/get_effectivity()
	if(!tracker || tracker.lifetime <= 0)
		return 0.5

	var/absorb_factor = absorbed_count > 0 ? (true_absorbs / absorbed_count) : 0
	var/power_factor  = length(purchased_powers) > 0 ? 1 : 0

	var/base = 0.5 + 0.5 * absorb_factor * power_factor
	base = clamp(base, 0, 1.5)

	return round(base / (tracker.lifetime * 0.01), 2)


/datum/antagonist/cult
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT

/datum/antagonist/cult/get_effectivity()
	var/datum/team/cult/team = get_team()
	if(!team || team.size_at_maximum <= 0)
		return 0.5

	var/base = 0.25 + (team.size_at_maximum / 10)
	if(team.cult_risen)
		base += 0.4
	if(team.cult_ascendent)
		base += 0.5

	base = clamp(base, 0, 2)
	return base / max(1, team.size_at_maximum)


/datum/antagonist/cult/get_weight()
	var/datum/team/cult/team = get_team()
	if(!team)
		return 0.5
	return clamp(1 + (team.size_at_maximum / 2), 1, STORY_DEFAULT_ANTAG_WEIGHT * 5)


/datum/antagonist/heretic
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT

/datum/antagonist/heretic/get_effectivity()
	if(ascended)
		return 2.0
	var/sacrifice_ratio = total_sacrifices > 0 ? high_value_sacrifices / total_sacrifices : 0
	return clamp(sacrifice_ratio * 2, 0, 2)

/datum/antagonist/heretic/get_weight()
	return ascended ? STORY_MAJOR_ANTAG_WEIGHT : initial_weight * get_effectivity()


/datum/antagonist/malf_ai
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT * 1.2

/datum/antagonist/malf_ai/get_effectivity()
	if(!isAI(owner?.current) || !tracker || tracker.lifetime <= 0)
		return 0.5

	var/mob/living/silicon/ai/ai = owner.current
	var/hacked_apcs = length(ai.hacked_apcs)
	var/hacked_borgs = length(ai.connected_robots)

	if(hacked_apcs <= 0)
		return 0.5

	var/activity = (hacked_apcs * 0.1) + (hacked_borgs * 0.3)
	return clamp(0.5 + activity / (tracker.lifetime * 0.01), 0, 2)


/datum/antagonist/nightmar
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT * 0.7

/datum/antagonist/nightmare/get_effectivity()
	var/base = ..()
	if(!tracker)
		return base
	return clamp(base + (tracker.lifetime * 0.005) + (tracker.kills * 0.15), 0, 2)



/datum/antagonist/ninja
	initial_weight = STORY_MEDIUM_ANTAG_WEIGHT * 1.2

/datum/antagonist/ninja/get_effectivity()
	var/base = ..()
	if(!tracker)
		return base
	return clamp(base + (tracker.lifetime * 0.008), 0, 2)


/datum/antagonist/nukeop
	initial_weight = STORY_MAJOR_ANTAG_WEIGHT * 1.5

/datum/antagonist/nukeop/get_effectivity()
	var/base = 1
	if(!tracker)
		return base * 0.5

	var/datum/team/nuclear/nuke_team = get_team()
	var/war_declared = FALSE
	if(nuke_team)
		var/obj/item/nuclear_challenge/challenge = nuke_team.war_button_ref?.resolve()
		war_declared = !!challenge?.declaring_war

	return clamp(base + (tracker.lifetime * 0.008) + (tracker.kills * 0.18) + (war_declared ? 0.5 : 0), 0, 2)


/datum/antagonist/traitor
	initial_weight = STORY_MINOR_ANTAG_WEIGHT * 1.1

/datum/antagonist/traitor/get_effectivity()
	if(!tracker || tracker.lifetime < 1)
		return 0.5

	if(tracker.lifetime < 20 MINUTES)
		return 0.5

	return clamp(0.5 + (tracker.kills * 0.2) + (tracker.lifetime / (world.time || 1)) * 0.1, 0, 2)
