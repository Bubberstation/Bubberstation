
/datum/quirk
	/// special case logic for quirks that don't quite handle being transferred properly
	var/cleanup = TRUE

/// Remove any quirks that the client's prefs do not have, and apply any new ones
/datum/controller/subsystem/processing/quirks/proc/OverrideQuirks(mob/living/user, client/applied_client)
	var/list/required_quirks = applied_client.prefs.all_quirks
	var/list/present_quirks = list()
	for(var/datum/quirk/quirk in user.quirks)
		present_quirks[quirk.name] = TRUE
		quirk.cleanup = FALSE
		quirk.remove_from_current_holder(TRUE)

	for(var/quirk_name in required_quirks)
		var/existing_quirk = present_quirks[quirk_name]
		var/quirk_type = quirks[quirk_name]
		var/datum/quirk/quirk = new quirk_type
		quirk.add_to_holder(user, existing_quirk, applied_client)

