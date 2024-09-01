/datum/quirk/numb
	/datum/quirk/numb/add(client/client_source)
		. = ..()
		quirk_holder.add_traits(TRAIT_ANALGESIA)
	/datum/quirk/numb/remove(client/client_source)
		. = ..()
		quirk_holder.remove_traits(TRAIT_ANALGESIA)
