/datum/preference/name/emergency
	explanation = "ERT Operative Alias"
	group = "backup_human"
	savefile_key = "centcom_name"

/datum/preference/name/emergency/create_default_value()
	var/name_list = list(
		"Purple Gold", "Cocked Pistol", "Fast Pace", "Round House", "Double Take", "Gren", "Orbital", "Internal", "Burnt Oven", "Shattered Sun", "Watchman", "Bureau", "Fault", "Nerve Ground", "Grounding Rod", "Bouncer", "Prometheus", "Low Blow", "Nonbeliever", "Sentinel", "Walleye", "Needle Point", "Crusher", "Pest Control", "Runt", "Vermin", "Shield",
	)

	return pick(name_list)
