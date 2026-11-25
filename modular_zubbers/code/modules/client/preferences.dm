/datum/preferences/refresh_membership()
	. = ..()
	donator_status = !!GLOB.donator_list[parent.ckey]
	if(unlock_content || donator_status)
		max_save_slots = 100

/// Antag opt-ins saved under role names that have since been renamed
/datum/preferences/sanitize_be_special(list/input_be_special)
	var/static/list/renamed_roles = list(
		"Bloodsucker" = ROLE_VAMPIRE,
		"Bloodsucker (Midround)" = ROLE_VAMPIRIC_ACCIDENT,
		"Bloodsucker (Latejoin)" = ROLE_VAMPIRE_BREAKOUT,
		"Ghoul" = ROLE_VASSAL,
	)
	var/list/migrated = list()
	for(var/role in input_be_special)
		migrated |= renamed_roles[role] || role
	return ..(migrated)
