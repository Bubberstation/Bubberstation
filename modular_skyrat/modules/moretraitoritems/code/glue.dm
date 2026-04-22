/obj/item/syndie_glue
	name = "bottle of super glue"
	desc = "A black market brand of high strength adhesive, rarely sold to the public. Do not ingest."
	icon = 'modular_skyrat/master_files/icons/obj/tools.dmi'
	icon_state	= "glue"
	w_class = WEIGHT_CLASS_SMALL
	var/uses = 1


/obj/item/syndie_glue/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!uses)
		to_chat(user, span_warning("The bottle of glue is empty!"))
		return NONE

	var/obj/item/interacted = interacting_with
	if(iscarbon(interacting_with))
		if(interacting_with == user)
			return NONE
		var/list/equipment_list = list()
		var/mob/living/carbon/target = interacting_with
		for(var/obj/item/equipped_item as anything in target.get_visible_items())
			var/image/obj_icon = image(icon = initial(equipped_item.icon), icon_state = initial(equipped_item.icon_state))
			equipment_list[equipped_item] = obj_icon
		interacted = show_radial_menu(user, interacting_with, equipment_list, radius = 42)
		if(!isitem(interacted))
			return NONE
		interacting_with.visible_message(span_danger("[user] is trying to apply super glue on [interacting_with]'s [interacted.name]!"), \
			span_userdanger("[user] is trying to apply super glue on your [interacted.name]!"))
		if(!do_after(user, 5 SECONDS))
			return NONE
		interacting_with.visible_message(span_danger("[user] applies super glue on [interacting_with]'s [interacted.name]!"), \
						span_userdanger("[user] applies super glue on your [interacted.name]!"))
	else if(!isitem(interacted))
		return NONE

	if(HAS_TRAIT_FROM(interacted, TRAIT_NODROP, TRAIT_GLUED_ITEM))
		to_chat(user, span_warning("[interacted] is already sticky!"))
		return ITEM_INTERACT_BLOCKING

	uses -= 1
	ADD_TRAIT(interacted, TRAIT_NODROP, TRAIT_GLUED_ITEM)
	interacted.desc += " It looks sticky."
	to_chat(user, span_notice("You smear the [interacted.name] with glue, making it incredibly sticky!"))
	if(uses == 0)
		icon_state = "glue_used"
		name = "empty bottle of super glue"
	return ITEM_INTERACT_SUCCESS
