/datum/round_event_control/train_event/nuke_effect
	name = "Nuclear explosion"
	description = "Creates effcets of nuclear explosion"
	typepath = /datum/round_event/train_event/nuke

/datum/round_event/train_event/nuke
	announce_when = 10
	end_when = 1000

/datum/round_event/train_event/nuke/setup()
	. = ..()
	start_when = announce_when + 13

/datum/round_event/train_event/nuke/announce(fake)
	priority_announce("We have detected the activation of a portable nuclear device 15 kilometers away from you. Prepare for impact!", \
					"Nuclear alarm" ,'modular_zvents/sounds/mobs/sirenhead/siren_alarm_air.ogg')

/datum/round_event/train_event/nuke/start()
	INVOKE_ASYNC(src, PROC_REF(caboom))
	addtimer(CALLBACK(src, PROC_REF(run_postnuke)), 38 SECONDS)

/datum/round_event/train_event/nuke/proc/caboom()
	SSdaylight.flash("#fcc95b", 15 SECONDS, 0.3 SECONDS)
	sleep(0.8 SECONDS)

	flash_peoples()
	sleep(10 SECONDS)
	sound_wave()
	sleep(1 SECONDS)
	impact_wave()

/datum/round_event/train_event/nuke/proc/flash_peoples()
	for(var/mob/living/player in GLOB.alive_player_list)
		if(QDELETED(player))
			continue
		to_chat(player, span_danger("You see a flash of light!"))
		for(var/turf/open/T in view(player, 5))
			var/area/turf_area = get_area(T)
			if(!turf_area.outdoors || !can_see(player, T))
				continue
			flash_and_burn(player, T)
			break
	return


/datum/round_event/train_event/nuke/proc/flash_and_burn(mob/living/target, turf/affect_turf)
	var/flash_result = target.flash_act(4, override_blindness_check = TRUE, affect_silicon = TRUE, length = 5 SECONDS)
	if(flash_result)
		to_chat(target, span_userdanger("A massive flash of light from afar blinds you!"))
	if(prob(20 * max(1, (5 - get_dist(target, affect_turf)))))
		target.adjust_fire_stacks(rand(3, 4))
	return


/datum/round_event/train_event/nuke/proc/sound_wave()
	sound_to_playing_players('modular_zvents/sounds/thefinalstation/nuke_ex.ogg')
	for(var/mob/living/player in GLOB.alive_player_list)
		if(prob(30))
			player.soundbang_act(SOUNDBANG_STRONG)

		if(QDELETED(player) || !prob(60))
			continue

		for(var/obj/structure/window/window in view(player, 5))
			var/should_brake = FALSE
			for(var/turf/T in orange(1, window))
				var/area/turf_area = get_area(T)
				if(!turf_area.outdoors)
					continue
				should_brake = TRUE
				break
			if(!should_brake)
				continue
			if(prob(40))
				window.take_damage(window.max_integrity * 10)
			else
				window.take_damage(rand(30, 150))
		CHECK_TICK

/datum/round_event/train_event/nuke/proc/impact_wave()
	if(SStrain_controller.is_moving())
		SStrain_controller.stop_moving()
		priority_announce("Attention! Emergency braking activated!", "Train control", 'sound/effects/alert.ogg')

	for(var/obj/machinery/light/light in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		if(!is_station_level(light.z))
			continue
		if(prob(30))
			light.break_light_tube()
		else
			light.flicker(rand(3, 8))
	for(var/mob/living/player in GLOB.alive_player_list)
		to_chat(player, span_userdanger("A strong shock wave hits you!"))
		shake_camera(player, 1 SECONDS, 2)
		if(prob(60))
			player.Knockdown(3 SECONDS)


/datum/round_event/train_event/nuke/proc/run_postnuke()
	sound_to_playing_players('modular_zvents/sounds/thefinalstation/post_nuke.ogg')
	addtimer(CALLBACK(src, PROC_REF(start_fallout_and_kill)), rand(30, 60) SECONDS)
	kill()

/datum/round_event/train_event/nuke/proc/start_fallout_and_kill()
	SSweather.run_weather(/datum/weather/nuclear_fallout)

/datum/weather/nuclear_fallout
	name = "Nuclear fallout"
	desc = "Nuclear fallout occurs after a recent nuclear explosion.."

	telegraph_message = span_warning("Nuclear fallout incomming!")
	telegraph_duration = 15 SECONDS

	weather_message = span_danger("Nuclear fallout is falling from the sky, find shelter under a roof!")
	weather_duration_lower = 5 MINUTES
	weather_duration_upper = 15 MINUTES
	weather_overlay = "light_ash"
	weather_color = COLOR_GOLEM_GRAY

	end_message = span_danger("Nuclear fallout no longer falls!")
	end_duration = 0 SECONDS

	area_type = /area
	protected_areas = list(/area/space)
	target_trait = ZTRAIT_STATION

	use_glow = FALSE
	weather_flags = (WEATHER_MOBS)

/datum/weather/nuclear_fallout/weather_act_mob(mob/living/victim)
	if(prob(40))
		radiation_pulse(victim, 1, RAD_MEDIUM_INSULATION, 60)
		SEND_SOUND(victim, 'modular_zvents/sounds/rad_counter.ogg')
	return ..()

