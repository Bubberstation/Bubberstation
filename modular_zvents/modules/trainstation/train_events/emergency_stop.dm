/datum/round_event_control/train_event/emergency_stop
	name = "Emergyncy stop"
	description = "Force the train to make an emergency stop"
	category = "Trainstation"
	typepath = /datum/round_event/train_event/emergency_stop

	var/datum/train_station/emergy_station = null

/datum/round_event_control/train_event/emergency_stop/can_spawn_event(players_amt, allow_magic)
	if(!SStrain_controller.is_moving())
		return FALSE
	return ..()

/datum/round_event_control/train_event/emergency_stop/preRunEvent()
	if(!SStrain_controller.is_moving())
		return EVENT_CANT_RUN
	return ..()

/datum/round_event/train_event/emergency_stop
	announce_when = 3
	start_when = 30
	end_when = 1000
	fakeable = FALSE
	var/datum/train_station/to_load = null
	var/datum/train_station/planned_previous = null

/datum/round_event/train_event/emergency_stop/setup()
	var/datum/round_event_control/train_event/emergency_stop/evt = control
	if(!evt || !istype(evt) || !evt.emergy_station)
		kill()
		return
	to_load = evt.emergy_station
	RegisterSignal(SStrain_controller, COMSIG_TRAINSTATION_LOADED, PROC_REF(on_emergency_loaded), TRUE)

/datum/round_event/train_event/emergency_stop/announce(fake)
	priority_announce("Due to unforeseen circumstances on the track, the train will stop at station [to_load.name], \
						please prepare for braking within the next 30 seconds!", "Emergency stop", 'modular_zvents/sounds/train_horn.ogg')


/datum/round_event/train_event/emergency_stop/start()
	planned_previous = SStrain_controller.planned_to_load
	SStrain_controller.planned_to_load = to_load
	SStrain_controller.time_to_next_station = 0
	for(var/mob/living/passanger in GLOB.alive_mob_list)
		if(!is_station_level(passanger.z))
			continue
		to_chat(passanger, span_userdanger("You feel a strong jolt as the train brakes unexpectedly!"))
		passanger.Knockdown(3 SECONDS)
		passanger.throw_at(get_step(passanger, REVERSE_DIR(SStrain_controller.abstract_moving_direction)), 3, 2, spin = TRUE)

/datum/round_event/train_event/emergency_stop/proc/on_emergency_loaded()
	SIGNAL_HANDLER

	UnregisterSignal(SStrain_controller, COMSIG_TRAINSTATION_LOADED)
	SStrain_controller.planned_to_load = planned_previous
	kill()


/datum/round_event_control/train_event/emergency_stop/station_a13
	name = "Emergency stop - station A13"
	emergy_station = /datum/train_station/emergency_station_a13
