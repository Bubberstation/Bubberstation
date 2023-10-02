/obj/item/organ/internal/brain/synth
	var/obj/item/modular_computer/synth/internal_computer = new /obj/item/modular_computer/synth

	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

/obj/item/organ/internal/brain/synth/Insert(mob/living/carbon/user, special, drop_if_replaced, no_id_transfer)
	. = ..()
	internal_computer.owner_brain = src
/obj/item/modular_computer/synth
	name = "Synthetic internal computer"

	base_active_power_usage = 0
	base_idle_power_usage = 0

	var/obj/item/organ/internal/brain/synth/owner_brain

/obj/item/modular_computer/synth/get_messenger_ending()
	return " Sent from my internal computer."

/*
I give up, this is how borgs have their own menu coded in.
Snowflake codes the interaction check because the default tgui one does not work as we want it.
*/
/mob/living/carbon/human/can_interact_with(atom/A, treat_mob_as_adjacent)
	. = ..()
	if(istype(A, /obj/item/modular_computer/synth))
		var/obj/item/modular_computer/synth/C = A
		if(Adjacent(C.owner_brain.owner) || Adjacent(C.owner_brain))
			. = TRUE

/datum/action/item_action/synth/open_internal_computer
	name = "Open internal computer"
	desc = "Open the built in ntos computer"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/I = target
	I.internal_computer.physical = owner
	I.internal_computer.interact(owner)
