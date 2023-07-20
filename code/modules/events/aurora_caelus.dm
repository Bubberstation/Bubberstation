/datum/round_event_control/aurora_caelus
	name = "Aurora Caelus"
	typepath = /datum/round_event/aurora_caelus
	max_occurrences = 1
	weight = 1
	earliest_start = 5 MINUTES
	category = EVENT_CATEGORY_FRIENDLY
	description = "A colourful display can be seen through select windows in outer space. And the kitchen."

/datum/round_event_control/aurora_caelus/can_spawn_event(players, allow_magic = FALSE)
	if(!SSmapping.empty_space)
		return FALSE
	return ..()

/datum/round_event/aurora_caelus
	announce_when = 1
	start_when = 9
	end_when = 220
	var/list/aurora_colors = list("#A2FF80", "#A2FFB6", "#92FFD8", "#8AFFEA", "#72FCFF", "#C6A8FF", "#F89EFF", "#FFA0F1")
	var/aurora_progress = 0 //this cycles from 1 to 8, slowly changing colors from gentle green to a gentle purple
	var/list/affected_turfs = list()

/datum/round_event/aurora_caelus/announce()
	priority_announce("[station_name()]: A harmless cloud of ions is approaching your station, and will exhaust their energy battering the hull. Nanotrasen recommends a short break for all employees to relax and observe this very rare event. During this time, starlight will be bright but gentle, shifting between quiet green and purple colors. Any staff who would like to view these lights for themselves may proceed to the area nearest to them with viewing ports to open space. We hope you enjoy the lights.",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "Nanotrasen Meteorology Division")
	for(var/V in GLOB.player_list)
		var/mob/M = V
		if((M.client.prefs.read_preference(/datum/preference/toggle/sound_midi)) && is_station_level(M.z))
			M.playsound_local(M, 'sound/ambience/aurora_caelus.ogg', 25, FALSE, pressure_affected = FALSE)
	for(var/atom/window in GLOB.station_windows)
		for(var/turf/T as() in RANGE_TURFS(1, window))
			if(isspaceturf(T) && !(T.starlit))
				T.set_light(1, 1, aurora_colors[7])
				T.starlit = TRUE
				affected_turfs += T

/datum/round_event/aurora_caelus/start()
	if(!length(affected_turfs))
		return
	for(var/atom/A in affected_turfs)
		A.set_light(3, 1.5, l_color = aurora_colors[8])
		if(istype(affected_turfs, /area/station/service/kitchen))
			for(var/turf/open/kitchen)
				kitchen.set_light(1, 0.75)
			if(!prob(1) && !check_holidays(APRIL_FOOLS))
				continue
			var/obj/machinery/oven/roast_ruiner = locate() in affected_turfs
			if(roast_ruiner)
				roast_ruiner.balloon_alert_to_viewers("oh egads!")
				var/turf/ruined_roast = get_turf(roast_ruiner)
				ruined_roast.atmos_spawn_air("[GAS_PLASMA]=100;[TURF_TEMPERATURE(1000)]")
				message_admins("Aurora Caelus event caused an oven to ignite at [ADMIN_VERBOSEJMP(ruined_roast)].")
				log_game("Aurora Caelus event caused an oven to ignite at [loc_name(ruined_roast)].")
				announce_to_ghosts(roast_ruiner)
			for(var/mob/living/carbon/human/seymour as anything in GLOB.human_list)
				if(seymour.mind && istype(seymour.mind.assigned_role, /datum/job/cook))
					seymour.say("My roast is ruined!!!", forced = "ruined roast")
					seymour.emote("scream")


/datum/round_event/aurora_caelus/tick()
	if(activeFor % 5 == 0)
		if(aurora_progress < 8)
			aurora_progress++
		if(!length(affected_turfs))
			return
		var/aurora_color = aurora_colors[aurora_progress]
		for(var/atom/A in affected_turfs)
			var/light_modifier = 0
			if(aurora_progress < 5)
				light_modifier = aurora_progress / 6
			else
				light_modifier = 1 - aurora_progress / 10
			A.set_light(2 + light_modifier, 2 + light_modifier, l_color = aurora_color)


/datum/round_event/aurora_caelus/end()
	if(length(affected_turfs))
		for(var/atom/A in affected_turfs)
			fade_to_black(A)
	priority_announce("The Aurora Caelus event is now ending. Starlight conditions will slowly return to normal. When this has concluded, please return to your workplaces and continue work as normal. Have a pleasant shift, [station_name()], and thank you for watching with us.",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "Nanotrasen Meteorology Division")

/datum/round_event/aurora_caelus/proc/fade_to_black(turf/open/space/spess)
	set waitfor = FALSE
	var/new_light = initial(spess.light_range)
	while(spess.light_range > new_light)
		spess.set_light(spess.light_range - 0.2)
		sleep(3 SECONDS)
	spess.set_light(new_light, initial(spess.light_power), initial(spess.light_color))
	spess.starlit = FALSE
