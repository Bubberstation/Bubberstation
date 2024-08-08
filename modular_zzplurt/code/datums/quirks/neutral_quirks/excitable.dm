/datum/quirk/excitable/add(client/client_source)
	quirk_holder.AddElement(/datum/element/pet_bonus/headpat)
	. = ..()

/datum/quirk/excitable/remove()
	quirk_holder.RemoveElement(/datum/element/pet_bonus/headpat)
	. = ..()
