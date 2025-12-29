#define HYPOTHERMIA_TITLE_SCREEN 'modular_zvents/icons/lobby/hypothermia.png'

/datum/award/achievement/safe_landing
	name = "Soft Landing"
	desc = "You survived the shipwreck. Maybe you should've taken the Interlink shuttle after all?"
	database_id = "evt_hypothermia_safelanding"

/datum/award/achievement/very_safe_landing
	name = "Truly Soft Landing"
	desc = "You survived the shipwreck without a single scratch — what a miracle!"
	database_id = "evt_hypothermia_safelanding_sup"

/datum/award/achievement/petrov_kill
	name = "Final Favor"
	desc = "You defeated the chief engineer and obtained the key to salvation. Great job!"
	database_id = "evt_hypothermia_petrov_kill"

/datum/award/achievement/laststand
	name = "The City Must Survive"
	desc = "A big storm is coming — the city must survive!"
	database_id = "evt_hypothermia_c150fp"

/datum/award/achievement/safe_laucnh
	name = "Let's Go!"
	desc = "You escaped using the Buran shuttle — it finally took off!"
	database_id = "evt_hypothermia_escape"


/datum/full_round_event/hypothermia
	name = "Hypothermia"
	short_desc = "You and your crew have crashed on this frozen planet. \
				You are cut off from communication and left to fend for yourselves. \
				But that's not your biggest problem. Beware of the freezing cold and the locals."
	extended_desc = ""
	round_start_massage = "Stay alive until the end."
	disable_dynamic = TRUE
	lock_respawn = TRUE
	only_related_observe = FALSE
	delay_round_start = TRUE
	supressed_subsystems = list()
	disable_ai = TRUE
	disable_synthetics = TRUE

	var/planet_tempeture

	var/datum/weather/planet_weather

	var/endgame = FALSE

/datum/full_round_event/hypothermia/lobby_loaded()
	addtimer(CALLBACK(src, PROC_REF(update_lobby_screen)), 10 SECONDS)


/datum/full_round_event/hypothermia/proc/update_lobby_screen()
	SStitle.change_title_screen(HYPOTHERMIA_TITLE_SCREEN)


/datum/full_round_event/hypothermia/roundstart(init_time)
	create_crashland_effects()
	SSweather.eligible_zlevels = list()


