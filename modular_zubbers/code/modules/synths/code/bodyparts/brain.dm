/obj/item/organ/internal/brain/synth
	var/obj/item/modular_computer/synth/internal_computer = new /obj/item/modular_computer/synth
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

/obj/item/modular_computer/synth
	name = "Synthetic internal computer"

	base_active_power_usage = 0
	base_idle_power_usage = 0

	var/obj/item/organ/internal/brain/synth/brain_link

/obj/item/modular_computer/synth/get_messenger_ending()
	return " Sent from my internal computer."

/datum/action/item_action/synth/open_internal_computer
	name = "Open internal computer"
	desc = "Open the built in ntos computer"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/I = target
	I.internal_computer.physical = owner
	I.internal_computer.interact(owner)
