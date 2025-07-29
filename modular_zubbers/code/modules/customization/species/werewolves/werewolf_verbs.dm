/datum/action/item_action/organ_action/beast_form
	name = "Werewolf Form"
	button_icon = 'modular_zubbers/code/modules/customization/species/werewolves/werewolf_verbs.dmi'
	button_icon_state = "werewolf_form"

/datum/action/item_action/organ_action/beast_form/New(Target)
	..()
	var/obj/item/organ/brain/werewolf/werewolf_brain = target
	if(!HAS_TRAIT(werewolf_brain, TRAIT_BEAST_FORM))
		name = "Werewolf Form"
	else
		name = "Human Form"

/datum/action/item_action/organ_action/beast_form/do_effect(trigger_flags)
	var/obj/item/organ/brain/werewolf/werewolf_brain = target
	werewolf_brain.toggle_beast_form(owner)
	if(!HAS_TRAIT(werewolf_brain, TRAIT_BEAST_FORM))
		background_icon_state = "bg_default"
		button_icon_state = "werewolf_form"
	else
		background_icon_state = "bg_default"
		button_icon_state = "human_form"
	build_all_button_icons()
	return TRUE
