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

/datum/award/achievement/safe_launch
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
	supressed_subsystems = list(
	)
	disable_ai = TRUE
	disable_synthetics = TRUE

	var/planet_tempeture

	var/datum/weather/planet_weather

	var/endgame = FALSE

ADMIN_VERB(setup_hypothermia_event, R_DEBUG|R_FUN, "setup hypothermia event", "Sets up the hypothermia event datum for the current round, changing the lobby menu and hooks into roundstart to spawn players into the hypothermia spawn points with the intro", ADMIN_CATEGORY_EVENTS)
	SSround_events.set_active_event(/datum/full_round_event/hypothermia)
	message_admins("[key_name_admin(user)] has setup the Hypothermia event for this round.")

/datum/full_round_event/hypothermia/lobby_loaded(mob/user)
	addtimer(CALLBACK(src, PROC_REF(update_lobby_screen)), 10 SECONDS)
	RegisterSignal(SSdcs, COMSIG_GLOBAL_PLAYER_SETUP_FINISHED, PROC_REF(on_player_spawn))
	SSgamemode.halt_storyteller(user)
	CONFIG_SET(flag/allow_random_events, 0)

/datum/full_round_event/hypothermia/proc/update_lobby_screen()
	SStitle.change_title_screen(HYPOTHERMIA_TITLE_SCREEN)

/datum/full_round_event/hypothermia/roundstart(init_time)
	setup_weather()
	SSweather.eligible_zlevels = list()

/datum/full_round_event/hypothermia/proc/on_player_spawn(dcs, mob/living/new_player_living)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(hypothermia_setup), new_player_living)

/datum/full_round_event/hypothermia/proc/hypothermia_setup(mob/living/victim)
	intro_sequence(victim)
	setup_hypothermia_fluff(victim)

/datum/full_round_event/hypothermia/proc/intro_sequence(mob/living/victim)
	victim.move_to_error_room()
	victim.overlay_fullscreen("crash_blackout", /atom/movable/screen/fullscreen/flash/black)
	victim.AddComponent(/datum/component/hypothermia)
	victim.Stun(50 SECONDS)

	victim.dispatch_personal_announcement("WARNING! CRITICAL HULL BREACH DETECTED! EMERGENCY CRASH LANDING IN 45 SECONDS! BRACE FOR IMPACT!", 'sound/announcer/intern/meteors.ogg')
	sleep(10 SECONDS)

	victim.dispatch_personal_announcement("30 SECONDS TO IMPACT! ALL HANDS TO CRASH SEATS!", 'sound/effects/explosion/explosion_distant.ogg', volume = 60)
	sleep(6 SECONDS)
	SEND_SOUND(victim, 'sound/effects/explosion/explosionfar.ogg')

	sleep(4 SECONDS)
	victim.dispatch_personal_announcement("20 SECONDS REMAINING! BRACE FOR IMPACT!")
	sleep(3 SECONDS)
	SEND_SOUND(victim, 'sound/effects/explosion/explosionfar.ogg')

	sleep(5 SECONDS)

	shake_camera(victim, 25, 2)

	victim.dispatch_personal_announcement("10 SECONDS... BRACE! BRACE! BRACE!", volume = 70)
	sleep(3 SECONDS)
	SEND_SOUND(victim, 'sound/effects/explosion/explosion_distant.ogg')
	sleep(3 SECONDS)
	victim.dispatch_personal_announcement("5 SECONDS...", 'sound/effects/explosion/explosion_distant.ogg', volume = 80)
	INVOKE_ASYNC(src, PROC_REF(teleport_to_crashsite), victim)
	sleep(5 SECONDS)

	victim.playsound_local(victim, 'sound/effects/explosion/explosioncreak1.ogg', 100)
	shake_camera(victim, 50, 5)

	sleep(6 SECONDS)
	victim.dispatch_personal_announcement("Impact confirmed. All primary systems offline. External temperature: -15°C and falling fast.", 'sound/effects/explosion/explosion_distant.ogg', volume = 85)


