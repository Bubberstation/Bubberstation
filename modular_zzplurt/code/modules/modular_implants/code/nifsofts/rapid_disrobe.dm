/obj/item/disk/nifsoft_uploader/dorms/nif_disrobe_disk
	name = "rapid disrobe"
	loaded_nifsoft = /datum/nifsoft/action_granter/free/nif_disrobe

/datum/nifsoft/action_granter/free/nif_disrobe
	name = "Emergency Clothing Disruption Field"
	program_desc = "Generates a lining of nanites along the epidermis with high power static charge emitters, allowing for the rapid removal of clothing. Precision not guaranteed."
	buying_category = NIFSOFT_CATEGORY_FUN
	lewd_nifsoft = TRUE
	ui_icon = "eye"
	action_to_grant = /datum/action/innate/nif_disrobe_action

/datum/action/innate/nif_disrobe_action
	name = "Rapid Disrobe"
	desc = "Instantly eject all covering clothing from your body."
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	// PLACEHOLDER ICON - PLEASE REPLACE
	button_icon = 'modular_zzplurt/icons/mob/actions/misc_actions.dmi'
	button_icon_state = "no_uniform"

// Runs on toggling the implant
/datum/action/innate/nif_disrobe_action/Activate()
	// Define target
	var/mob/living/carbon/target_user = owner

	// Check if target exists
	if(!istype(target_user))
		return FALSE

	// Perform LPD effect
	target_user.clothing_burst(TRUE)
