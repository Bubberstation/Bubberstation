
/// Remove any quirks that the client's prefs do not have, and apply any new ones
/datum/controller/subsystem/processing/quirks/proc/OverrideQuirks(mob/living/user, client/applied_client)
	var/list/required_quirks = applied_client.prefs.all_quirks
	for(var/datum/quirk/quirk in user.quirks)
		if(!(quirk.name in required_quirks))
			user.remove_quirk(quirk.type)
	AssignQuirks(user, applied_client)
