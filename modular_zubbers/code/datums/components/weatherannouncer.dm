/datum/component/weather_announcer
	var/warning_range_low = 60
	var/warning_range_high = TIME_BLOODSUCKER_DAY_WARN

/datum/component/weather_announcer/Initialize(state_normal, state_warning, state_danger)
	. = ..()
	RegisterSignal(SSsunlight, COMSIG_SOL_NEAR_START, PROC_REF(on_daylight_warning))

/datum/component/weather_announcer/proc/on_daylight_warning(datum/controller/subsystem/processing/sunlight)
	var/variability = rand(warning_range_low, warning_range_high)
	addtimer(CALLBACK(src, PROC_REF(warn_user)), variability)

/datum/component/weather_announcer/proc/warn_user()
	var/list/messages = list(
		"Detecting solar activity. Seek cover if vulnerable.",
		"Warning: Solar flares detected incoming within [TIME_BLOODSUCKER_DAY_WARN] seconds.",
		"Solar activity imminent within [TIME_BLOODSUCKER_DAY_WARN] seconds. Please find shelter.",
	)
	var/atom/movable/speaker = parent
	speaker?.say(pick(messages))
