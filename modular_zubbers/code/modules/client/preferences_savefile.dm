/datum/preferences/load_preferences()
	. = ..()
	savefile.get_entry("privacy_policy_acknowledged", privacy_policy_acknowledged)

/datum/preferences/save_preferences()
	. = ..()
	savefile.set_entry("privacy_policy_acknowledged", privacy_policy_acknowledged)
