//DEFAULT NECK ITEMS OVERRIDE//

/// Translator Necklace
#define LANGUAGE_TRANSLATOR "translator"

/obj/item/clothing/neck/necklace/translator/
	name = "ashen necklace"
	desc = "A necklace crafted from ash, connected to the Necropolis through the core of a Legion. This imbues overdwellers with an unnatural understanding of Ashtongue, the native language of Lavaland, while worn."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	slot_flags = ITEM_SLOT_NECK | ITEM_SLOT_OCLOTHING
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.
	/// The language granted by this necklace
	var/datum/language/language_granted = /datum/language/ashtongue
	/// Where the power comes from
	var/power_source = "the Necropolis"


/obj/item/clothing/neck/necklace/translator/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_necklace_equip))


/// Handles giving the language to the equipper when equipped.
/obj/item/clothing/neck/necklace/translator/proc/on_necklace_equip(datum/source, mob/living/carbon/human/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot_flags & slot))
		return

	if(!istype(equipper))
		return

	equipper.grant_language(language_granted, source = LANGUAGE_TRANSLATOR)
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_necklace_unequip))

	equip_feedback(equipper)


/// Handles sending text feedback to the equipper. Override to change the text.
/obj/item/clothing/neck/necklace/translator/proc/equip_feedback(mob/living/carbon/human/equipper)
	to_chat(equipper, span_boldnotice( \
		"Slipping the necklace on, you feel the insidious creep of [power_source] \
		enter your bones, your very shadow and soul. You find yourself with an \
		unnatural knowledge of the [initial(language_granted.name)]; but the \
		amulet's eye stares back at you with a gleeful intent. Causing you to \
		shiver with unease, you don't want to keep this on forever." \
	))


/// Handles removing the language from the unequipper when unequipped.
/obj/item/clothing/neck/necklace/translator/proc/on_necklace_unequip(obj/item/source, mob/living/carbon/human/unequipper)
	SIGNAL_HANDLER

	if(!istype(unequipper))
		return

	unequipper.remove_language(language_granted, source = LANGUAGE_TRANSLATOR)
	UnregisterSignal(source, COMSIG_ITEM_DROPPED)

	unequip_feedback(unequipper)


/// Handles sending text feedback to the unequipper. Override to change the text.
/obj/item/clothing/neck/necklace/translator/proc/unequip_feedback(mob/living/carbon/human/unequipper)
	to_chat(unequipper, span_boldnotice( \
		"You feel the alien mind of [power_source] lose its interest in you as \
		you remove the necklace. The eye closes, and your mind does as well, \
		losing its grasp of [initial(language_granted.name)]" \
	))


#undef LANGUAGE_TRANSLATOR
