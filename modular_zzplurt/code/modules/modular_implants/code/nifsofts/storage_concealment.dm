/obj/item/disk/nifsoft_uploader/nif_hide_backpack_disk
	name = "storage concealment"
	loaded_nifsoft = /datum/nifsoft/action_granter/free/nif_hide_backpack

/datum/nifsoft/action_granter/free/nif_hide_backpack
	name = "Chameleon Storage Concealment"
	program_desc = "Emits a weak psychic signal that conceals the presence of back-equipped gear items."
	buying_category = NIFSOFT_CATEGORY_COSMETIC
	ui_icon = "paintbrush"
	action_to_grant = /datum/action/item_action/hide_backpack/nifsoft

// Variant to change icons
// Otherwise identical to old implant method
/datum/action/item_action/hide_backpack/nifsoft
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
