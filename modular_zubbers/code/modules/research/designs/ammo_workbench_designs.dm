/datum/design/disk/ammo_workbench_lethal
	name = "Ammo Workbench Advanced Munitions Datadisk"
	id = "ammoworkbench_disk_lethal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT
	)
	build_path = /obj/item/disk/ammo_workbench/advanced
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
