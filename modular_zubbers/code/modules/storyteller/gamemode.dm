#define INIT_ORDER_GAMEMODE 70

SUBSYSTEM_DEF(gamemode)
	name = "Storyteller"
	init_order = INIT_ORDER_GAMEMODE
	runlevels = RUNLEVEL_GAME
	flags = SS_BACKGROUND | SS_KEEP_TIMING
	wait = 2 SECONDS

	/// List of our event tracks for fast access during for loops.
	var/list/event_tracks = EVENT_TRACKS
	/// Our storyteller. He progresses our trackboards and picks out events
	var/datum/storyteller/storyteller
	/// Result of the storyteller vote. Defaults to the guide.
	var/voted_storyteller = /datum/storyteller/default
	/// List of all the storytellers. Populated at init. Associative from type
	var/list/storytellers = list()
	/// Next process for our storyteller. The wait time is STORYTELLER_WAIT_TIME
	var/next_storyteller_process = 0
	/// Associative list of even track points.
	var/list/event_track_points = list(
		EVENT_TRACK_MUNDANE = 0,
		EVENT_TRACK_MODERATE = 0,
		EVENT_TRACK_MAJOR = 0,
		EVENT_TRACK_CREWSET = 0,
		EVENT_TRACK_GHOSTSET = 0
		)
	/// Last point amount gained of each track. Those are recorded for purposes of estimating how long until next event.
	var/list/last_point_gains = list(
		EVENT_TRACK_MUNDANE = 0,
		EVENT_TRACK_MODERATE = 0,
		EVENT_TRACK_MAJOR = 0,
		EVENT_TRACK_CREWSET = 0,
		EVENT_TRACK_GHOSTSET = 0
		)
	/// Point thresholds at which the events are supposed to be rolled, it is also the base cost for events.
	var/list/point_thresholds = list(
		EVENT_TRACK_MUNDANE = 100,
		EVENT_TRACK_MODERATE = 100,
		EVENT_TRACK_MAJOR = 100,
		EVENT_TRACK_CREWSET = 100,
		EVENT_TRACK_GHOSTSET = 100
		)

	/// Minimum population thresholds for the tracks to fire off events.
	var/list/min_pop_thresholds = list(
		EVENT_TRACK_MUNDANE = MUNDANE_MIN_POP,
		EVENT_TRACK_MODERATE = MODERATE_MIN_POP,
		EVENT_TRACK_MAJOR = MAJOR_MIN_POP,
		EVENT_TRACK_CREWSET = CREWSET_MIN_POP,
		EVENT_TRACK_GHOSTSET = GHOSTSET_MIN_POP
		)

	/// Configurable multipliers for point gain over time.
	var/list/point_gain_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_CREWSET = 1,
		EVENT_TRACK_GHOSTSET = 1
		)
	/// Configurable multipliers for roundstart points.
	var/list/roundstart_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_CREWSET = 1,
		EVENT_TRACK_GHOSTSET = 1
		)
	/// Whether we allow pop scaling. This is configured by config, or the storyteller UI
	var/allow_pop_scaling = TRUE

	/// Associative list of pop scale thresholds.
	var/list/pop_scale_thresholds = list(
		EVENT_TRACK_MUNDANE = MUNDANE_POP_SCALE_THRESHOLD,
		EVENT_TRACK_MODERATE = MODERATE_POP_SCALE_THRESHOLD,
		EVENT_TRACK_MAJOR = MAJOR_POP_SCALE_THRESHOLD,
		EVENT_TRACK_CREWSET = CREWSET_POP_SCALE_THRESHOLD,
		EVENT_TRACK_GHOSTSET = GHOSTSET_POP_SCALE_THRESHOLD
		)

	/// Associative list of pop scale penalties.
	var/list/pop_scale_penalties = list(
		EVENT_TRACK_MUNDANE = MUNDANE_POP_SCALE_PENALTY,
		EVENT_TRACK_MODERATE = MODERATE_POP_SCALE_PENALTY,
		EVENT_TRACK_MAJOR = MAJOR_POP_SCALE_PENALTY,
		EVENT_TRACK_CREWSET = CREWSET_POP_SCALE_PENALTY,
		EVENT_TRACK_GHOSTSET = GHOSTSET_POP_SCALE_PENALTY
		)



	/// Associative list of control events by their track category. Compiled in Init
	var/list/event_pools = list()

	/// Events that we have scheduled to run in the nearby future
	var/list/scheduled_events = list()

	/// Associative list of tracks to forced event controls. For admins to force events (though they can still invoke them freely outside of the track system)
	var/list/forced_next_events = list()

	var/list/control = list() //list of all datum/round_event_control. Used for selecting events based on weight and occurrences.
	var/list/running = list() //list of all existing /datum/round_event
	var/list/currentrun = list()

	/// List of all uncategorized events, because they were wizard or holiday events
	var/list/uncategorized = list()

	var/list/holidays //List of all holidays occuring today or null if no holidays

	/// Event frequency multiplier, it exists because wizard, eugh.
	var/event_frequency_multiplier = 1

	/// Current preview page for the statistics UI.
	var/statistics_track_page = EVENT_TRACK_MUNDANE
	/// Page of the UI panel.
	var/panel_page = GAMEMODE_PANEL_MAIN
	/// Whether we are viewing the roundstart events or not
	var/roundstart_event_view = TRUE

	/// Whether the storyteller has been halted
	var/storyteller_halted = FALSE

	/// Ready players for roundstart events.
	var/ready_players = 0
	var/active_players = 0
	var/head_crew = 0
	var/eng_crew = 0
	var/sec_crew = 0
	var/med_crew = 0

	/// Whether we looked up pop info in this process tick
	var/pop_data_cached = FALSE

	var/wizardmode = FALSE

	var/storyteller_voted = FALSE

