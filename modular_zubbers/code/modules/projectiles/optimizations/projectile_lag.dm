/datum/controller/subsystem/processing/projectiles
	var/real_time = 0
	var/real_time_stamp = -1
	/// Longest real deciseconds one tick of movement is animated over so a lag spikes don't leap too much
	var/max_animation_window = 1.5

/// Realtime deciseconds sampled once per tick, so we don't depend on timing that's slowed down by TD
/datum/controller/subsystem/processing/projectiles/proc/real_now()
	if (real_time_stamp != world.time)
		real_time_stamp = world.time
		real_time = rustg_time_milliseconds("projectiles") / 100
	return real_time

/datum/controller/subsystem/processing/projectiles/fire(resumed = FALSE)
	flush_logs(budgeted = TRUE)
	if (MC_TICK_CHECK)
		return
	return ..()
