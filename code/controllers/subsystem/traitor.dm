SUBSYSTEM_DEF(traitor)
	name = "Traitor"
	flags = SS_KEEP_TIMING
	wait = 10 SECONDS
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	/// A list of all uplink items mapped by type
	var/list/uplink_items_by_type = list()
	/// A list of all uplink items
	var/list/uplink_items = list()

	/// The coefficient multiplied by the current_global_progression for new joining traitors to calculate their progression
	var/newjoin_progression_coeff = 1
	/// The current progression that all traitors should be at in the round
	var/current_global_progression = 0
	/// The amount of deviance from the current global progression before you start getting 2x the current scaling or no scaling at all
	/// Also affects objectives, so -50% progress reduction or 50% progress boost.
	var/progression_scaling_deviance = 20 MINUTES
	/// The current uplink handlers being managed
	var/list/datum/uplink_handler/uplink_handlers = list()
	/// The current scaling per minute of progression. Has a maximum value of 1 MINUTES.
	var/current_progression_scaling = 1 MINUTES

/datum/controller/subsystem/traitor/Initialize()
	for(var/theft_item in subtypesof(/datum/objective_item/steal))
		new theft_item
	return SS_INIT_SUCCESS

/datum/controller/subsystem/traitor/fire(resumed)
	var/player_count = length(GLOB.alive_player_list)
	// Has a maximum of 1 minute, however the value can be lower if there are lower players than the ideal
	// player count for a traitor to be threatening. Rounds to the nearest 10% of a minute to prevent weird
	// values from appearing in the UI. Traitor scaling multiplier bypasses the limit and only multiplies the end value.
	// from all of our calculations.
	current_progression_scaling = max(min(
		(player_count / CONFIG_GET(number/traitor_ideal_player_count)) * 1 MINUTES,
		1 MINUTES
	), 0.1 MINUTES) * CONFIG_GET(number/traitor_scaling_multiplier)

	var/progression_scaling_delta = (wait / (1 MINUTES)) * current_progression_scaling
	var/previous_global_progression = current_global_progression

	current_global_progression += progression_scaling_delta
	for(var/datum/uplink_handler/handler in uplink_handlers)
		if(!handler.has_progression || QDELETED(handler))
			uplink_handlers -= handler
		var/deviance = (previous_global_progression - handler.progression_points) / progression_scaling_deviance
		if(abs(deviance) < 0.01)
			// If deviance is less than 1%, just set them to the current global progression
			// Prevents problems with precision errors.
			handler.progression_points = current_global_progression
		else
			var/amount_to_give = progression_scaling_delta + (progression_scaling_delta * deviance)
			amount_to_give = clamp(amount_to_give, 0, progression_scaling_delta * 2)
			handler.progression_points += amount_to_give
		handler.on_update()

/datum/controller/subsystem/traitor/proc/register_uplink_handler(datum/uplink_handler/uplink_handler)
	if(!uplink_handler.has_progression)
		return
	uplink_handlers |= uplink_handler
	// An uplink handler can be registered multiple times if they get assigned to new uplinks, so
	// override is set to TRUE here because it is intentional that they could get added multiple times.
	RegisterSignal(uplink_handler, COMSIG_QDELETING, PROC_REF(uplink_handler_deleted), override = TRUE)

/datum/controller/subsystem/traitor/proc/uplink_handler_deleted(datum/uplink_handler/uplink_handler)
	SIGNAL_HANDLER
	uplink_handlers -= uplink_handler
