#define MAX_PRE_IMBUE_STORAGE 250
#define REAGENT_CLOTHING_INJECT_AMOUNT 1
#define REAGENT_WEAPON_INJECT_AMOUNT 4
#define REAGENT_STAFF_INJECT_AMOUNT 10
#define MAX_OIL_AP_AMOUNT 10

///Parent component that stores shared info
/datum/component/reagent_imbued/
	///the item that the component is attached to
	var/obj/item/parent_item
	///required type to attach to
	var/obj/item/required_type = /obj/item
	//the imbued reagents
	var/datum/reagents/imbued_reagent
	///the text to show the player what happens
	var/examine_imbued_description = "It is currently imbued with the following:"

/datum/component/reagent_imbued/Initialize(set_slot = null)
	if(!istype(parent, required_type))
		return COMPONENT_INCOMPATIBLE //they need to be clothing, I already said this
	parent_item = parent
	parent_item.create_reagents(MAX_PRE_IMBUE_STORAGE, INJECTABLE | REFILLABLE)


/datum/component/reagent_imbued/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
		examine_list += span_notice("[parent_item] is able to be imbued by dipping it into a container such as a quenching trough, or pouring chemicals into it and then tempering it at a forge!")
	else
		examine_list += span_notice("If you knew a certain smithing trick, you could imbue special chemicals into this...")

	if(imbued_reagent.reagent_list.len >= 1 && (HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING) || HAS_TRAIT(user, TRAIT_REAGENT_SCANNER)))
		add_reagent_imbue_description(examine_list)

/datum/component/reagent_imbued/proc/add_reagent_imbue_description(list/examine_list)
	examine_list += span_notice(examine_imbued_description)
	for (var/datum/reagent/reagent in imbued_reagent.reagent_list)
		examine_list += span_notice("[reagent.volume] units of [reagent.name]")

///Replaces the imbued_reagent with the given new_reagents.
/datum/component/reagent_imbued/proc/set_reagent_imbue(datum/reagents/new_reagents, clear_source_reagents = TRUE, smithing_oil_bonus = TRUE)
	imbued_reagent.clear_reagents()
	new_reagents.trans_to(imbued_reagent, amount = new_reagents.total_volume, copy_only = TRUE, no_react = TRUE)
	if(smithing_oil_bonus)
		apply_smithing_oil_bonus()
	parent_item.color = mix_color_from_reagents(new_reagents.reagent_list)
	if(clear_source_reagents)
		new_reagents.clear_reagents()

///This function modifies the parent item based on how much smithing oil is in our imbued reagent list. Needs to be defined in child subtypes.
/datum/component/reagent_imbued/proc/apply_smithing_oil_bonus()
//the component that is attached to clothes that allows them to be imbued
//ONLY USE THIS FOR CLOTHING
/datum/component/reagent_imbued/clothing
	///the slot that the item will check
	var/checking_slot
	///the human that is wearing the parent_item
	var/mob/living/carbon/human/cloth_wearer
	var/datum/reagents/imbued_reagent = new(maximum = REAGENT_CLOTHING_INJECT_AMOUNT, new_flags = NO_REACT)


	examine_imbued_description = "It will slowly administer the following to its wearer:"
	//the cooldown between each imbue
	COOLDOWN_DECLARE(imbue_cooldown)

/datum/component/reagent_imbued/clothing/Initialize(set_slot = null)
	. = ..()
	if(. != COMPONENT_INCOMPATIBLE)
		if(set_slot)
			checking_slot = set_slot
		RegisterSignal(parent_item, COMSIG_ITEM_EQUIPPED, PROC_REF(set_wearer))
		RegisterSignal(parent_item, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(remove_wearer))
		RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
		START_PROCESSING(SSdcs, src)

/datum/component/reagent_imbued/clothing/Destroy(force, silent)
	parent_item = null
	cloth_wearer = null
	STOP_PROCESSING(SSdcs, src)
	return ..()


/datum/component/reagent_imbued/clothing/proc/set_wearer()
	SIGNAL_HANDLER

	if(!ishuman(parent_item.loc))
		return
	cloth_wearer = parent_item.loc

/datum/component/reagent_imbued/clothing/proc/remove_wearer()
	SIGNAL_HANDLER
	cloth_wearer = null

/datum/component/reagent_imbued/clothing/process(seconds_per_tick)
	if(!parent_item || !cloth_wearer || imbued_reagent.total_volume == 0)
		return

	if(parent_item != cloth_wearer.get_item_by_slot(checking_slot))
		return

	if(!COOLDOWN_FINISHED(src, imbue_cooldown))
		return

	COOLDOWN_START(src, imbue_cooldown, 3 SECONDS)

	imbued_reagent.trans_to(target = cloth_wearer, amount = REAGENT_CLOTHING_INJECT_AMOUNT, methods = INJECT, copy_only = TRUE)

//the component that is attached to weapons that allows them to be imbued
//ONLY USE THIS FOR WEAPONS
/datum/component/reagent_imbued/weapon
	imbued_reagent = new(maximum = REAGENT_WEAPON_INJECT_AMOUNT, NO_REACT)
	examine_imbued_description = "Upon hit, it will inject the following to its victim:"
	var/extra_force_oil_bonus = 0
/datum/component/reagent_imbued/weapon/Initialize(...)
	. = ..()
	if(. != COMPONENT_INCOMPATIBLE)
		RegisterSignal(parent_item, COMSIG_ITEM_ATTACK, PROC_REF(inject_attacked))
		RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/reagent_imbued/weapon/Destroy(force, silent)
	parent_item = null
	return ..()
/datum/component/reagent_imbued/weapon/apply_smithing_oil_bonus()
	parent_item.armour_penetration -= extra_force_oil_bonus
	extra_force_oil_bonus = MAX_OIL_AP_AMOUNT * imbued_reagent.remove_reagent(/datum/reagent/fuel/oil/smithing, imbued_reagent.maximum_volume, safety = TRUE, include_subtypes = FALSE) / imbued_reagent.maximum_volume
	parent_item.armour_penetration += extra_force_oil_bonus

/datum/component/reagent_imbued/weapon/proc/inject_attacked(datum/source, mob/living/target, mob/living/user, list/modifiers)
	SIGNAL_HANDLER

	//don't have the weapon or any imbued reagents? don't try
	if(!parent_item || !length(imbued_reagent))
		return

	//lets inject that target
	var/mob/living_target = target
	imbued_reagent.trans_to(target = living_target, amount = REAGENT_CLOTHING_INJECT_AMOUNT, transferred_by = user, methods = INJECT, copy_only = TRUE)


#undef MAX_PRE_IMBUE_STORAGE
#undef REAGENT_CLOTHING_INJECT_AMOUNT
#undef REAGENT_WEAPON_INJECT_AMOUNT
#undef REAGENT_STAFF_INJECT_AMOUNT
