/datum/design/modlink_scryer
	// use the loaded modlink scryer object to have the frequency set to NT upon creation
	build_path = /obj/item/clothing/neck/link_scryer/loaded

/datum/design/module/mod_remote
	name = "MODsuit Remote Module"
	id = "mod_remote_module"
	build_path = /obj/item/mod/module/remote_control
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *3 ,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.5,
	)
	research_icon_state = "module_remote"
