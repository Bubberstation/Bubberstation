/datum/quirk
	/// Flags related to species whitelists.
	var/quirk_whitelist_flags // Whitelist bitflags in code/__DEFINES/~~bubber_defines/quirk_whitelist.dm

/datum/quirk/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source)
	if(!can_add(new_holder))
		CRASH("Attempted to add quirk to holder that can't have it.")
	. = ..()

/// Returns true if the quirk is valid for the target
/datum/quirk/proc/can_add(mob/target)
	return TRUE
