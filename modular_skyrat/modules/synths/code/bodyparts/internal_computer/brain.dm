/obj/item/organ/brain/synth
	var/obj/item/modular_computer/pda/synth/internal_computer
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

/obj/item/organ/brain/synth/Initialize(mapload, obj/item/mmi/brain_mmi)
	. = ..()
	internal_computer = new(src)
	ADD_TRAIT(src, TRAIT_SILICON_EMOTES_ALLOWED, INNATE_TRAIT)

/obj/item/organ/brain/synth/Destroy()
	QDEL_NULL(internal_computer)
	return ..()

/obj/item/organ/brain/synth/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()
	if(stored_mmi?.brainmob?.mind && stored_mmi.brainmob.mind.current == stored_mmi.brainmob)
		stored_mmi.brainmob.mind.transfer_to(brain_owner)

	if(brain_owner.stat == DEAD && ishuman(brain_owner))
		var/mob/living/carbon/human/user_human = brain_owner
		if(HAS_TRAIT(user_human, TRAIT_REVIVES_BY_HEALING) && user_human.health > SYNTH_BRAIN_WAKE_THRESHOLD)
			user_human.revive(FALSE)

	RegisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_signal))
	RegisterSignal(brain_owner, COMSIG_HUMAN_UNEQUIPPED_ITEM, PROC_REF(on_unequip_signal))

/obj/item/organ/brain/synth/on_mob_remove(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()
	cache_brainmob_into_stored_mmi(brain_owner)

	UnregisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM)
	UnregisterSignal(brain_owner, COMSIG_HUMAN_UNEQUIPPED_ITEM)

/obj/item/organ/brain/synth/Remove(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	var/atom/drop_target = organ_owner ? organ_owner.drop_location() : drop_location()
	. = ..()
	if(istype(stored_mmi))
		stored_mmi.forceMove(drop_target)
	qdel(src)

/obj/item/organ/brain/synth/proc/on_equip_signal(datum/source, obj/item/item, slot)
	SIGNAL_HANDLER
	if(isnull(internal_computer))
		return
	if(slot == ITEM_SLOT_ID)
		internal_computer.handle_id_slot(owner)

/obj/item/organ/brain/synth/proc/on_unequip_signal(datum/source, obj/item/dropped_item, force, new_location)
	SIGNAL_HANDLER
	if(isnull(internal_computer))
		return
	internal_computer.handle_id_slot(owner)