/datum/full_round_event/hypothermia/proc/create_crashland_effects()
	set waitfor = FALSE
	for(var/datum/weather/W in SSweather.processing)
		W.wind_down()

	for(var/mob/living/L in GLOB.alive_player_list)
		L.move_to_error_room()
		L.overlay_fullscreen("crash_blackout", /atom/movable/screen/fullscreen/flash/black)
		L.AddComponent(/datum/component/hypothermia)
		L.anchored = TRUE

	priority_announce("WARNING! CRITICAL HULL BREACH DETECTED! EMERGENCY CRASH LANDING IN 45 SECONDS! BRACE FOR IMPACT!",
		"Automated AI Voice", ANNOUNCER_METEORS)
	sound_to_playing_players('sound/effects/explosion/explosion_distant.ogg', volume = 50)

	sleep(10 SECONDS)

	priority_announce("30 SECONDS TO IMPACT! ALL HANDS TO CRASH SEATS!",
		"Automated AI Voice", 'sound/effects/alert.ogg')
	sound_to_playing_players('sound/effects/explosion/explosionfar.ogg', volume = 60)

	sleep(10 SECONDS)

	priority_announce("20 SECONDS REMAINING! BRACE FOR IMPACT!",
		"Automated AI Voice", 'sound/effects/alert.ogg')
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			shake_camera(M, 25, 2)

	sleep(8 SECONDS)

	priority_announce("10 SECONDS... BRACE! BRACE! BRACE!",
		"Automated AI Voice", 'sound/effects/alert.ogg')
	sound_to_playing_players('sound/effects/explosion/explosion_distant.ogg', volume = 70)

	sleep(6 SECONDS)

	priority_announce("5 SECONDS...",
		"Automated AI Voice", 'sound/effects/alert.ogg')
	sound_to_playing_players('sound/effects/explosion/explosion_distant.ogg', volume = 80)

	sleep(5 SECONDS)

	sound_to_playing_players('sound/effects/explosion/explosioncreak1.ogg', volume = 100)
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			shake_camera(M, 50, 5)

	var/list/available = GLOB.start_landmarks_list.Copy()
	for(var/mob/living/carbon/human/crew in GLOB.alive_player_list)
		var/job_spawn_title = crew?.mind?.assigned_role?.job_spawn_title
		var/obj/effect/landmark/start/spawnpoint
		for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
			if(spawn_point.name == job_spawn_title)
				spawnpoint = spawn_point
		if(!spawnpoint)
			spawnpoint = locate(/obj/effect/landmark/start) in available
			if(!spawnpoint) //last try
				spawnpoint = pick(available)
		if(!spawnpoint)
			continue
		crew.forceMove(get_turf(spawnpoint))

	for(var/mob/living/carbon/human/crew in GLOB.alive_player_list)
		crew.Knockdown(25 SECONDS)
		crew.Stun(20 SECONDS)
		crew.throw_at(get_step(crew, pick(GLOB.alldirs)), rand(1, 3), 2)
		shake_camera(crew, 50, 5)
		to_chat(crew, span_userdanger("IMPACT! THE SHIP SMASHES INTO THE ICE! YOU'RE THROWN VIOLENTLY ACROSS THE WRECKAGE!"))
		crew.clear_fullscreen("crash_blackout", animated = 20 SECONDS)
		var/injured = FALSE

		if(prob(40))
			injured = TRUE
			var/obj/item/bodypart/limb = crew.get_bodypart(pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
			if(limb)
				limb.receive_damage(brute = rand(15, 25), wound_bonus = 20)
				to_chat(crew, span_userdanger("Your [limb.name] SHATTERS against twisted steel!"))

		if(prob(40))
			injured = TRUE
			var/obj/item/bodypart/chest = crew.get_bodypart(BODY_ZONE_CHEST)
			if(chest)
				chest.receive_damage(brute = rand(15, 25), burn = rand(15, 25))
				to_chat(crew, span_userdanger("Your ribs CRUSH inward — breathing becomes agony!"))

		if(prob(40))
			injured = TRUE
			var/obj/item/bodypart/head = crew.get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage(brute = rand(15, 25))
				crew.adjust_organ_loss(ORGAN_SLOT_BRAIN, rand(5, 25))
				to_chat(crew, span_userdanger("Your skull SLAMS into metal — blood pours into your eyes!"))

		if(!injured)
			to_chat(crew, span_notice("Against all odds... you crawl from the wreckage completely unharmed. A miracle."))
			crew.client.give_award(/datum/award/achievement/very_safe_landing, crew)
		var/area/hypothermia/HA = get_area(crew)
		if(istype(HA, /area/hypothermia))
			HA.update_mob_visual(crew)
		if(crew.anchored)
			crew.anchored = FALSE
	sleep(6 SECONDS)
	priority_announce("Impact confirmed. All primary systems offline. External temperature: -15°C and falling fast.",
		"Automated AI Voice", 'sound/effects/alert.ogg')
	sound_to_playing_players('sound/effects/explosion/explosion_distant.ogg', volume = 85)

	for(var/mob/living/carbon/human/crew in GLOB.alive_player_list)
		to_chat(crew, span_boldwarning("The freezing darkness closes in... the cold is absolute..."))
		crew.client.give_award(/datum/award/achievement/safe_landing, crew)
		var/datum/antagonist/custom/crashland_antag = new()
		var/datum/objective/custom/survive_objective = new()
		crashland_antag.name = "Survivor"
		crashland_antag.roundend_category = "Shipwreck Survivors"
		survive_objective.explanation_text = "Find a way to survive and escape the planet."
		crashland_antag.show_in_antagpanel = FALSE
		crashland_antag.objectives += survive_objective
		crew.mind.add_antag_datum(crashland_antag)


/datum/full_round_event/hypothermia/proc/on_buran_startup()
	priority_announce("Attention! Weather sensors have detected a shift in the storm front. \
						Temperature drop to -150 recorded... Sensors damaged, shutdown!", "Weather report", 'sound/effects/alert.ogg')
	for(var/mob/living/carbon/human/crew in GLOB.alive_player_list)
		crew.client.give_award(/datum/award/achievement/laststand, crew)
		if(length(crew.mind.antag_datums))
			var/datum/antagonist/custom/survivor = locate() in crew.mind.antag_datums
			if(!survivor)
				survivor = new()
				survivor.name = "Survivor"
				survivor.roundend_category = "Shipwreck Survivors"
				crew.mind.add_antag_datum(survivor)
			survivor.objectives = null
			var/datum/objective/custom/survive_objective = new()
			survive_objective.explanation_text = "Survive the storm!"
			survivor.objectives += survive_objective
			to_chat(crew, span_boldwarning(survive_objective.explanation_text))

	if(planet_weather)
		planet_weather.end()
	SSweather.run_weather(/datum/weather/snow_storm/snow_blizzard/endgame)
	planet_weather = SSweather.get_weather_by_type(/datum/weather/snow_storm/snow_blizzard/endgame)
	endgame = TRUE


/datum/full_round_event/hypothermia/proc/on_buran_launch()
	for(var/mob/living/carbon/human/crew in GLOB.alive_player_list)
		var/area/escape_area = get_area(crew)
		if(!istype(escape_area, /area/shuttle/escape))
			continue
		crew.client.give_award(/datum/award/achievement/safe_laucnh, crew)
		if(length(crew.mind.antag_datums))
			var/datum/antagonist/custom/survivor = locate() in crew.mind.antag_datums
			if(!survivor)
				continue
			for(var/datum/objective/custom/obj in survivor.objectives)
				obj.completed = TRUE

/datum/full_round_event/hypothermia/event_process(ticks_per_second)
	var/time_elapsed = world.time - SSticker.round_start_time
	if(endgame)
		return

	if(time_elapsed > 3 HOURS)
		if(!planet_weather || planet_weather.type != /datum/weather/snow_storm/snow_blizzard/endgame)
			if(planet_weather)
				planet_weather.end()
			SSweather.run_weather(/datum/weather/snow_storm/snow_blizzard/endgame)
			planet_weather = SSweather.get_weather_by_type(/datum/weather/snow_storm/snow_blizzard/endgame)
		return

	if(time_elapsed > 2 HOURS)
		if(!planet_weather || planet_weather.type != /datum/weather/snow_storm/snow_blizzard/extreme)
			planet_weather?.end()
			SSweather.run_weather(/datum/weather/snow_storm/snow_blizzard/extreme)
			planet_weather = SSweather.get_weather_by_type(/datum/weather/snow_storm/snow_blizzard/extreme)
		return


	if(time_elapsed > 1 HOURS)
		if(!planet_weather || planet_weather.type != /datum/weather/snow_storm/snow_blizzard/insane)
			planet_weather?.end()
			SSweather.run_weather(/datum/weather/snow_storm/snow_blizzard/insane)
			planet_weather = SSweather.get_weather_by_type(/datum/weather/snow_storm/snow_blizzard/insane)
		return



	if(time_elapsed > 30 MINUTES)
		if(!planet_weather || planet_weather.type != /datum/weather/snow_storm/snow_blizzard/heavy)
			planet_weather?.end()
			SSweather.run_weather(/datum/weather/snow_storm/snow_blizzard/heavy)
			planet_weather = SSweather.get_weather_by_type(/datum/weather/snow_storm/snow_blizzard/heavy)
		return


	if(time_elapsed > 5 MINUTES)
		if(!planet_weather || planet_weather.type != /datum/weather/snow_storm/snow_blizzard)
			planet_weather?.end()
			SSweather.run_weather(/datum/weather/snow_storm/snow_blizzard)
			planet_weather = SSweather.get_weather_by_type(/datum/weather/snow_storm/snow_blizzard)
		return


#undef HYPOTHERMIA_TITLE_SCREEN
