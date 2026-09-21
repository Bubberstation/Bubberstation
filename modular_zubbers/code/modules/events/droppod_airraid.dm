/datum/round_event/droppod_airraid
	start_when = 50
	end_when = 999
	announce_when = 1

	/// Number of turfs needed in an area to spawn one droppod
	var/turf_droppods_ratio = 50
	/// Lower and upper bounds of how many spawn waves to send in
	var/spawn_wave_total_lower = 0
	var/spawn_wave_total_upper = 0
	/// What wave are we currently on?
	var/current_wave = 1
	/// Which wave are we going to announce next?
	var/wave_to_announce = 1
	/// Complete list of valid droppod areas
	var/static/list/valid_spawn_areas
	/// Selected spawn areas for this event to drop mobs into
	var/list/selected_spawn_areas = list()
	/// Number of spawns in a drop pod
	var/droppod_density = 0
	/// Enemy types; spawn during normal waves
	var/list/enemy_types = list()
	/// Boss types; spawns during the final wave, if this has contents
	var/list/boss_types = list()
	/// Maximum number of boss pods to send in the final wave
	var/max_boss_pods = 1
	/// Helps calculate the time between droppod waves, multiplied against the current number of droppods
	var/time_to_next_wave_droppod_factor = 6
	/// Minimum time between droppods
	var/min_time_between_droppod_waves = 3 /// FOR FINAL BUILD: use this 30
	/// When the next incident should happen
	var/next_incidence_time = 0
	/// When the next announcement should happen
	var/next_announce_time = 0
	/// Range of time to potentially announce the next wave (can be more or less than actual wave time)
	var/min_announce_delay = -5
	var/max_announce_delay = 3
	/// how long to wait after announcement to start the event
	var/start_delay = 6
	/// how long after the last wave to announce that it's over
	var/end_announcement_delay = 4

	/// Style of droppod to send
	var/datum/pod_style/droppod_style
	/// min and max time for droppods to send (for how long they take to reach destination)
	var/max_droppod_dropdelay = 10
	var/min_droppod_dropdelay = 30

	//admin override spawn areas
	var/list/admin_override_selected_spawn_areas

/datum/round_event/droppod_airraid/setup()
	generate_valid_areas()
	choose_droppod_areas()

/datum/round_event/droppod_airraid/proc/generate_valid_areas()
	if(isnull(valid_spawn_areas))
		//areas that are always OK to be attacked
		var/static/list/whitelisted_areas = typecacheof(list(/area/station/engineering/break_room))

		//areas that will never be attacked (unless they are exactly part of the whitelist)
		var/static/list/blacklisted_areas = typecacheof(list(
			/area/station/ai/satellite/chamber,
			/area/station/ai/upload/chamber,
			/area/station/engineering,
			/area/shuttle,
			/area/station/solars,
			/area/station/maintenance,
		))
		blacklisted_areas += GLOB.expected_erp_areas
		blacklisted_areas += /area/station/maintenance

		valid_spawn_areas = typecache_filter_list(GLOB.areas, make_associative(GLOB.the_station_areas) - blacklisted_areas + whitelisted_areas)

/datum/round_event/droppod_airraid/proc/choose_droppod_areas()
	if(!isnull(admin_override_selected_spawn_areas) && length(admin_override_selected_spawn_areas) > 0)
		selected_spawn_areas = admin_override_selected_spawn_areas
	else
		var/number_waves_to_send = rand(spawn_wave_total_lower, spawn_wave_total_upper)
		while(length(selected_spawn_areas) < number_waves_to_send)
			selected_spawn_areas += pick(valid_spawn_areas)


/datum/round_event/droppod_airraid/start()
	next_announce_time = activeFor + start_delay
	next_incidence_time = next_announce_time + rand(min_announce_delay, max_announce_delay)

/datum/round_event/droppod_airraid/proc/set_next_announce_time()
	if(wave_to_announce <= length(selected_spawn_areas))
		var/droppod_count = get_droppod_count()
		next_announce_time = activeFor + calculate_time_to_next_wave(droppod_count) + rand(min_announce_delay, max_announce_delay)

/datum/round_event/droppod_airraid/proc/set_next_incident_time()
	if(!is_event_over())
		var/droppod_count = get_droppod_count()
		next_incidence_time = activeFor + calculate_time_to_next_wave(droppod_count)
	else
		next_incidence_time = activeFor + end_announcement_delay

/datum/round_event/droppod_airraid/tick()
	if(!is_event_over())
		if(activeFor == next_announce_time)
			announce_wave()
		if(activeFor == next_incidence_time)
			send_droppod_wave()
	else
		//if there are announvements remaining, rapidfire them
		if(wave_to_announce <= length(selected_spawn_areas))
			announce_wave()
		if(activeFor == next_incidence_time)
			end_event()

/datum/round_event/droppod_airraid/proc/is_event_over()
	return current_wave > length(selected_spawn_areas)

/datum/round_event/droppod_airraid/proc/announce_wave()
	priority_announce(get_announce_wave_text())
	after_wave_announce()

