GLOBAL_VAR_INIT(rbmk_did_warning, FALSE)

/datum/round_event_control/rbmk_voidcheck //Vibe check
	name = "RB-MK Void Excess Warning"
	typepath = /datum/round_event/rbmk_voidcheck
	category = EVENT_CATEGORY_ENGINEERING
	weight = 15
	max_occurrences = 2
	earliest_start = 30 MINUTES
	min_players = 30
	description = "Gives a warning that the station is using too much RBMK for its own good. If the event is run twice, the warning turns into consequences."
	tags = list(TAG_COMMUNAL, TAG_DESTRUCTIVE)
	track = EVENT_TRACK_MODERATE

/datum/round_event_control/rbmk_voidcheck/can_spawn_event(players_amt, allow_magic)

	if(length(GLOB.active_rbmk_machines) <= 12)
		return FALSE

	. = ..()

/datum/round_event/rbmk_voidcheck
	start_when = 1
	end_when = 2
	fakeable = FALSE

/datum/round_event/rbmk_voidcheck/start()

	var/machines_detected = length(GLOB.active_rbmk_machines)

	/*
	if(machines_detected <= 12)
		return WAITING_FOR_SOMETHING
	*/

	if(GLOB.rbmk_did_warning)

		for(var/obj/machinery/power/rbmk2/found_rbmk as anything in GLOB.active_rbmk_machines)
			if(!found_rbmk.stored_rod)
				continue
			var/datum/gas_mixture/rod_mix = found_rbmk.stored_rod.air_contents
			if(!rod_mix)
				continue
			rod_mix.assert_gas(/datum/gas/tritium)
			rod_mix.remove_specific_ratio(/datum/gas/tritium,1) //Remove all the tritium.
			var/turf/origin_turf = get_turf(found_rbmk)
			var/obj/voidout/voidout_effect = locate() in range(8,origin_turf)
			if(!voidout_effect)
				voidout_effect = new(origin_turf)
			CHECK_TICK

		priority_announce(
			"You were warned.",
			"RB-MK2 Ove%)#*%&#",
			sound = 'modular_zubbers/sound/alerts/rbmk2.ogg',
			has_important_message = TRUE
		)

	else
		priority_announce(
			"A neighboring station is detecting excess levels of Bluesp!*^#$) Void energy, which is usually a symptom of excessive RB-MK2 reactor use. \
			Please reduce the amount of active RB-MK2 reactors from [machines_detected] to 12 or risk cata@#&@(^&#^%.",
			"RB-MK2 Overuse Warning",
			sound = 'modular_zubbers/sound/alerts/rbmk1.ogg',
			has_important_message = TRUE
		)
		GLOB.rbmk_did_warning = TRUE

/datum/round_event/rbmk_voidcheck/announce(fake)
	//We do the announcement stuff in start because it involves checking and setting variables.
	return
