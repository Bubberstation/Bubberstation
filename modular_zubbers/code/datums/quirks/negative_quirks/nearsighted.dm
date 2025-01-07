/obj/item/prescription_lenses
	name = "spare lens kit"
	desc = "Little toolbox with some spare prescription lenses, with everything you need to switch out old lenses on glasses."
	icon = 'modular_zubbers/icons/obj/items_and_weapons.dmi'
	icon_state = "prescriptionkit"

/obj/item/prescription_lenses/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/clothing/glasses))
		to_chat(user, span_warning("These are not glasses!"))
		return ITEM_INTERACT_SKIP_TO_ATTACK

	var/obj/item/clothing/glasses = interacting_with
	if(TRAIT_NEARSIGHTED_CORRECTED in glasses.clothing_traits)
		to_chat(user, span_warning("These already have prescription lenses!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("You've changed out the lenses on \the [interacting_with]."))
	glasses.attach_clothing_traits(TRAIT_NEARSIGHTED_CORRECTED)
	glasses.name = "prescription [glasses.name]"
	glasses.desc += " These seem to have prescription lenses inserted in them."
	qdel(src)
	return ITEM_INTERACT_SUCCESS
