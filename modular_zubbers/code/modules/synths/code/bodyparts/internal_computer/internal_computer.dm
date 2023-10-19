/// Custom computer for synth brains
/obj/item/modular_computer/synth
	name = "Synthetic internal computer"

	base_active_power_usage = 0
	base_idle_power_usage = 0

	long_ranged = TRUE //Synths have good antenae

	hardware_flag = PROGRAM_CONSOLE

	var/obj/item/organ/internal/brain/synth/owner_brain

/obj/item/modular_computer/synth/RemoveID(mob/user)
	if(!computer_id_slot)
		return ..()

	if(crew_manifest_update)
		GLOB.manifest.modify(computer_id_slot.registered_name, computer_id_slot.assignment, computer_id_slot.get_trim_assignment())

	if(user && !issilicon(user) && in_range(physical, user))
		user.put_in_hands(computer_id_slot)
	else
		computer_id_slot.forceMove(physical.loc) //We actually update the physical on brain removal/insert

	computer_id_slot = null
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	balloon_alert(user, "removed ID")

/obj/item/modular_computer/synth/get_ntnet_status()
	// NTNet is down and we are not connected via wired connection. The synth is no more
	if(!find_functional_ntnet_relay() || !owner_brain.owner)
		return NTNET_NO_SIGNAL
	var/turf/current_turf = get_turf(physical)
	if(is_station_level(current_turf.z))
		return NTNET_GOOD_SIGNAL
	else if(long_ranged)
		return NTNET_LOW_SIGNAL
	return NTNET_NO_SIGNAL

/obj/item/modular_computer/synth/Destroy()
	physical = null
	owner_brain = null
	return ..()

/*
I give up, this is how borgs have their own menu coded in.
Snowflake codes the interaction check because the default tgui one does not work as I want it.
*/
/mob/living/carbon/human/can_interact_with(atom/A, treat_mob_as_adjacent)
	. = ..()
	if(istype(A, /obj/item/modular_computer/synth))
		var/obj/item/modular_computer/synth/C = A
		if(Adjacent(C.physical))
			. = TRUE
	return

/*
So, I am not snowflaking more code.. except this
Attacking a synth with an id loads it into its slot.. pain and probably shitcode
*/

/obj/item/card/id/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/T = target_mob
	if(!istype(T))
		return ..()
	var/obj/item/organ/internal/brain/synth/B = T.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(B))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "Inserting id...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "Inserted")
				B.internal_computer.InsertID(src, user)
			return
	return ..()

/obj/item/modular_computer/pda/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/T = target_mob
	if(!istype(T))
		return ..()
	var/obj/item/organ/internal/brain/synth/B = T.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(B))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "Interfacing....")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "Connected!")
				B.internal_computer.interact(user)
			return
	return ..()