/datum/controller/subsystem/gamemode/Initialize(time, zlevel)
	. = ..()
	// Populate event pools
	for(var/track in event_tracks)
		event_pools[track] = list()

	// Populate storytellers
	for(var/type in subtypesof(/datum/storyteller))
		storytellers[type] = new type()

	for(var/type in typesof(/datum/round_event_control))
		var/datum/round_event_control/event = new type()
		if(!event.typepath || !event.name || !event.valid_for_map())
			continue //don't want this one! leave it for the garbage collector
		control += event //add it to the list of all events (controls)
	getHoliday()

	load_config_vars()
	load_event_config_vars()

	///Seeding events into track event pools needs to happen after event config vars are loaded
	for(var/datum/round_event_control/event as anything in control)
		if(event.holidayID || event.wizardevent)
			uncategorized += event
			continue
		event_pools[event.track] += event //Add it to the categorized event pools
	return SS_INIT_SUCCESS


/datum/controller/subsystem/gamemode/fire(resumed = FALSE)
	if(!resumed)
		src.currentrun = running.Copy()

	///Handle scheduled events
	for(var/datum/scheduled_event/sch_event in scheduled_events)
		if(world.time >= sch_event.start_time)
			sch_event.try_fire()
		else if(!sch_event.alerted_admins && world.time >= sch_event.start_time - 1 MINUTES)
			///Alert admins 1 minute before running and allow them to cancel or refund the event, once again.
			sch_event.alerted_admins = TRUE
			message_admins("Scheduled Event: [sch_event.event] will run in [(sch_event.start_time - world.time) / 10] seconds. (<a href='?src=[REF(sch_event)];action=cancel'>CANCEL</a>) (<a href='?src=[REF(sch_event)];action=refund'>REFUND</a>)")

	if(!storyteller_halted && next_storyteller_process <= world.time && storyteller)
		// We update crew information here to adjust population scalling and event thresholds for the storyteller.
		update_crew_infos()
		next_storyteller_process = world.time + STORYTELLER_WAIT_TIME
		storyteller.process(STORYTELLER_WAIT_TIME * 0.1)
	// Reset the cache value to false
	pop_data_cached = FALSE

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/datum/thing = currentrun[currentrun.len]
		currentrun.len--
		if(thing)
			thing.process(wait * 0.1)
		else
			running.Remove(thing)
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/gamemode/proc/storyteller_desc(storyteller_name)
	for(var/storyteller_type in storytellers)
		var/datum/storyteller/storyboy = storytellers[storyteller_type]
		if(storyboy.name != storyteller_name)
			continue
		return storyboy.desc

