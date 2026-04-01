/datum/weather/rad_storm
	end_duration = 3 SECONDS
	telegraph_message = span_userdanger("The air begins to grow warm.")
	var/maint_flipped = FALSE

/datum/weather/rad_storm/New(...)
	LAZYOR(protected_areas, list(
		/area/station/terminal,
		/area/lavaland,
		/area/ruin,
		/area/moonstation/underground,
		/area/station/cargo/miningelevators,
		/area/station/cargo/miningfoundry/event_protected,
		/area/loopstation/radshelter,
		/area/ruin/unpowered/primitive_catgirl_den,
	))
	. = ..()

/datum/weather/rad_storm/telegraph()
	. = ..()
	if(!GLOB.emergency_access)
		maint_flipped = TRUE
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(make_maint_all_access), TRUE), 0.5 SECONDS) // timed to match the status display

/datum/weather/rad_storm/end()
	. = ..()
	if(maint_flipped)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(revoke_maint_all_access), FALSE), 45 SECONDS)
