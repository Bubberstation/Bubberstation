#define MAX_IMBUE_STORAGE 250
#define REAGENT_CLOTHING_INJECT_AMOUNT 0.5
#define REAGENT_WEAPON_INJECT_AMOUNT 1
#define REAGENT_WEAPON_DAMAGE_MULTIPLIER 3

///Parent component that stores shared info
/datum/component/reagent_imbued/
	///the item that the component is attached to
	var/obj/item/parent_item
	//the imbued reagents
	var/list/imbued_reagent = list()

//the component that is attached to clothes that allows them to be imbued
//ONLY USE THIS FOR CLOTHING
/datum/component/reagent_imbued/clothing
	///the slot that the item will check
	var/checking_slot
	///the human that is wearing the parent_item
	var/mob/living/carbon/human/cloth_wearer
	///the container that will apply the chemicals
	var/obj/item/reagent_containers/applying_container
	///the list of imbued reagents that will given to the human owner
	//the cooldown between each imbue
	COOLDOWN_DECLARE(imbue_cooldown)

/datum/component/reagent_imbued/clothing/Initialize(set_slot = null)
	if(!istype(parent, /obj/item))
		return COMPONENT_INCOMPATIBLE //they need to be clothing, I already said this

	if(set_slot)
		checking_slot = set_slot

	parent_item = parent
	parent_item.create_reagents(MAX_IMBUE_STORAGE, INJECTABLE | REFILLABLE)
	applying_container = new /obj/item/reagent_containers(src)
	RegisterSignal(parent_item, COMSIG_ITEM_EQUIPPED, PROC_REF(set_wearer))
	RegisterSignal(parent_item, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(remove_wearer))
	RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	START_PROCESSING(SSdcs, src)

/datum/component/reagent_imbued/clothing/Destroy(force, silent)
	parent_item = null
	cloth_wearer = null
	QDEL_NULL(applying_container)
	STOP_PROCESSING(SSdcs, src)
	return ..()

/datum/component/reagent_imbued/clothing/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("[parent_item] is able to be inbued with a chemical at a reagent forge!")

/datum/component/reagent_imbued/clothing/proc/set_wearer()
	SIGNAL_HANDLER

	if(!ishuman(parent_item.loc))
		return
	cloth_wearer = parent_item.loc

/datum/component/reagent_imbued/clothing/proc/remove_wearer()
	SIGNAL_HANDLER
	cloth_wearer = null

/datum/component/reagent_imbued/clothing/process(seconds_per_tick)
	if(!parent_item || !cloth_wearer || !length(imbued_reagent))
		return

	if(parent_item != cloth_wearer.get_item_by_slot(checking_slot))
		return

	if(!COOLDOWN_FINISHED(src, imbue_cooldown))
		return

	COOLDOWN_START(src, imbue_cooldown, 3 SECONDS)

	for(var/create_reagent in imbued_reagent)
		applying_container.reagents.add_reagent(create_reagent, REAGENT_CLOTHING_INJECT_AMOUNT)
		applying_container.reagents.trans_to(target = cloth_wearer, amount = REAGENT_CLOTHING_INJECT_AMOUNT, methods = INJECT)

//the component that is attached to weapons that allows them to be imbued
//ONLY USE THIS FOR WEAPONS
/datum/component/reagent_imbued/weapon

/datum/component/reagent_imbued/weapon/Initialize(...)
	if(!istype(parent, /obj/item))
		return COMPONENT_INCOMPATIBLE //they need to be weapons, I already said this
	parent_item = parent
	parent_item.create_reagents(MAX_IMBUE_STORAGE, INJECTABLE | REFILLABLE)
	RegisterSignal(parent_item, COMSIG_ITEM_ATTACK, PROC_REF(inject_attacked))
	RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/reagent_imbued/weapon/Destroy(force, silent)
	parent_item = null
	return ..()

/datum/component/reagent_imbued/weapon/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("[parent_item] is able to be imbued with a chemical at a reagent forge!")

/datum/component/reagent_imbued/weapon/proc/inject_attacked(datum/source, mob/living/target, mob/living/user, list/modifiers)
	SIGNAL_HANDLER

	//don't have the weapon or any imbued reagents? don't try
	if(!parent_item || !length(imbued_reagent))
		return

	//lets inject that target
	var/mob/living_target = target
	for(var/create_reagent in imbued_reagent)
		living_target.reagents.add_reagent(create_reagent, REAGENT_WEAPON_INJECT_AMOUNT)
		parent_item.take_damage(length(imbued_reagent) * REAGENT_WEAPON_DAMAGE_MULTIPLIER)


#undef MAX_IMBUE_STORAGE
#undef REAGENT_CLOTHING_INJECT_AMOUNT
#undef REAGENT_WEAPON_INJECT_AMOUNT
#undef REAGENT_WEAPON_DAMAGE_MULTIPLIER