/// Gets the number of antagonists the antagonist injection events will stop rolling after.
/datum/controller/subsystem/gamemode/proc/get_antag_cap()
	if(isnull(storyteller))
		return 0
	if(!storyteller.antag_divisor)
		return 0
	return round(max(min(get_correct_popcount() / storyteller.antag_divisor + sec_crew ,sec_crew * 1.5),ANTAG_CAP_FLAT))

/// Whether events can inject more antagonists into the round
/datum/controller/subsystem/gamemode/proc/can_inject_antags()
	return (get_antag_cap() > length(GLOB.current_living_antags))

/// Gets candidates for antagonist roles.

/// Todo: Split into get_candidates and post_get_candidates
/datum/controller/subsystem/gamemode/proc/get_candidates(
	special_role_flag,
	pick_observers,
	pick_roundstart_players,
	required_time,
	inherit_required_time = TRUE,
	no_antags = TRUE,
	list/restricted_roles,
	)


	var/list/candidates = list()
	var/list/candidate_candidates = list() //lol
	if(pick_roundstart_players)
		for(var/mob/dead/new_player/player in GLOB.new_player_list)
			if(player.ready == PLAYER_READY_TO_PLAY && player.mind && player.check_preferences())
				candidate_candidates += player
	else if(pick_observers)
		for(var/mob/player as anything in GLOB.dead_mob_list)
			candidate_candidates += player
	else
		for(var/datum/record/locked/manifest_log as anything in GLOB.manifest.locked)
			var/datum/mind/player_mind = manifest_log.mind_ref.resolve()
			var/mob/living/player = player_mind.current
			if(isnull(player))
				continue
			candidate_candidates += player


	for(var/mob/candidate as anything in candidate_candidates)
		if(QDELETED(candidate) || !candidate.key || !candidate.client || !candidate.mind)
			continue
		if(no_antags && candidate.mind.special_role)
			continue
		if(restricted_roles && (candidate.mind.assigned_role.title in restricted_roles))
			continue
		if(special_role_flag)
			if(!(candidate.client.prefs) || !(special_role_flag in candidate.client.prefs.be_special))
				continue

			var/time_to_check
			if(required_time)
				time_to_check = required_time
			else if (inherit_required_time)
				time_to_check = GLOB.special_roles[special_role_flag]

			if(time_to_check && candidate.client.get_remaining_days(time_to_check) > 0)
				continue

		if(special_role_flag && is_banned_from(candidate.ckey, list(special_role_flag, ROLE_SYNDICATE)))
			continue
		if(is_banned_from(candidate.client.ckey, BAN_ANTAGONIST))
			continue
		if(!candidate.client?.prefs?.read_preference(/datum/preference/toggle/be_antag))
			continue
		candidates += candidate
	return candidates

/// Gets the correct popcount, returning READY people if roundstart, and active people if not.
/datum/controller/subsystem/gamemode/proc/get_correct_popcount()
	if(SSticker.HasRoundStarted())
		if(!pop_data_cached)
			update_crew_infos()
		return active_players
	else
		if(!pop_data_cached)
			calculate_ready_players()
		return ready_players

/// Refunds and removes a scheduled event.
/datum/controller/subsystem/gamemode/proc/refund_scheduled_event(datum/scheduled_event/refunded)
	if(refunded.cost)
		var/track_type = refunded.event.track
		event_track_points[track_type] += refunded.cost
	remove_scheduled_event(refunded)

/// Schedules an event.
/datum/controller/subsystem/gamemode/proc/force_event(datum/round_event_control/event)
	forced_next_events[event.track] = event

/// Removes a scheduled event.
/datum/controller/subsystem/gamemode/proc/remove_scheduled_event(datum/scheduled_event/removed)
	scheduled_events -= removed
	qdel(removed)

/// We need to calculate ready players for the sake of roundstart events becoming eligible.
/datum/controller/subsystem/gamemode/proc/calculate_ready_players()
	ready_players = 0
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		if(player.ready == PLAYER_READY_TO_PLAY)
			ready_players++
	pop_data_cached = TRUE

