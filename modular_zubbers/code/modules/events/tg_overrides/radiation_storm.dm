/datum/round_event/radiation_storm/announce(fake)
	priority_announce(
		text = "High levels of radiation detected near the station. The entire crew of the station is recomended to find shelter in the technical tunnels of the station.",
		title = "Radiation Alert",
		sound = ANNOUNCER_RADIATION,
	)
	// we trigger the airlocks for a bit to not immediately give away that it's fake
	if(fake && !GLOB.emergency_access)
		make_maint_all_access(silent = TRUE)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(revoke_maint_all_access), FALSE), 90 SECONDS)
