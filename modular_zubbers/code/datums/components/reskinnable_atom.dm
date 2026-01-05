/datum/atom_skin
	/// Optional, worn_icon to change the atom to when applied
	var/new_worn_icon

/datum/atom_skin/apply(atom/apply_to)
	. = ..()
	if(isitem(apply_to))
		var/obj/item/item_apply_to = apply_to
		APPLY_VAR_OR_RESET_INITIAL(item_apply_to, worn_icon, new_worn_icon, reset_missing)

/datum/atom_skin/clear_skin(atom/clear_from)
	. = ..()
	if(isitem(clear_from))
		var/obj/item/item_clear_from = clear_from
		RESET_INITIAL_IF_SET(item_clear_from, worn_icon, new_worn_icon)

/datum/component/reskinable_item/proc/is_using_skin(path)
	return current_skin && istype(current_skin, path)

/datum/component/reskinable_item/proc/has_skin()
	return current_skin != null