/// We roll points to be spent for roundstart events, including antagonists.
/datum/controller/subsystem/gamemode/proc/roll_pre_setup_points()
	if(storyteller.disable_distribution || storyteller_halted)
		return
	/// Distribute points
	for(var/track in event_track_points)
		var/base_amt
		switch(track)
			if(EVENT_TRACK_MUNDANE)
				base_amt = ROUNDSTART_MUNDANE_BASE
			if(EVENT_TRACK_MODERATE)
				base_amt = ROUNDSTART_MODERATE_BASE
			if(EVENT_TRACK_MAJOR)
				base_amt = ROUNDSTART_MAJOR_BASE
			if(EVENT_TRACK_CREWSET)
				base_amt = ROUNDSTART_CREWSET_BASE
			if(EVENT_TRACK_GHOSTSET)
				base_amt = ROUNDSTART_GHOSTSET_BASE
		var/calc_value = base_amt
		calc_value *= roundstart_point_multipliers[track]
		calc_value *= storyteller.starting_point_multipliers[track]
		calc_value *= (1 + (rand(-storyteller.roundstart_points_variance, storyteller.roundstart_points_variance) / 100))
		event_track_points[track] = max(0, round(calc_value))

	/// If the storyteller guarantees an antagonist roll, add points to make it so.
	if(storyteller.guarantees_roundstart_crewset)
		event_track_points[EVENT_TRACK_CREWSET] = point_thresholds[EVENT_TRACK_CREWSET]

	/// If we have any forced events, ensure we get enough points for them
	for(var/track in event_tracks)
		if(forced_next_events[track] && event_track_points[track] < point_thresholds[track])
			event_track_points[track] = point_thresholds[track]

/// Because roundstart events need 2 steps of firing for purposes of antags, here is the first step handled, happening before occupation division.
/datum/controller/subsystem/gamemode/proc/handle_pre_setup_roundstart_events()
	if(storyteller.disable_distribution)
		return
	if(storyteller_halted)
		message_admins("WARNING: Didn't roll roundstart events (including antagonists) due to the storyteller being halted.")
		return
	while(TRUE)
		if(!storyteller.handle_tracks())
			break

/// Second step of handlind roundstart events, happening after people spawn.
/datum/controller/subsystem/gamemode/proc/handle_post_setup_roundstart_events()
	/// Start all roundstart events on post_setup immediately
	for(var/datum/round_event/event as anything in running)
		if(!event.control.roundstart)
			continue
		ASYNC
			event.try_start()
//		INVOKE_ASYNC(event, /datum/round_event.proc/try_start)

/// Schedules an event to run later.
/datum/controller/subsystem/gamemode/proc/schedule_event(datum/round_event_control/passed_event, passed_time, passed_cost, passed_ignore, passed_announce)
	var/datum/scheduled_event/scheduled = new (passed_event, world.time + passed_time, passed_cost, passed_ignore, passed_announce)
	var/round_started = SSticker.HasRoundStarted()
	if(round_started)
		message_admins("Event: [passed_event] has been scheduled to run in [passed_time / 10] seconds. (<a href='?src=[REF(scheduled)];action=cancel'>CANCEL</a>) (<a href='?src=[REF(scheduled)];action=refund'>REFUND</a>)")
	else //Only roundstart events can be scheduled before round start
		message_admins("Event: [passed_event] has been scheduled to run on roundstart. (<a href='?src=[REF(scheduled)];action=cancel'>CANCEL</a>)")
	scheduled_events += scheduled

