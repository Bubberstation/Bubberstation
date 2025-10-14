/datum/storyteller_goal/execute_event/zzzzzt
	id = "zzzzzt"
	name = "ZZZZZT"
	desc = "A massive power surge."
	children = list()
	category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION
	event_path = /datum/round_event/zzzzzt

	requierd_population = 1

/datum/round_event/zzzzzt
	var/maximum_charge = 50 KILO JOULES
	allow_random = FALSE
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
	for(var/mob/living/carbon/human/H in shuffle(GLOB.alive_mob_list))
		if(attempts > 10)
			return
		if(!H.client)
			continue
		if(H.stat == DEAD)
			continue
		if(!(H.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
			continue
		if(!engaged_role_play_check(H, station = TRUE, dorms = TRUE))
			continue
		closest = pick_closest_cable(H)
		if(!closest)
			attempts++
			continue
		bad_luck = H
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
	explosion(closest, 0, 0, 5, 4)
	closest.Beam(bad_luck, "lightning1", emissive = FALSE, time = 1 SECONDS)
	bad_luck.electrocute_act(rand(60-70), src, 1.0, SHOCK_NOGLOVES | SHOCK_TESLA)
	QDEL_IN(closest, 1 SECONDS)


/datum/round_event/zzzzzt/proc/pick_closest_cable(mob/living/carbon/human/bad_luck)
	for(var/turf/check_turf in RANGE_TURFS(2, bad_luck))
		var/obj/structure/cable/C = locate(/obj/structure/cable) in check_turf

		if(!istype(C) || C == null)
			continue
		return C
