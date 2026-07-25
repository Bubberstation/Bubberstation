/// Custom computer for synth brains
/obj/item/modular_computer/pda/synth
	name = "virtual persocom"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "posibrain"
	base_icon_state = "posibrain"
	greyscale_config = null
	base_active_power_usage = 0 WATTS
	base_idle_power_usage = 0 WATTS

	long_ranged = TRUE //Synths have good antennae

	max_idle_programs = 3

	max_capacity = 64
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/modular_computer/pda/synth/Initialize(mapload)
	. = ..()

	// prevent these from being created outside of valid brains
	if(!istype(loc, /obj/item/organ/brain/synth) && !istype(loc, /obj/item/organ/brain/cybernetic/cortical) && !istype(loc, /obj/item/organ/brain/cybernetic/surplus))
		return INITIALIZE_HINT_QDEL

/obj/item/modular_computer/pda/synth/proc/update_user_settings(client/client)
	var/obj/item/organ/brain/cybernetic/brainpooter = loc
	var/mob/living/brain_owner = brainpooter.owner
	if(!isnull(brain_owner))
		imprint_id("[brain_owner.real_name] Persocom", brain_owner.job)
		var/datum/mind/owner_mind = brain_owner?.mind
		if(!isnull(owner_mind))
			update_ringtone(owner_mind?.assigned_role?.job_tone)
		UpdateDisplay()
		if(!isnull(client))
			update_pda_prefs(client)

/obj/item/modular_computer/pda/synth/check_power_override()
	return TRUE

/datum/action/item_action/synth/open_internal_computer
	name = "Open persocom emulation"
	desc = "Accesses your built-in virtual machine."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/brain/synth/synth_brain = target
	if(istype(synth_brain))
		synth_brain.internal_computer.interact(owner)
		return
	var/obj/item/organ/brain/cybernetic/cortical/cort_brain = target
	if(istype(cort_brain))
		cort_brain.internal_computer.interact(owner)
		return
	var/obj/item/organ/brain/cybernetic/surplus/surp_brain = target
	if(istype(surp_brain))
		surp_brain.internal_computer.interact(owner)

/obj/item/modular_computer/pda/synth/ui_state(mob/user)
	return GLOB.default_state

/obj/item/modular_computer/pda/synth/ui_status(mob/user)
	var/obj/item/organ/brain/brain_loc = loc
	if(!(istype(brain_loc, /obj/item/organ/brain/synth) || istype(brain_loc, /obj/item/organ/brain/cybernetic/cortical) || istype(brain_loc, /obj/item/organ/brain/cybernetic/surplus)))
		return UI_CLOSE

	if(!QDELETED(brain_loc.owner))
		return min(
			ui_status_user_is_abled(user, src),
			ui_status_only_living(user),
			ui_status_user_is_adjacent(user, brain_loc.owner),
		)
	return ..()

/// Id card arg is optional. Leaving it null causes the id to become unpaired from the synth computer
/obj/item/modular_computer/pda/synth/proc/update_id_slot(obj/item/card/id/id_card)
	var/obj/item/organ/brain/brain_loc = loc
	if(!(istype(brain_loc, /obj/item/organ/brain/synth) || istype(brain_loc, /obj/item/organ/brain/cybernetic/cortical) || istype(brain_loc, /obj/item/organ/brain/cybernetic/surplus)))
		return
	if(istype(brain_loc, /obj/item/organ/brain/synth))
		var/obj/item/organ/brain/synth/synth_brain = brain_loc
		if(isnull(synth_brain.internal_computer))
			return
		synth_brain.internal_computer.handle_id_slot(synth_brain.owner, id_card)
		return
	var/obj/item/organ/brain/cybernetic/cortical/cortical_brain = brain_loc
	if(isnull(cortical_brain.internal_computer))
		return
	cortical_brain.internal_computer.handle_id_slot(cortical_brain.owner, id_card)
	var/obj/item/organ/brain/cybernetic/surplus/surplus_brain = brain_loc
	if(isnull(surplus_brain.internal_computer))
		return
	surplus_brain.internal_computer.handle_id_slot(surplus_brain.owner, id_card)


/// Called when id slot item is unequipped from the id slot
/obj/item/modular_computer/pda/synth/proc/on_id_item_unequipped(datum/source)
	SIGNAL_HANDLER
	clear_id_slot_signals(source)
	update_id_slot()

/// Called when id slot item's contained id is moved out of the id slot item
/obj/item/modular_computer/pda/synth/proc/on_id_item_moved(datum/source)
	SIGNAL_HANDLER
	clear_id_slot_signals(source)
	update_id_slot()

/// Called when something is inserted into an id slot wallet or pda
/obj/item/modular_computer/pda/synth/proc/on_id_item_stored(datum/source, obj/item/card/id/to_insert)
	SIGNAL_HANDLER
	if(!istype(to_insert))
		return

	UnregisterSignal(source, COMSIG_STORAGE_STORED_ITEM)
	update_id_slot(to_insert)