/datum/controller/subsystem/gamemode/proc/update_crew_infos()
	// Very similar logic to `get_active_player_count()`
	active_players = 0
	head_crew = 0
	eng_crew = 0
	med_crew = 0
	sec_crew = 0
	for(var/mob/player_mob as anything in GLOB.player_list)
		if(!player_mob.client)
			continue
		if(player_mob.stat) //If they're alive
			continue
		if(player_mob.client.is_afk()) //If afk
			continue
		if(!ishuman(player_mob))
			continue
		active_players++
		if(player_mob.mind?.assigned_role)
			var/datum/job/player_role = player_mob.mind.assigned_role
			if(player_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
				head_crew++
			if(player_role.departments_bitflags & DEPARTMENT_BITFLAG_ENGINEERING)
				eng_crew++
			if(player_role.departments_bitflags & DEPARTMENT_BITFLAG_MEDICAL)
				med_crew++
			if(player_role.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY)
				sec_crew++
	pop_data_cached = TRUE

/datum/controller/subsystem/gamemode/proc/TriggerEvent(datum/round_event_control/event)
	. = event.preRunEvent()
	if(. == EVENT_CANT_RUN)//we couldn't run this event for some reason, set its max_occurrences to 0
		event.max_occurrences = 0
	else if(. == EVENT_READY)
		event.run_event(random = TRUE) // fallback to dynamic

///Resets frequency multiplier.
/datum/controller/subsystem/gamemode/proc/resetFrequency()
	event_frequency_multiplier = 1

/* /client/proc/forceEvent()
	set name = "Trigger Event"
	set category = "Admin.Events"

	if(!holder ||!check_rights(R_FUN))
		return

	holder.forceEvent(usr) */

/* /datum/admins/forceEvent(mob/user)
	SSgamemode.event_panel(user) */


//////////////
// HOLIDAYS //
//////////////
//Uncommenting ALLOW_HOLIDAYS in config.txt will enable holidays

//It's easy to add stuff. Just add a holiday datum in code/modules/holiday/holidays.dm
//You can then check if it's a special day in any code in the game by doing if(SSgamemode.holidays["Groundhog Day"])

//You can also make holiday random events easily thanks to Pete/Gia's system.
//simply make a random event normally, then assign it a holidayID string which matches the holiday's name.
//Anything with a holidayID, which isn't in the holidays list, will never occur.

//Please, Don't spam stuff up with stupid stuff (key example being april-fools Pooh/ERP/etc),
//And don't forget: CHECK YOUR CODE!!!! We don't want any zero-day bugs which happen only on holidays and never get found/fixed!

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//ALSO, MOST IMPORTANTLY: Don't add stupid stuff! Discuss bonus content with Project-Heads first please!//
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//sets up the holidays and holidays list
/datum/controller/subsystem/gamemode/proc/getHoliday()
	if(!CONFIG_GET(flag/allow_holidays))
		return // Holiday stuff was not enabled in the config!
	for(var/H in subtypesof(/datum/holiday))
		var/datum/holiday/holiday = new H()
		var/delete_holiday = TRUE
		for(var/timezone in holiday.timezones)
			var/time_in_timezone = world.realtime + timezone HOURS

			var/YYYY = text2num(time2text(time_in_timezone, "YYYY")) // get the current year
			var/MM = text2num(time2text(time_in_timezone, "MM")) // get the current month
			var/DD = text2num(time2text(time_in_timezone, "DD")) // get the current day
			var/DDD = time2text(time_in_timezone, "DDD") // get the current weekday

			if(holiday.shouldCelebrate(DD, MM, YYYY, DDD))
				holiday.celebrate()
				LAZYSET(holidays, holiday.name, holiday)
				delete_holiday = FALSE
				break
		if(delete_holiday)
			qdel(holiday)

	if(holidays)
		holidays = shuffle(holidays)
		// regenerate station name because holiday prefixes.
		set_station_name(new_station_name())
		world.update_status()

/datum/controller/subsystem/gamemode/proc/toggleWizardmode()
	wizardmode = !wizardmode //TODO: decide what to do with wiz events
	message_admins("Summon Events has been [wizardmode ? "enabled, events will occur [SSgamemode.event_frequency_multiplier] times as fast" : "disabled"]!")
	log_game("Summon Events was [wizardmode ? "enabled" : "disabled"]!")

///Attempts to select players for special roles the mode might have.
/datum/controller/subsystem/gamemode/proc/pre_setup()
	// We need to do this to prevent some niche fuckery... and make dep. orders work. Lol
	SSjob.reset_occupations()
	calculate_ready_players()
	roll_pre_setup_points()
	handle_pre_setup_roundstart_events()
	return TRUE

///Everyone should now be on the station and have their normal gear.  This is the place to give the special roles extra things
/datum/controller/subsystem/gamemode/proc/post_setup(report) //Gamemodes can override the intercept report. Passing TRUE as the argument will force a report.
	if(!report)
		report = !CONFIG_GET(flag/no_intercept_report)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/display_roundstart_logout_report), ROUNDSTART_LOGOUT_REPORT_TIME)

	if(SSdbcore.Connect())
		var/list/to_set = list()
		var/arguments = list()
		if(storyteller)
			to_set += "game_mode = :game_mode"
			arguments["game_mode"] = storyteller.name
		if(GLOB.revdata.originmastercommit)
			to_set += "commit_hash = :commit_hash"
			arguments["commit_hash"] = GLOB.revdata.originmastercommit
		if(to_set.len)
			arguments["round_id"] = GLOB.round_id
			var/datum/db_query/query_round_game_mode = SSdbcore.NewQuery(
				"UPDATE [format_table_name("round")] SET [to_set.Join(", ")] WHERE id = :round_id",
				arguments
			)
			query_round_game_mode.Execute()
			qdel(query_round_game_mode)
	addtimer(CALLBACK(src, PROC_REF(send_trait_report)), rand(1 MINUTES, 5 MINUTES))
	handle_post_setup_roundstart_events()
	roundstart_event_view = FALSE
	pop_data_cached = FALSE // Uncache it because we'd still wrongly consider it cached from lobby pops
	return TRUE


