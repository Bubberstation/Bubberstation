SUBSYSTEM_DEF(ozyvents)
	name = "Ozzy Events"
	wait = 10 SECONDS
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	var/last_event_time
	var/random_delay
	var/list/static/low_events = list(
		/datum/round_event_control/vent_clog,
		/datum/round_event_control/wisdomcow,
		/datum/round_event_control/wormholes,
		/datum/round_event_control/sandstorm,
		/datum/round_event_control/shuttle_insurance,
		/datum/round_event_control/fake_virus,
		/datum/round_event_control/aurora_caelus,
	)
	var/list/static/med_events = list(
		/datum/round_event_control/ion_storm,
		/datum/round_event_control/grid_check,
		/datum/round_event_control/portal_storm_syndicate,
		/datum/round_event_control/processor_overload,
		/datum/round_event_control/carp_migration,
		/datum/round_event_control/anomaly/anomaly_grav/high,
		/datum/round_event_control/anomaly/anomaly_pyro,
		/datum/round_event_control/anomaly/anomaly_dimensional,
	)

/datum/controller/subsystem/ozyvents/fire()
	if(last_event_time >= (world.timeofday + random_delay))
		message_admins("No events firing. Too soon!")
		return
	var/probability_dice = rand(0, length(GLOB.player_list))
	var/event_will_run
	if(length(GLOB.needs_chaos) >= probability_dice)
		message_admins("[probability_dice] chanced to roll an event this cycle.")
	var/medium_event_roll = rand(1,5)
	var/datum/round_event_control/round_event_control
	if(medium_event_roll < 3)
		round_event_control = pick(med_events)
	else
		round_event_control = pick(low_events)

	. = new round_event_control()
	round_event_control.run_event()
	message_admins("We ran [.]")
	random_delay = rand(4 MINUTES, 15 MINUTES)
