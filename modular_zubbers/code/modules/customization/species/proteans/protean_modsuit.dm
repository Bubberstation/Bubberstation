/obj/item/mod/control/pre_equipped/protean
	name = "hardsuit rig"
	desc = "The hardsuit rig unit of a Protean, allowing them to retract into it, or to deploy a suit that protects against various environments."
	theme = /datum/mod_theme // Standard theme. TODO: Can be changed with standard mod armors

	applied_core = /obj/item/mod/core/protean
	applied_cell = null // Goes off stomach

	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF // funny nanite
	/// Whether or not the wearer can undeploy parts.
	var/modlocked = FALSE

/datum/mod_theme/protean
	name = "Protean"

/obj/item/mod/control/pre_equipped/protean/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "protean")
	actions_types += list()

/obj/item/mod/control/pre_equipped/protean/wrench_act(mob/living/user, obj/item/wrench)
	return FALSE // Can't remove the core.

/obj/item/mod/control/pre_equipped/protean/emag_act(mob/user, obj/item/card/emag/emag_card)
	return FALSE // Nope

/obj/item/mod/control/pre_equipped/protean/canStrip(mob/who)
	return TRUE

/obj/item/mod/control/pre_equipped/protean/doStrip(mob/stripper, mob/owner) // Custom stripping code.
	if(!isprotean(wearer)) // Strip it normally
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean") // Your ass is coming off.
		return ..()
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if(!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(stripper, span_notice("You empty out all the items from the Protean's internal storage module!"))
		stripper.balloon_alert(stripper, "emptied storage")
		return TRUE

	to_chat(stripper, span_warning("This suit seems to be a part of them. You can't remove it!"))
	stripper.balloon_alert(stripper, "can't strip a protean's suit!")
	return ..()

/obj/item/mod/control/pre_equipped/protean/proc/drop_suit()
	if(wearer)
		wearer.dropItemToGround(src, TRUE, TRUE)
	else
		forceMove(get_turf(loc))

/// Proteans can lock themselves on people.
/obj/item/mod/control/pre_equipped/protean/proc/toggle_lock()
	if(modlocked)
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean")
	modlocked = !modlocked

/obj/item/mod/control/pre_equipped/protean/equipped(mob/user, slot, initial)
	. = ..()

	if(!isprotean(wearer))
		return
	if(slot == ITEM_SLOT_BACK && modlocked)
		ADD_TRAIT(src, TRAIT_NODROP, "protean")
		to_chat(wearer, span_warning("The suit does not seem to be able to come off..."))
