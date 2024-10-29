/obj/item/disk/nifsoft_uploader/dorms/nif_gfluid_disk
	name = "genital fluid"
	loaded_nifsoft = /datum/nifsoft/action_granter/nif_disrobe

// Currently doesn't work because fluids aren't implemented
/datum/nifsoft/action_granter/nif_gfluid
	name = "Genital Fluid Inducer"
	program_desc = "Allows the user to induce their genitals into producing a specific reagent. Will prevent harmful liquids from being accepted as a genital fluid replacement."
	buying_category = NIFSOFT_CATEGORY_FUN
	lewd_nifsoft = TRUE
	purchase_price = 150
	able_to_keep = TRUE
	active_cost = 0
	ui_icon = "eye"
	//action_to_grant = /datum/action/item_action/genital_fluid_infuse // Not implemented yet