/datum/full_round_event/hypothermia/proc/teleport_to_crashsite(mob/living/victim)
	victim.clear_fullscreen("crash_blackout", animated = 1 SECONDS)
	var/job_spawn_title = victim?.mind?.assigned_role?.job_spawn_title
	var/list/available = GLOB.start_landmarks_list.Copy()
	var/obj/effect/landmark/start/spawnpoint
	for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
		if(spawn_point.name == job_spawn_title)
			spawnpoint = spawn_point

	if(isnull(spawnpoint))
		spawnpoint = locate() in available
		if(!spawnpoint) //last try
			spawnpoint = pick(available)
	if(!spawnpoint)
		message_admins("[victim] could not find a job based spawn point, please help [ADMIN_FLW(victim)]")
		to_chat(victim, span_userdanger("ERROR: No valid spawn point found for you, something really fucked up. Contact an admin."))
		// apology cookie, have fun i guess
		podspawn(
			list(
				"target" = get_turf(victim),
				"style" = /datum/pod_style/advanced,
				"spawn" = pick(subtypesof(/obj/item/food/cookie)),
			)
		)
		return
	var/saved_offset_y = victim.pixel_y
	// var/saved_offset_x = victim.pixel_x
	victim.pixel_y = 200
	// victim.pixel_x = rand(-16, 16)
	victim.alpha = 0
	victim.spin(3 SECONDS, 1)
	victim.forceMove(get_turf(spawnpoint))
	victim.Knockdown(3 SECONDS)
	animate(victim, 1 SECONDS, alpha = 255)
	animate(victim, 3 SECONDS, pixel_y = saved_offset_y, easing = BOUNCE_EASING, flags = ANIMATION_PARALLEL)
	// animate(victim, 3 SECONDS, pixel_x = saved_offset_x, flags = ANIMATION_PARALLEL, easing = BOUNCE_EASING)
	sleep(2.8 SECONDS)
	INVOKE_ASYNC(src, PROC_REF(cause_crash_injury), victim)
	victim.throw_at(get_step(victim, pick(GLOB.alldirs)), rand(1, 3), 2)

/datum/full_round_event/hypothermia/proc/cause_crash_injury(mob/living/victim)
	set waitfor = FALSE
	victim.Knockdown(25 SECONDS)
	victim.Stun(20 SECONDS)
	shake_camera(victim, 50, 5)
	to_chat(victim, span_userdanger("IMPACT! THE SHIP SMASHES INTO THE ICE! YOU'RE THROWN VIOLENTLY ACROSS THE WRECKAGE!"))
	var/injured = FALSE

	if(prob(40))
		injured = TRUE
		var/obj/item/bodypart/limb = victim.get_bodypart(pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(limb)
			limb.receive_damage(brute = rand(15, 25), wound_bonus = 20)
			to_chat(victim, span_userdanger("Your [limb.name] SHATTERS against twisted steel!"))

	if(prob(40))
		injured = TRUE
		var/obj/item/bodypart/chest = victim.get_bodypart(BODY_ZONE_CHEST)
		if(chest)
			chest.receive_damage(brute = rand(15, 25), burn = rand(15, 25))
			to_chat(victim, span_userdanger("Your ribs CRUSH inward — breathing becomes agony!"))

	if(prob(40))
		injured = TRUE
		var/obj/item/bodypart/head = victim.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			head.receive_damage(brute = rand(15, 25))
			victim.adjust_organ_loss(ORGAN_SLOT_BRAIN, rand(5, 25))
			to_chat(victim, span_userdanger("Your skull SLAMS into metal — blood pours into your eyes!"))

	if(!injured)
		to_chat(victim, span_notice("Against all odds... you crawl from the wreckage completely unharmed. A miracle."))
		victim.client.give_award(/datum/award/achievement/very_safe_landing, victim)

/datum/full_round_event/hypothermia/proc/setup_hypothermia_fluff(mob/living/victim)
	var/area/hypothermia/hypo_area = get_area(victim)
	if(istype(hypo_area))
		hypo_area.update_mob_visual(victim)

	if(isnull(victim.mind) || isnull(victim.client))
		message_admins("Hypothermia event could not setup fluff for [victim], no mind found. Please help [ADMIN_FLW(victim)]")
		return
	to_chat(victim, span_boldwarning("The freezing darkness closes in... the cold is absolute..."))
	victim.client.give_award(/datum/award/achievement/safe_landing, victim)
	var/datum/antagonist/custom/crashland_antag = new()
	var/datum/objective/custom/survive_objective = new()
	crashland_antag.name = "Survivor"
	crashland_antag.roundend_category = "Shipwreck Survivors"
	survive_objective.explanation_text = "Find a way to survive and escape the planet."
	crashland_antag.show_in_antagpanel = FALSE
	crashland_antag.objectives += survive_objective
	victim.mind.add_antag_datum(crashland_antag)

/datum/full_round_event/hypothermia/proc/setup_weather()
	for(var/datum/weather/eventual_death in SSweather.processing)
		eventual_death.wind_down()

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
		crew.client.give_award(/datum/award/achievement/safe_launch, crew)
		if(length(crew.mind.antag_datums))
			var/datum/antagonist/custom/survivor = locate() in crew.mind.antag_datums
			if(!survivor)
				continue
			for(var/datum/objective/custom/obj in survivor.objectives)
				obj.completed = TRUE
		var/datum/component/hypothermia/hypo_comp = crew.GetComponent(/datum/component/hypothermia)
		if(hypo_comp)
			qdel(hypo_comp)


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