/datum/round_event/droppod_airraid/proc/get_announce_wave_text()
	var/area/myarea = selected_spawn_areas[wave_to_announce]
	return "Drop Pod trajectories calculated enroute to: [myarea.name]"

/datum/round_event/droppod_airraid/proc/after_wave_announce()
	wave_to_announce++
	set_next_announce_time()

/datum/round_event/droppod_airraid/proc/send_droppod_wave()
	var/list/droppod_list
	var/number_bosspods_sent = 0

	droppod_list = generate_droppods()
	var/pod
	for(var/i = 1; i <= droppod_list.len; i ++)
		pod = droppod_list[i]
		if(current_wave == length(selected_spawn_areas) && number_bosspods_sent < max_boss_pods)
			fill_bosspod(pod)
			number_bosspods_sent ++
		else
			fill_droppod(pod)
	send_droppods(droppod_list)
	after_wave(length(droppod_list))

/datum/round_event/droppod_airraid/proc/generate_droppods()
	. = list()
	var/number_droppods = get_droppod_count()
	for(var/i = 0; i < number_droppods; i ++)
		. += generate_one_droppod()

/datum/round_event/droppod_airraid/proc/get_droppod_count()
	return ceil(get_current_wave().areasize / turf_droppods_ratio)

/datum/round_event/droppod_airraid/proc/get_current_wave() as /area
	return selected_spawn_areas[current_wave]

/datum/round_event/droppod_airraid/proc/generate_one_droppod()
	var/obj/structure/closet/supplypod/pod = new /obj/structure/closet/supplypod
	pod.set_style(droppod_style)
	pod.delays[POD_TRANSIT] = rand(min_droppod_dropdelay, max_droppod_dropdelay)
	pod.explosionSize = list(0,0,0,1)
	return pod

/datum/round_event/droppod_airraid/proc/fill_droppod(obj/structure/pod)
	for(var/i = 0; i < droppod_density; i ++)
		new_enemy_spawn(pod)

/datum/round_event/droppod_airraid/proc/new_enemy_spawn(obj/pod)
	. = pick(enemy_types)
	. = new .(pod)

/datum/round_event/droppod_airraid/proc/fill_bosspod(obj/structure/pod)
	for(var/i = 0; i < droppod_density; i ++)
		if(i == 0 && boss_types.len > 0)
			new_boss_spawn(pod)
		else
			new_enemy_spawn(pod)

/datum/round_event/droppod_airraid/proc/new_boss_spawn(obj/pod)
	. = pick(boss_types)
	. = new .(pod)

/datum/round_event/droppod_airraid/proc/send_droppods(droppod_list)
	var/turf/landing_zone
	for(var/obj/structure/closet/supplypod/pod in droppod_list)
		landing_zone = get_landing_zone()
		new /obj/effect/pod_landingzone(landing_zone, pod)

/datum/round_event/droppod_airraid/proc/get_landing_zone(area/to_send)
	var/list/turf/valid_turfs = get_area_turfs(get_current_wave())
	//Only target non-dense turfs to prevent wall-embedded pods
	for(var/i in valid_turfs)
		var/turf/T = i
		if(T.density)
			valid_turfs -= T
	return pick(valid_turfs)

/datum/round_event/droppod_airraid/proc/after_wave()
	var/static/mutable_appearance/target_appearance = mutable_appearance('icons/obj/supplypods_32x32.dmi', "LZ")
	var/turf/ghost_target_turf = pick(get_area_turfs(get_current_wave()))
	notify_ghosts("A droppod wave is attacking [get_current_wave().name]!", source = ghost_target_turf, header = "Invasion in progress", alert_overlay = target_appearance)
	current_wave++
	set_next_incident_time()

/datum/round_event/droppod_airraid/proc/calculate_time_to_next_wave(current_droppod_count)
	return current_droppod_count * time_to_next_wave_droppod_factor + min_time_between_droppod_waves

/datum/round_event/droppod_airraid/proc/end_event()
	announce_end()
	end_when = activeFor

/datum/round_event/droppod_airraid/proc/announce_end()
	stack_trace("[src] lacks an end announcement!")

/////////////// adminbus customization ///////////////

///TODO: implement type dictionary stuff at tgui checkboxes, it currently sets choices as strings instead of as areas and this is not viable for this event
/*
/datum/event_admin_setup/multiple_choice/droppod_troopers
	input_text = "Select locations to send the droppods."
	min_choices = 0

/datum/event_admin_setup/multiple_choice/droppod_troopers/prompt_admins()
	var/customize_mutations = tgui_alert(usr, "Select locations?", event_control.name, list("Custom", "Random", "Cancel"))
	switch(customize_mutations)
		if("Custom")
			. = ..()
		if("Cancel")
			return ADMIN_CANCEL_EVENT
		else
			//nothing happens, use the round_event code to gen random locations
			choices = list()

/datum/event_admin_setup/multiple_choice/droppod_troopers/get_options()
	return typecache_filter_list(GLOB.areas, make_associative(GLOB.the_station_areas))

/datum/event_admin_setup/multiple_choice/droppod_troopers/apply_to_event(datum/round_event/droppod_airraid/event)
	if(length(choices) > 0)
		for(var/i = 1; i <= length(choices); i ++)
			choices[i] = choices[i][1]
		event.admin_override_selected_spawn_areas = choices
		*/