/obj/item/modular_computer/pda/synth/proc/clear_id_slot_signals(obj/item/id_slot_item)
	if(!istype(id_slot_item))
		return

	UnregisterSignal(id_slot_item, list(
		COMSIG_ITEM_POST_UNEQUIP,
		COMSIG_MOVABLE_MOVED,
		COMSIG_ITEM_UNSTORED,
		COMSIG_STORAGE_STORED_ITEM,
		COMSIG_MODULAR_COMPUTER_INSERTED_ID,
	))

	// make sure we clear all the signals on the contained id too
	var/obj/item/card/id/contained_id_item
	if(istype(id_slot_item, /obj/item/modular_computer/pda))
		var/obj/item/modular_computer/pda/id_slot_pda = id_slot_item
		contained_id_item = id_slot_pda.stored_id
	else if(istype(id_slot_item, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/id_slot_wallet = id_slot_item
		contained_id_item = id_slot_wallet.GetID()

	if(contained_id_item)
		UnregisterSignal(contained_id_item, list(COMSIG_MOVABLE_MOVED, COMSIG_ITEM_UNSTORED))

/obj/item/modular_computer/pda/synth/proc/handle_id_slot(mob/living/carbon/human/synth, obj/item/id_item)
	if(!istype(synth))
		return
	if(isnull(id_item))
		if(stored_id)
			to_chat(synth, span_notice("Persocom RFID link disconnected."))
		stored_id = null
		return
	if(istype(id_item, /obj/item/card/id))
		stored_id = id_item
		to_chat(synth, span_notice("Persocom establishing new RFID link with [id_item]."))
		RegisterSignal(id_item, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_id_item_unequipped))
	else if(istype(id_item, /obj/item/modular_computer))
		var/obj/item/modular_computer/pda = id_item
		stored_id = pda.stored_id
		to_chat(synth, span_notice("Persocom establishing new RFID link with [pda]."))
		RegisterSignal(pda, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_id_item_unequipped))
		RegisterSignal(pda, COMSIG_MODULAR_COMPUTER_INSERTED_ID, PROC_REF(on_id_item_stored))
		RegisterSignal(pda.stored_id, COMSIG_MOVABLE_MOVED, PROC_REF(on_id_item_moved))
	else if(istype(id_item, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/your_wallet = id_item
		stored_id = your_wallet.GetID()
		to_chat(synth, span_notice("Persocom establishing new RFID link with [your_wallet]."))
		RegisterSignal(your_wallet, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_id_item_unequipped))
		RegisterSignal(your_wallet, COMSIG_STORAGE_STORED_ITEM, PROC_REF(on_id_item_stored))
		RegisterSignal(your_wallet.GetID(), COMSIG_ITEM_UNSTORED, PROC_REF(on_id_item_moved))

	else
		stored_id = null

/obj/item/modular_computer/pda/synth/remove_id(mob/user, silent = FALSE)
	return

/obj/item/modular_computer/pda/synth/get_ntnet_status()
	. = ..()
	if(is_centcom_level(loc.z)) // Centcom is excluded because cafe
		return NTNET_NO_SIGNAL


/obj/item/modular_computer/pda/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/targetmachine = target_mob
	if(!istype(targetmachine))
		return ..()

	var/obj/item/organ/brain/synth/robotbrain = targetmachine.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(robotbrain))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "establishing SSH login with persocom...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "connection established")
				to_chat(targetmachine, span_notice("[user] establishes an SSH connection between [src] and your persocom emulation."))
				robotbrain.internal_computer.interact(user)
			return

	// Also supports cortical augmented brains and surplus
	var/obj/item/organ/brain/cybernetic/cortical/cortbrain = targetmachine.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(cortbrain))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "establishing SSH login with persocom...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "connection established")
				to_chat(targetmachine, span_notice("[user] establishes an SSH connection between [src] and your persocom emulation."))
				cortbrain.internal_computer.interact(user)
			return

	var/obj/item/organ/brain/cybernetic/surplus/surpbrain = targetmachine.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(surpbrain))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "establishing SSH login with persocom...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "connection established")
				to_chat(targetmachine, span_notice("[user] establishes an SSH connection between [src] and your persocom emulation."))
				surpbrain.internal_computer.interact(user)
			return
	return ..()


/obj/item/modular_computer/pda/synth/get_header_data()
	var/list/data = ..()
	var/obj/item/organ/brain/brain_loc = loc
	// Battery level is now according to the synth charge
	if(istype(brain_loc, /obj/item/organ/brain/synth) || istype(brain_loc, /obj/item/organ/brain/cybernetic/cortical) || istype(brain_loc, /obj/item/organ/brain/cybernetic/surplus))
		var/charge_level = (brain_loc.owner.nutrition / NUTRITION_LEVEL_FULL) * 100
		switch(charge_level)
			if(80 to 110)
				data["PC_batteryicon"] = "batt_100.gif"
			if(60 to 80)
				data["PC_batteryicon"] = "batt_80.gif"
			if(40 to 60)
				data["PC_batteryicon"] = "batt_60.gif"
			if(20 to 40)
				data["PC_batteryicon"] = "batt_40.gif"
			if(5 to 20)
				data["PC_batteryicon"] = "batt_20.gif"
			else
				data["PC_batteryicon"] = "batt_5.gif"
		data["PC_batterypercent"] = "[round(charge_level)]%"
	return data
