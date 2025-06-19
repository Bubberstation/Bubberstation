
/// Remove any quirks that the client's prefs do not have, and apply any new ones
/datum/controller/subsystem/processing/quirks/proc/OverrideQuirks(mob/living/user, client/applied_client)
	var/list/required_quirks = applied_client.prefs.all_quirks
	for(var/datum/quirk/quirk in user.quirks)
		user.remove_quirk(quirk.type)

	for(var/quirk_name as anything in required_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		user.add_quirk(quirk_type, applied_client, FALSE)
