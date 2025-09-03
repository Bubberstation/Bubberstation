/datum/action/cooldown/spell/beast_form
	name = "Toggle Beast Form"
	desc = "Transform between human and lycan form."
	button_icon = 'modular_zubbers/code/modules/customization/species/lycans/lycan_verbs.dmi'
	button_icon_state = "lycan_form"

#ifndef TESTING
	cooldown_time = 3 MINUTES
#else
	cooldown_time = 1 SECONDS // I don't wanna wait
#endif
	antimagic_flags = SPELL_REQUIRES_NO_ANTIMAGIC
	spell_requirements = NONE

/datum/action/cooldown/spell/beast_form/proc/update_button_state(new_state) //This makes it so that the button icon changes dynamically based on ears being up or not.
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/beast_form/cast(atom/target)
	. = ..()
	var/obj/item/organ/brain/lycan/brain = owner?.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain.toggle_beast_form(target)
	if(!HAS_TRAIT(owner, TRAIT_BEAST_FORM))
		update_button_state("lycan_form")
	else
		update_button_state("human_form")
