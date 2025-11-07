/datum/round_event_control/zzzzzt
	id = "zzzzzt"
	name = "ZZZZZT"
	description = "A massive power surge."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION
	typepath = /datum/round_event/zzzzzt

	min_players = 2

/datum/round_event/zzzzzt
	var/maximum_charge = 50 KILO JOULES
	start_when = 10

/datum/round_event/zzzzzt/__setup_for_storyteller(threat_points, ...)
	. = ..()
	maximum_charge = 50 KILO JOULES + ((threat_points/10) * 10 KILO JOULES)

/datum/round_event/zzzzzt/__announce_for_storyteller()
	priority_announce("Anomalous power surge detected in [station_name()]'s powernet. \
					Crew members in close proximity to power cables may be at risk of electrocution.", "Zzzzzzzt")

/datum/round_event/zzzzzt/__start_for_storyteller()
	var/attempts = 0
	var/mob/living/carbon/human/bad_luck
	var/obj/structure/cable/closest
	for(var/mob/living/carbon/human/unluck in get_alive_station_crew(only_crew = FALSE))
		if(attempts > 30)
			return
		if(!unluck.client)
			continue
		if(unluck.stat == DEAD)
			continue
		if(!(unluck.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
			continue
		if(!engaged_role_play_check(unluck, station = TRUE, dorms = TRUE))
			continue
		closest = pick_closest_cable(unluck)
		if(!closest)
			attempts++
			continue
		bad_luck = unluck
	if(!bad_luck)
		return // This time - no bad luck for you

	var/power_sources = 0
	for(var/obj/machinery/power/smes/cell in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/smes))
		if(cell.powernet == closest.powernet)
			cell.adjust_charge(-maximum_charge)
			if(cell.charge <= 0)
				explosion(cell, 0, 0, 3, 2)
			power_sources += 1

	if(power_sources == 0)
		return // No power sources on this network - no bad luck for you
	explosion(closest, 0, 0, 1, 3)
	for(var/mob/living/living_mob in range(closest, 2))
		if(living_mob.stat == DEAD)
			continue
		if(!engaged_role_play_check(living_mob, station = TRUE, dorms = TRUE))
			continue
		// Zap them!
		living_mob.electrocute_act(rand(60-70), src, 1.0, SHOCK_NOGLOVES | SHOCK_TESLA)
		closest.Beam(living_mob, "lightning1", emissive = FALSE)
		if(living_mob == bad_luck)
			living_mob.visible_message("[living_mob] is struck by a massive power surge from the cable!", "You are struck by a massive power surge from the cable!")
	qdel(closest)


/datum/round_event/zzzzzt/proc/pick_closest_cable(mob/living/carbon/human/bad_luck)
	var/obj/structure/cable/closest_cable
	var/closest_dist = INFINITY
	for(var/turf/check_turf in RANGE_TURFS(2, bad_luck))
		var/obj/structure/cable/cab = locate() in check_turf.contents
		if(!cab)
			continue
		var/dist = get_dist(bad_luck, cab)
		if(dist < closest_dist)
			closest_dist = dist
			closest_cable = cab
	return closest_cable