///Handles late-join antag assignments
/datum/controller/subsystem/gamemode/proc/make_antag_chance(mob/living/carbon/human/character)
	return

/datum/controller/subsystem/gamemode/proc/check_finished(force_ending) //to be called by SSticker
	if(!SSticker.setup_done)
		return FALSE
	if(SSshuttle.emergency && (SSshuttle.emergency.mode == SHUTTLE_ENDGAME))
		return TRUE
	if(GLOB.station_was_nuked)
		return TRUE
	if(force_ending)
		return TRUE

//////////////////////////
//Reports player logouts//
//////////////////////////
/proc/display_roundstart_logout_report()
	var/list/msg = list("[span_boldnotice("Roundstart logout report")]\n\n")
	for(var/i in GLOB.mob_living_list)
		var/mob/living/L = i
		var/mob/living/carbon/C = L
		var/mob/living/carbon/human/H = C
		if (istype(C) && !C.last_mind)
			continue  // never had a client

		if(L.ckey && !GLOB.directory[L.ckey])
			msg += "<b>[L.name]</b> ([L.key]), the [L.job] (<font color='#ffcc00'><b>Disconnected</b></font>)\n"


		if(L.ckey && L.client)
			var/failed = FALSE
			if(L.client.inactivity >= (ROUNDSTART_LOGOUT_REPORT_TIME / 2)) //Connected, but inactive (alt+tabbed or something)
				msg += "<b>[L.name]</b> ([L.key]), the [L.job] (<font color='#ffcc00'><b>Connected, Inactive</b></font>)\n"
				failed = TRUE //AFK client
			if(!failed && L.stat)
				if(H.get_dnr()) //Suicider
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] ([span_boldannounce("Suicide")])\n"
					failed = TRUE //Disconnected client
				if(!failed && (L.stat == UNCONSCIOUS || L.stat == HARD_CRIT))
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] (Dying)\n"
					failed = TRUE //Unconscious
				if(!failed && L.stat == DEAD)
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] (Dead)\n"
					failed = TRUE //Dead

			continue //Happy connected client
		for(var/mob/dead/observer/D in GLOB.dead_mob_list)
			if(D.mind && D.mind.current == L)
				if(L.stat == DEAD)
					if(H.get_dnr()) //Suicider
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] ([span_boldannounce("Suicide")])\n"
						continue //Disconnected client
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] (Dead)\n"
						continue //Dead mob, ghost abandoned
				else
					if(D.can_reenter_corpse)
						continue //Adminghost, or cult/wizard ghost
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] ([span_boldannounce("Ghosted")])\n"
						continue //Ghosted while alive


	for (var/C in GLOB.admins)
		to_chat(C, msg.Join())

//Set result and news report here
/datum/controller/subsystem/gamemode/proc/set_round_result()
	SSticker.mode_result = "undefined"
	if(GLOB.station_was_nuked)
		SSticker.news_report = STATION_DESTROYED_NUKE
	if(EMERGENCY_ESCAPED_OR_ENDGAMED)
		SSticker.news_report = STATION_EVACUATED
		if(SSshuttle.emergency.is_hijacked())
			SSticker.news_report = SHUTTLE_HIJACK