//////////////////////////////////////
/////////////// SYNDIE ///////////////
//////////////////////////////////////

/datum/round_event_control/drop_troopers_syndicate
	name = "Drop Troopers: Syndicate"
	description = "The Syndicate sends large numbers of drop pod soldiers to fight the station."
	typepath = /datum/round_event/droppod_airraid/syndicate
	weight = 6
	max_occurrences = 2
	min_players = 35
	admin_setup = list()
	//do this later admin_setup = list(/datum/event_admin_setup/multiple_choice/droppod_troopers)
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/droppod_airraid/syndicate
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 3
	spawn_wave_total_upper = 5
	droppod_density = 3
	enemy_types = list(
		/mob/living/basic/viscerator, \
		/mob/living/basic/trooper/syndicate/melee,\
		/mob/living/basic/trooper/syndicate/melee/sword/space, \
		/mob/living/basic/trooper/syndicate/ranged, \
		/mob/living/basic/trooper/syndicate/ranged/smg, \
		/mob/living/basic/trooper/syndicate/ranged/shotgun/space, \
	)
	boss_types = list(
		/mob/living/basic/trooper/syndicate/melee/sword/space/stormtrooper, \
		/mob/living/basic/trooper/syndicate/ranged/shotgun/space/stormtrooper, \
		/mob/living/basic/trooper/syndicate/ranged/smg/space/stormtrooper, \
		/mob/living/basic/bot/secbot/grievous, \
	)
	max_boss_pods = 1
	time_to_next_wave_droppod_factor = 20

	droppod_style = /datum/pod_style/syndicate
	max_droppod_dropdelay = 10
	min_droppod_dropdelay = 30

/datum/round_event/droppod_airraid/syndicate/announce(fake)
	priority_announce("Alert! The Syndicate is sending orbital drop shock troopers to [GLOB.station_name]. Please brace for impact.", "Incoming Enemy Signatures", 'sound/announcer/alarm/airraid.ogg',color_override = "red")

/datum/round_event/droppod_airraid/syndicate/new_boss_spawn()
	. = ..()
	if(istype(., /mob/living/basic/bot/secbot/grievous))
		var/mob/living/basic/bot/secbot/grievous = .
		grievous.emag_act()
		grievous.emag_act() //need to double up cause the first one only unlocks it
		grievous.add_faction(ROLE_SYNDICATE)

/datum/round_event/droppod_airraid/syndicate/announce_end()
	priority_announce("The Syndicate attack on [GLOB.station_name] has ceased. Please calmly return to your work tasks.")

////////////////////////////////////////

/datum/round_event_control/drop_troopers_syndicate_lesser
	name = "Drop Troopers: Syndicate (Lesser)"
	description = "The Syndicate sends small numbers of drop pod soldiers to fight the station."
	typepath = /datum/round_event/droppod_airraid/syndicate/lesser
	weight = 4
	max_occurrences = 1
	min_players = 12
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MAJOR

/datum/round_event/droppod_airraid/syndicate/lesser
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 1
	spawn_wave_total_upper = 3
	droppod_density = 1
	boss_types = list()
	max_boss_pods = 0
	time_to_next_wave_droppod_factor = 50

/datum/round_event/droppod_airraid/syndicate/lesser/announce(fake)
	priority_announce("Alert! The Syndicate is sending a skirmishing party to [GLOB.station_name]. Please brace for impact.", "Incoming Enemy Scouts", 'sound/announcer/alarm/airraid.ogg', color_override = "orange")

//////////////////////////////////////
//////////////// BOTS ////////////////
//////////////////////////////////////

/datum/round_event_control/drop_troopers_hivebots
	name = "Drop Troopers: Hivebots"
	description = "A fleet of autonomous robot invaders attacks the station."
	typepath = /datum/round_event/droppod_airraid/hivebots
	weight = 4
	max_occurrences = 2
	min_players = 35
	admin_setup = list()
	//admin_setup = list(/datum/event_admin_setup/multiple_choice/droppod_troopers)
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MAJOR

/datum/round_event/droppod_airraid/hivebots
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 3
	spawn_wave_total_upper = 5
	droppod_density = 5
	enemy_types = list(
		/mob/living/basic/hivebot/range, \
		/mob/living/basic/hivebot/rapid, \
		/mob/living/basic/hivebot/strong, \
		/mob/living/basic/hivebot/mechanic, \
	)
	max_boss_pods = 0
	time_to_next_wave_droppod_factor = 50

	droppod_style = /datum/pod_style/missile
	max_droppod_dropdelay = 10
	min_droppod_dropdelay = 30
