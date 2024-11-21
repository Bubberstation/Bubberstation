/datum/quirk/oversized/add(client/client_source)
	. = ..()
	quirk_holder.adjust_mobsize()

/datum/quirk/oversized/remove()
	. = ..()
	quirk_holder.adjust_mobsize()