/// Loads json event config values from events.txt
/datum/controller/subsystem/gamemode/proc/load_event_config_vars()
	var/json_file = file("[global.config.directory]/events.json")
	if(!fexists(json_file))
		return
	var/list/decoded = json_decode(file2text(json_file))
	for(var/event_text_path in decoded)
		var/event_path = text2path(event_text_path)
		var/datum/round_event_control/event
		for(var/datum/round_event_control/iterated_event as anything in control)
			if(iterated_event.type == event_path)
				event = iterated_event
				break
		if(!event)
			continue
		var/list/var_list = decoded[event_text_path]
		for(var/variable in var_list)
			var/value = var_list[variable]
			switch(variable)
				if("weight")
					event.weight = value
				if("min_players")
					event.min_players = value
				if("max_occurrences")
					event.max_occurrences = value
				if("earliest_start")
					event.earliest_start = value * (1 MINUTES)
				if("track")
					if(value in event_tracks)
						event.track = value
				if("cost")
					event.cost = value
				if("reoccurence_penalty_multiplier")
					event.reoccurence_penalty_multiplier = value
				if("shared_occurence_type")
					if(!isnull(value))
						value = text2path(value)
					event.shared_occurence_type = value

/// Loads config values from game_options.txt
/datum/controller/subsystem/gamemode/proc/load_config_vars()
	point_gain_multipliers[EVENT_TRACK_MUNDANE] = CONFIG_GET(number/mundane_point_gain_multiplier)
	point_gain_multipliers[EVENT_TRACK_MODERATE] = CONFIG_GET(number/moderate_point_gain_multiplier)
	point_gain_multipliers[EVENT_TRACK_MAJOR] = CONFIG_GET(number/major_point_gain_multiplier)
	point_gain_multipliers[EVENT_TRACK_CREWSET] = CONFIG_GET(number/crewset_point_gain_multiplier)
	point_gain_multipliers[EVENT_TRACK_GHOSTSET] = CONFIG_GET(number/ghostset_point_gain_multiplier)

	roundstart_point_multipliers[EVENT_TRACK_MUNDANE] = CONFIG_GET(number/mundane_roundstart_point_multiplier)
	roundstart_point_multipliers[EVENT_TRACK_MODERATE] = CONFIG_GET(number/moderate_roundstart_point_multiplier)
	roundstart_point_multipliers[EVENT_TRACK_MAJOR] = CONFIG_GET(number/major_roundstart_point_multiplier)
	roundstart_point_multipliers[EVENT_TRACK_CREWSET] = CONFIG_GET(number/crewset_roundstart_point_multiplier)
	roundstart_point_multipliers[EVENT_TRACK_GHOSTSET] = CONFIG_GET(number/ghostset_roundstart_point_multiplier)

	min_pop_thresholds[EVENT_TRACK_MUNDANE] = CONFIG_GET(number/mundane_min_pop)
	min_pop_thresholds[EVENT_TRACK_MODERATE] = CONFIG_GET(number/moderate_min_pop)
	min_pop_thresholds[EVENT_TRACK_MAJOR] = CONFIG_GET(number/major_min_pop)
	min_pop_thresholds[EVENT_TRACK_CREWSET] = CONFIG_GET(number/crewset_min_pop)
	min_pop_thresholds[EVENT_TRACK_GHOSTSET] = CONFIG_GET(number/ghostset_min_pop)

/datum/controller/subsystem/gamemode/proc/storyteller_vote_choices()
	var/client_amount = GLOB.clients.len
	var/list/choices = list()
	for(var/storyteller_type in storytellers)
		var/datum/storyteller/storyboy = storytellers[storyteller_type]
		/// Prevent repeating storytellers
		if(storyboy.storyteller_type && storyboy.storyteller_type == SSpersistence.last_storyteller_type)
			continue
		if(!storyboy.votable)
			continue
		if((storyboy.population_min && storyboy.population_min > client_amount) || (storyboy.population_max && storyboy.population_max < client_amount))
			continue
		choices += storyboy.name
		///Because the vote subsystem is dumb and does not support any descriptions, we dump them into world.
		to_chat(world, span_notice("<b>[storyboy.name]</b>"))
		to_chat(world, span_notice("[storyboy.desc]"))
	return choices

