#define EVENT_TRAITS "event_traits"


/datum/controller/subsystem/processing/station/pick_traits(trait_sign, budget)
	if(SSround_events.active_event)
		return
	..()

SUBSYSTEM_DEF(round_events)
	name = "Round events"
	priority = 800

	var/datum/full_round_event/active_event

	var/datum/full_round_event/planed_event

	var/force_dnr = FALSE

	var/observation_lock = FALSE

	/// state for if the roundstart signal has already run, so we can play catchup in set_active_event
	var/post_roundstart = FALSE

	/// state for if the pregame signal has already run, so we can play catchup in set_active_event
	var/post_pregame = FALSE



/datum/controller/subsystem/round_events/Initialize()
	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(on_round_starting))
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_enter_pregame))
	if(!active_event)
		return SS_INIT_NO_NEED

/datum/controller/subsystem/round_events/proc/set_active_event(datum/full_round_event/event)
	if(!ispath(event, /datum/full_round_event))
		return
	event = new event()
	active_event = event

	active_event.initialize()
	force_dnr = active_event.force_dnr

	if(!active_event.start_time)
		active_event.start_time = world.time

	if(active_event.disable_dynamic)
		SSdynamic.can_fire = FALSE
		SSdynamic.wait = 0
		QDEL_NULL(SSgamemode.storyteller)
		SSgamemode.can_fire = FALSE

	if(active_event.lock_respawn)
		CONFIG_SET(flag/allow_respawn, RESPAWN_FLAG_DISABLED)
		message_admins(span_adminnotice("the current active event has disabled respawning for this round."))
		to_chat(world, span_boldwarning("Respawning has been disabled for this round due to the active event."))

	if(active_event.delay_round_start)
		SSticker.SetTimeLeft(INFINITY)
		SSticker.start_immediately = FALSE

	for(var/datum/controller/subsystem/SS in active_event.supressed_subsystems)
		var/datum/controller/subsystem/instance = locate(SS) in Master.subsystems
		if(instance)
			instance.can_fire = FALSE

	if(active_event.disable_ai)
		CONFIG_SET(flag/allow_ai, FALSE)

	if(active_event.disable_synthetics)
		for(var/datum/job/J in SSjob.all_occupations)
			if(istype(J, /datum/job/cyborg))
				J.total_positions = 0
				J.spawn_positions = 0

	can_fire = TRUE

	if(post_pregame)
		on_enter_pregame()
		announce_event()

	if(post_roundstart)
		on_round_starting(world.time)

/datum/controller/subsystem/round_events/proc/on_enter_pregame()
	SIGNAL_HANDLER
	post_pregame = TRUE

/datum/controller/subsystem/round_events/proc/on_round_starting(start_time)
	SIGNAL_HANDLER

	active_event?.roundstart(start_time)
	post_roundstart = TRUE

/datum/controller/subsystem/round_events/fire(resumed)
	if(!active_event)
		flags |= SS_NO_FIRE
	active_event.event_process(resumed)


/datum/controller/subsystem/round_events/proc/announce_event()
	if(active_event)
		active_event.lobby_loaded()
		to_chat(world, "<span class='infoplain'><div class=\"motd\">[active_event.short_desc]</div></span>", handle_whitespace=FALSE)
		world.update_status()


/datum/controller/subsystem/round_events/proc/on_client_joined(client/user)
	if(active_event)
		active_event.client_joined(user)


/datum/controller/subsystem/round_events/proc/on_player_spawned(client/user, mob/living/player)
	if(active_event)
		active_event.new_player_spawned(user, player)


/datum/controller/subsystem/round_events/proc/on_player_dead(mob/living/player)
	if(!active_event)
		return
	active_event.player_dead(player)



#undef EVENT_TRAITS
