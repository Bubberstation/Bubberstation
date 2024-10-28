/datum/preference/name/emergency
	explanation = "ERT Operative Alias"
	group = "backup_human"
	savefile_key = "centcom_name"

/datum/preference/name/emergency/create_default_value()
	var/name_list = list(
		"Purple Gold", "Cocked Pistol", "Fast Pace", "Round House", "Double Take", "Grenouille", "Orbital", "Internal", "Burnt Oven", "Shattered Sun", "Watchman", "Bureau", "Fault", "Nerve Ground", "Grounding Rod", "Bouncer", "Low Blow", "Nonbeliever", "Sentinel", "Walleye", "Needle Point", "Crusher", "Pest Control", "Runt", "Vermin", "Shield", "Actualization", "Bloodhound", "Pool Boy", "Dreamer", "Hippie", "Packmaster", "Shepard", "Gazer", "Bird's Eye", "Hecate", "Ranger", "Bluescreen", "Anitivirus", "System Restore", "Praetorian", "Wolfram", "Soothsayer", "Witchhunter", "Oracle", "Knight", "Closeout", "Last Call", "Last Hope", "Curtain Call", "Skeleton Crew", "Closer",
	)

	return pick(name_list)
