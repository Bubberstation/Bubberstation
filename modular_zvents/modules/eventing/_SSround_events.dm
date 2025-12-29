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



/datum/controller/subsystem/round_events/Initialize()
	if(!active_event)
		return SS_INIT_NO_NEED

	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(on_setup))
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_enter_setup))

	active_event.initialize()
	force_dnr = active_event.force_dnr

	if(!active_event.start_time)
		active_event.start_time = world.time


	if(active_event.disable_dynamic)
		SSdynamic.can_fire = FALSE
		SSdynamic.wait = 0

	if(active_event.lock_respawn)
		CONFIG_SET(flag/allow_respawn, RESPAWN_FLAG_DISABLED)
		message_admins(span_adminnotice("active event force disabled respawns."))

	if(active_event.only_related_observe)
		disable_free_observation()

	if(active_event.delay_round_start)
		SSticker.SetTimeLeft(INFINITE_RESKIN)
		SSticker.start_immediately = FALSE

	for(var/datum/controller/subsystem/SS in active_event.supressed_subsystems)
	/*
		Master.subsystems(SS).can_fire = FALSE
		Master.subsystems(SS).wait = 0
	*/
	if(active_event.disable_ai)
		CONFIG_SET(flag/allow_ai, FALSE)

	if(active_event.disable_synthetics)
		for(var/datum/job/J in SSjob.all_occupations)
			if(istype(J, /datum/job/cyborg))
				J.total_positions = 0
				J.spawn_positions = 0



/datum/controller/subsystem/round_events/proc/on_enter_setup()
	SIGNAL_HANDLER

	active_event.lobby_loaded()
	to_chat(world, "<span class='infoplain'><div class=\"motd\">[active_event.short_desc]</div></span>", handle_whitespace=FALSE)
	world.update_status()


/datum/controller/subsystem/round_events/fire(resumed)
	if(!active_event)
		flags |= SS_NO_FIRE
	active_event.event_process(resumed)


/datum/controller/subsystem/round_events/proc/on_setup(start_time)
	SIGNAL_HANDLER

	active_event.roundstart(start_time)



/datum/controller/subsystem/round_events/proc/announce_event()



/datum/controller/subsystem/round_events/proc/disable_free_observation()
	observation_lock = TRUE
	for(var/datum/space_level/level in SSmapping.levels_by_trait(ZTRAIT_STATION))
		level.traits |= list(ZTRAIT_SECRET  = TRUE, \
							ZTRAIT_NOXRAY = TRUE, \
							ZTRAIT_NOPHASE = TRUE)
		SSweather.update_z_level(level)

/datum/controller/subsystem/round_events/proc/enable_free_observation()
	observation_lock = FALSE
	for(var/datum/space_level/level in SSmapping.levels_by_trait(ZTRAIT_STATION))
		level.traits -= ZTRAIT_SECRET | ZTRAIT_NOXRAY | ZTRAIT_NOPHASE
		SSweather.update_z_level(level)

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
