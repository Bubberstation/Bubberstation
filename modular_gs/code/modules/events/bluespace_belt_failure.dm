/datum/round_event_control/bluespace_belt_failure
	name = "Bluespace Belt Failure"
	description = "Causes Primitive Bluespace Belts to fail in a way identical to an EMP"
	category = EVENT_CATEGORY_ANOMALIES
	typepath = /datum/round_event/bluespace_belt_failure

	weight = 15 // should be infinite >:)

	max_occurrences = 8

	alert_observers = FALSE

/datum/round_event/bluespace_belt_failure
	var/length = 0

/datum/round_event/bluespace_belt_failure/setup()
	length = rand(25, 50)
	end_when = length
	start_when = rand(1, 5)
	announce_when = rand(0, 4)

/datum/round_event/bluespace_belt_failure/start()
	for(var/mob/living/carbon/human/C in shuffle(GLOB.alive_mob_list))
		if(!C.client)
			continue
		if(C.stat == DEAD)
			continue
		// if (HAS_TRAIT(C,TRAIT_EXEMPT_HEALTH_EVENTS))
		// 	continue
		if(!C.belt || !istype(C.belt, /obj/item/bluespace_belt/primitive))
			continue
		if(!is_station_level(C.z))
			continue
		C.belt.emp_act(length)

/datum/round_event/bluespace_belt_failure/announce(fake)
	priority_announce("Bluespace Fluctuations have been detected near the station. Certain Bluespace based equipment may stop working correctly for a short period of time.", "Bluespace Fluctuations Alert")
