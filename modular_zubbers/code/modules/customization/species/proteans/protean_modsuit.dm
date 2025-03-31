/obj/item/mod/control/pre_equipped/protean
	name = "hardsuit rig"
	desc = "The hardsuit rig unit of a Protean, allowing them to retract into it, or to deploy a suit that protects against various environments."
	theme = /datum/mod_theme // Standard theme. TODO: Can be changed with standard mod armors

	applied_core = /obj/item/mod/core/protean
	applied_cell = null

/datum/mod_theme/protean
	name = "Protean"

/obj/item/mod/control/pre_equipped/protean/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, QUIRK_TRAIT)
	actions_types += list()

/obj/item/mod/control/pre_equipped/protean/wrench_act(mob/living/user, obj/item/wrench)
	return FALSE // Can't remove the core.

/obj/item/mod/control/pre_equipped/protean/doStrip(mob/stripper, mob/owner) // Custom stripping code.
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if(!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(stripper, span_notice("You empty out all the items from the Protean's internal storage module!"))
		stripper.balloon_alert(stripper, "emptied storage")
		return TRUE

	to_chat(stripper, span_warning("This suit seems to be a part of them. You can't remove it!"))
	stripper.balloon_alert(stripper, "can't strip a protean's suit!")
	return ..()

