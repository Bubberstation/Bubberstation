/obj/item/organ/brain/synth
	name = "compact positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"
	/// The last time (in ticks) a message about brain damage was sent. Don't touch.
	var/last_message_time = 0
	var/obj/item/modular_computer/pda/synth/internal_computer
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	var/mmi_type = /obj/item/mmi/posibrain
	var/obj/item/mmi/stored_mmi

/obj/item/organ/brain/synth/Initialize(mapload, obj/item/mmi/brain_mmi)
	. = ..()
	internal_computer = new(src)
	ADD_TRAIT(src, TRAIT_SILICON_EMOTES_ALLOWED, INNATE_TRAIT)
	if(istype(brain_mmi))
		stored_mmi = brain_mmi
		stored_mmi.forceMove(src)
	else
		stored_mmi = new mmi_type(src, FALSE)

/obj/item/organ/brain/synth/Destroy()
	QDEL_NULL(internal_computer)
	QDEL_NULL(stored_mmi)
	. = ..()

/obj/item/organ/brain/synth/Remove(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	if(!istype(stored_mmi) || special)
		return
	stored_mmi.brain = src
	organ_flags |= ORGAN_FROZEN
	stored_mmi.update_appearance()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(nest_into_stored_mmi))

/obj/item/organ/brain/synth/proc/nest_into_stored_mmi(datum/source, atom/old_loc, dir, forced)
	SIGNAL_HANDLER
	if(loc == stored_mmi)
		return
	var/obj/item/mmi/mmi = stored_mmi
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	stored_mmi = null
	var/atom/destination = loc || mmi.drop_location()
	mmi.forceMove(destination)
	forceMove(mmi)

/obj/item/organ/brain/synth/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags = NO_ID_TRANSFER)
	. = ..()
	if(stored_mmi?.brainmob?.mind && stored_mmi.brainmob.mind.current == stored_mmi.brainmob)
		stored_mmi.brainmob.mind.transfer_to(brain_owner)

	if(brain_owner.stat == DEAD && ishuman(brain_owner))
		var/mob/living/carbon/human/user_human = brain_owner
		if(HAS_TRAIT(user_human, TRAIT_REVIVES_BY_HEALING) && user_human.health > SYNTH_BRAIN_WAKE_THRESHOLD)
			user_human.revive(FALSE)

	RegisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_signal))
	RegisterSignal(brain_owner, COMSIG_HUMAN_UNEQUIPPED_ITEM, PROC_REF(on_unequip_signal))

/obj/item/organ/brain/synth/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	cache_brainmob_into_stored_mmi(organ_owner)

	UnregisterSignal(organ_owner, COMSIG_MOB_EQUIPPED_ITEM)
	UnregisterSignal(organ_owner, COMSIG_HUMAN_UNEQUIPPED_ITEM)

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

/obj/item/organ/brain/synth/proc/cache_brainmob_into_stored_mmi(mob/living/carbon/organ_owner)
	if(!istype(stored_mmi))
		return FALSE

	var/mob/living/brain/brainmob_to_store = brainmob
	if(QDELETED(brainmob_to_store))
		brainmob_to_store = null

	if(!brainmob_to_store)
		brainmob_to_store = stored_mmi.brainmob

	if(!brainmob_to_store)
		brainmob_to_store = new /mob/living/brain(stored_mmi)

	if(organ_owner?.mind?.current == organ_owner)
		organ_owner.mind.transfer_to(brainmob_to_store)

	stored_mmi.set_brainmob(brainmob_to_store)
	brainmob_to_store.doMove(stored_mmi)
	brainmob_to_store.container = stored_mmi
	brainmob_to_store.set_stat(CONSCIOUS)
	brainmob_to_store.reset_perspective()
	if(brainmob == brainmob_to_store)
		brainmob = null
	stored_mmi.update_appearance()
	return TRUE

/obj/item/organ/brain/synth/transfer_identity(mob/living/L)
	if(L.mind && L.mind.current && !decoy_override)
		to_chat(L, span_userdanger("Memories Corrupted, Positronic rerolling to most stable version, last version backup ERROR minutes ago, last attacker's: Unknown, unable to pinpoint features, please standby."))
	. = ..()


/obj/item/organ/brain/synth/emp_act(severity) // EMP act against the posi, keep the cap far below the organ health
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				to_chat(owner, span_warning("01001001 00100111 01101101 00100000 01100110 01110101 01100011 01101011 01100101 01100100 00101110"))
				apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)
			if(EMP_LIGHT)
				to_chat(owner, span_warning("Alert: Electromagnetic damage taken in central processing unit. Error Code: 401-YT"))
				apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)

/obj/item/organ/brain/synth/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE)
	. = ..()

	if(owner && damage > 0 && (world.time - last_message_time) > SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL)
		last_message_time = world.time

		if(damage > BRAIN_DAMAGE_SEVERE)
			to_chat(owner, span_warning("Alre: re oumtnin ilir tocorr:pa ni ne:cnrrpiioruloomatt cessingode: P1_1-H"))
			return

		if(damage > BRAIN_DAMAGE_MILD)
			to_chat(owner, span_warning("Alert: Minor corruption in central processing unit. Error Code: 001-HP"))

/obj/item/organ/brain/synth/circuit
	name = "compact AI circuit"
	desc = "A compact and extremely complex circuit, It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit-occupied"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	mmi_type = /obj/item/mmi/posibrain/circuit

/obj/item/organ/brain/synth/mmi
	name = "augmented brain"
	desc = "A augmented organic brain"
	icon = /obj/item/organ/brain::icon
	icon_state = "brain"
	mmi_type = /obj/item/mmi