/datum/controller/subsystem/gamemode/proc/storyteller_vote_result(winner_name)
	/// Find the winner
	voted_storyteller = winner_name
	if(storyteller)
		return
	for(var/storyteller_type in storytellers)
		var/datum/storyteller/storyboy = storytellers[storyteller_type]
		if(storyboy.name == winner_name)
			voted_storyteller = storyteller_type
			break

/datum/controller/subsystem/gamemode/proc/init_storyteller()
	if(storyteller) // If this is true, then an admin bussed one, don't overwrite it
		log_dynamic("Roundstart storyteller has been set by admins to [storyteller.name], the vote was not considered.")
		return
	var/datum/storyteller/storyteller_pick
	if(!voted_storyteller)
		storyteller_pick = pick(storytellers)
		log_dynamic("Roundstart picked storyteller [storyteller.name] randomly due to no vote result.")
		voted_storyteller = storyteller_pick
	set_storyteller(voted_storyteller)

/**
 * set_storyteller
 *
 * Always call this to set the storyteller
 * Called by the storyteller system on roundstart and after a vote finishes.
 * When forced via game panel, forced = TRUE, and force_ckey contains the ckey of the admin who forced it
*/
/datum/controller/subsystem/gamemode/proc/set_storyteller(passed_type, forced, force_ckey)
	if(!storytellers[passed_type])
		message_admins("Attempted to set an invalid storyteller type: [passed_type].")
		CRASH("Attempted to set an invalid storyteller type: [passed_type].")
	storyteller = storytellers[passed_type]

	var/datum/storyteller_data/tracks/track_data = storyteller.track_data
	point_thresholds[EVENT_TRACK_MUNDANE] = track_data.threshold_mundane * CONFIG_GET(number/mundane_point_threshold)
	point_thresholds[EVENT_TRACK_MODERATE] = track_data.threshold_moderate * CONFIG_GET(number/moderate_point_threshold)
	point_thresholds[EVENT_TRACK_MAJOR] = track_data.threshold_major * CONFIG_GET(number/major_point_threshold)
	point_thresholds[EVENT_TRACK_CREWSET] = track_data.threshold_crewset * CONFIG_GET(number/crewset_point_threshold)
	point_thresholds[EVENT_TRACK_GHOSTSET] = track_data.threshold_ghostset * CONFIG_GET(number/ghostset_point_threshold)

	to_chat(world, span_notice("<b>Storyteller is [storyteller.name]!</b>"))
	to_chat(world, span_notice("[storyteller.welcome_text]"))
	log_admin_private("Storyteller switched to [storyteller.name]. [forced ? "Forced by admin ckey [force_ckey]" : ""]")

/**
 * halt_storyteller
 *
 * Used to halt/unhalt and properly log storyteller
 */

/datum/controller/subsystem/gamemode/proc/halt_storyteller(mob/user)
	storyteller_halted = !storyteller_halted
	if(isnull(user))
		return
	message_admins("[key_name_admin(user)] has [storyteller_halted ? "HALTED" : "un-halted"] the Storyteller.")
	log_dynamic("Storyteller [storyteller_halted ? "halted" : "un-halted"] by admin [user.ckey].")

/**
 * force_next_event
 *
 * Forces next event scheduling/firing for `track`
 *
 */
/datum/controller/subsystem/gamemode/proc/force_next_event(track, mob/user)
	if(isnull(user))
		return
	if(isnull(storyteller))
		return
	event_track_points[track] = point_thresholds[track]
	storyteller.handle_tracks()
	message_admins("[key_name_admin(user)] has forced an event for the [track] track.")
	log_admin_private("Storyteller track [track] forced to run an event by [user.ckey]")

/**
 * get_scheduled_by_event_type
 *
 * Returns the scheduled event, if any, by the event's type.
 * Returns null if no such event exists.
 */
/datum/controller/subsystem/gamemode/proc/get_scheduled_by_event_type(type)
	for(var/datum/scheduled_event/scheduled_event as anything in scheduled_events)
		if(scheduled_event.event.type == text2path(type))
			return scheduled_event
	return null

/datum/controller/subsystem/gamemode/proc/get_event_by_track_and_type(track, type)
	if(isnull(track) || isnull(type))
		return
	var/list/track_events = event_pools[track]
	if(isnull(track_events))
		return

	for(var/datum/round_event_control/event as anything in track_events)
		if(event.type == text2path(type))
			return event
