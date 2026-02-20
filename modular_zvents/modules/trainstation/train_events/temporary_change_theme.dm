/datum/round_event_control/train_event/temporary_change_theme
	name = "Change moving theme"
	description = "Change current train moving theme"
	category = "Trainstation"
	typepath = /datum/round_event/train_event/emergency_stop

	var/selected_theme
	var/duration = 90

/datum/round_event_control/train_event/temporary_change_theme/can_spawn_event(players_amt, allow_magic)
	if(!SStrain_controller.is_moving())
		return FALSE
	return ..()

/datum/round_event_control/train_event/temporary_change_theme/preRunEvent()
	if(!SStrain_controller.is_moving())
		return EVENT_CANT_RUN
	return ..()

/datum/round_event/train_event/temporary_change_theme
	fakeable = FALSE
	start_when = 3
	end_when = 90

	var/theme = null
	var/last_theme = null

/datum/round_event/train_event/temporary_change_theme/setup()
	var/datum/round_event_control/train_event/temporary_change_theme/evt = control
	if(!evt || !istype(evt) || !evt.selected_theme)
		kill()
		return

	end_when = evt.duration
	theme = evt.selected_theme
	last_theme = SStrain_controller.selected_theme

/datum/round_event/train_event/temporary_change_theme/start()
	SStrain_controller.set_movement_theme(theme)

/datum/round_event/train_event/temporary_change_theme/kill()
	. = ..()
	SStrain_controller.set_movement_theme(last_theme)


/datum/round_event_control/train_event/temporary_change_theme/war
	name = "Setup war theme"
	description = "Change current train moving theme to war"
	category = "Trainstation"
	typepath = /datum/round_event/train_event/temporary_change_theme/war

	selected_theme = /datum/train_object_spawner_theme/war
	duration = 180

/datum/round_event/train_event/temporary_change_theme/war
	var/datum/looping_sound/global_sound/war_sounds = null
	COOLDOWN_DECLARE(flash_cd)

/datum/round_event/train_event/temporary_change_theme/war/setup()
	. = ..()
	war_sounds = new(start_immediately = FALSE)
	war_sounds.create_from_list(list('modular_zvents/sounds/war_sounds.ogg' = 50 SECONDS))

/datum/round_event/train_event/temporary_change_theme/war/start()
	. = ..()
	war_sounds.start()
	COOLDOWN_START(src, flash_cd, rand(3, 6) SECONDS)

/datum/round_event/train_event/temporary_change_theme/war/tick()
	if(COOLDOWN_FINISHED(src, flash_cd))
		SSdaylight.flash(COLOR_TANGERINE_YELLOW, 1 SECONDS, 0.8 SECONDS)
		COOLDOWN_START(src, flash_cd, rand(3, 6) SECONDS)

/datum/round_event/train_event/temporary_change_theme/war/kill()
	war_sounds.stop()
	QDEL_NULL(war_sounds)
	. = ..()


/datum/round_event_control/train_event/temporary_change_theme/they
	name = "Setup their theme"
	description = "Change current train moving theme to they"
	category = "Trainstation"
	typepath = /datum/round_event/train_event/temporary_change_theme/they

	selected_theme = /datum/train_object_spawner_theme/they
	duration = 120

/datum/round_event/train_event/temporary_change_theme/they
	var/datum/looping_sound/global_sound/their_sound = null
	COOLDOWN_DECLARE(lighting_flick_cd)

/datum/round_event/train_event/temporary_change_theme/they/setup()
	. = ..()
	their_sound = new(start_immediately = FALSE)
	their_sound.create_from_list(list('modular_zvents/sounds/weird_noise.ogg' = 34 SECONDS))

/datum/round_event/train_event/temporary_change_theme/they/start()
	. = ..()
	their_sound.start()

/datum/round_event/train_event/temporary_change_theme/they/tick()
	if(!COOLDOWN_FINISHED(src, lighting_flick_cd))
		return
	COOLDOWN_START(src, lighting_flick_cd, rand(8, 15) SECONDS)
	for(var/obj/machinery/light/light in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		if(!is_station_level(light.z))
			continue
		light.flicker(rand(3, 8))

	var/list/possible_messages = list(
		"You feel hopeless!",
		"They're watching me!",
		"Get them out of here!",
		"You feel that this is the end!",
		"They're everywhere, they're going to kill us!",
	)
	for(var/mob/living/crew in GLOB.alive_player_list)
		to_chat(crew, span_userdanger(pick(possible_messages)))

/datum/round_event/train_event/temporary_change_theme/they/kill()
	their_sound.stop()
	QDEL_NULL(their_sound)
	. = ..()
