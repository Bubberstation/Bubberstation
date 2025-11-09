/datum/round_event_control/communications_blackout
	id = "comm_blackout"
	name = "Execute communication blackout"
	description = "Heavily EMPs all telecommunication machines, blocking all communication for a while. \
			On hight-threat levels can damage ears of tcoms users."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_AFFECTS_CREW_MIND | STORY_TAG_AFFECTS_WHOLE_STATION

	typepath = /datum/round_event/communications_blackout/storyteller


/datum/round_event/communications_blackout/storyteller
	STORYTELLER_EVENT

	announce_when = 10
	start_when = 20
	end_when = 120
	allow_random = FALSE

	var/damage_for_ears = FALSE
	COOLDOWN_DECLARE(tcom_pulse_cooldown)

/datum/round_event/communications_blackout/storyteller/__setup_for_storyteller(threat_points, ...)
	. = ..()

	if(threat_points < STORY_THREAT_LOW)
		end_when = 60
	else if(threat_points < STORY_THREAT_MODERATE)
		damage_for_ears = prob(10)
		end_when = 120
	else if(threat_points < STORY_THREAT_HIGH)
		damage_for_ears = prob(50)
		end_when = 180
	else if(threat_points < STORY_THREAT_EXTREME)
		damage_for_ears = prob(70)
		end_when = 240
	else
		damage_for_ears = TRUE
		end_when = 300


/datum/round_event/communications_blackout/storyteller/__start_for_storyteller()
	tcom_pulse()
	COOLDOWN_START(src, tcom_pulse_cooldown, 10 SECONDS)


/datum/round_event/communications_blackout/storyteller/__announce_for_storyteller()
	var/alert = pick( "Ionospheric anomalies detected. Temporary telecommunication failure imminent. Please contact you*%fj00)`5vc-BZZT",
		"Ionospheric anomalies detected. Temporary telecommunication failu*3mga;b4;'1v¬-BZZZT",
		"Ionospheric anomalies detected. Temporary telec#MCi46:5.;@63-BZZZZT",
		"Ionospheric anomalies dete'fZ\\kg5_0-BZZZZZT",
		"Ionospheri:%£ MCayj^j<.3-BZZZZZZT",
		"#4nd%;f4y6,>£%-BZZZZZZZT",
	)

	for(var/mob/living/silicon/ai/A in GLOB.ai_list)
		to_chat(A, "<br>[span_warning("<b>[alert]</b>")]<br>")
		to_chat(A, span_notice("Remember, you can transmit over holopads by right clicking on them, and can speak through them with \".[/datum/saymode/holopad::key]\"."))

	priority_announce(alert, "Anomaly Alert", sound = ANNOUNCER_COMMSBLACKOUT)
	if(!damage_for_ears)
		return

	for(var/mob/living/carbon/human/crew in get_earbzzz_candidates())
		to_chat(crew, span_warning("Can you hear the white noise from your [crew.ears.name]"))

/datum/round_event/communications_blackout/storyteller/__storyteller_tick(seconds_per_tick)
	if(COOLDOWN_FINISHED(src, tcom_pulse_cooldown))
		tcom_pulse()
		COOLDOWN_START(src, tcom_pulse_cooldown, 10 SECONDS)

/datum/round_event/communications_blackout/storyteller/__end_for_storyteller()
	. = ..()
	for(var/obj/machinery/telecomms/shhh as anything in GLOB.telecomm_machines)
		if(shhh.machine_stat & EMPED)
			shhh.set_machine_stat(shhh.machine_stat& ~EMPED)
	for(var/datum/transport_controller/linear/tram/transport as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(!isnull(transport.home_controller))
			var/obj/machinery/transport/tram_controller/tcomms/controller = transport.home_controller
			if(controller.machine_stat & EMPED)
				controller.set_machine_stat(controller.machine_stat & ~EMPED)

/datum/round_event/communications_blackout/storyteller/proc/get_earbzzz_candidates()
	PRIVATE_PROC(TRUE)
	var/list/candidates = list()

	for(var/mob/living/carbon/human/crew in GLOB.alive_player_list)
		if(!is_station_level(crew.z))
			continue
		if(!istype(crew.ears, /obj/item/radio/headset))
			continue
		var/obj/item/radio/headset/headset = crew.ears
		if(!headset.is_on() || !crew.can_hear())
			continue
		candidates += crew

	return candidates

/datum/round_event/communications_blackout/storyteller/proc/tcom_pulse()
	for(var/obj/machinery/telecomms/shhh as anything in GLOB.telecomm_machines)
		if(!(shhh.machine_stat & EMPED))
			shhh.set_machine_stat(shhh.machine_stat | EMPED)

	for(var/datum/transport_controller/linear/tram/transport as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(!isnull(transport.home_controller))
			var/obj/machinery/transport/tram_controller/tcomms/controller = transport.home_controller
			if(!(controller.machine_stat & EMPED))
				controller.set_machine_stat(controller.machine_stat | EMPED)

	if(!damage_for_ears)
		return
	for(var/mob/living/carbon/human/crew in get_earbzzz_candidates())
		var/obj/item/organ/ears/ears = crew.get_organ_slot(ORGAN_SLOT_EARS)
		if(!ears)
			continue
		ears.adjust_temporary_deafness(rand(5-15))
		SEND_SOUND(crew, sound('sound/items/weapons/flash_ring.ogg',0,1,0,250))
		to_chat(src, span_warning("Your [crew.ears.name], bursts with a terrible crack, tearing your ears apart."))
