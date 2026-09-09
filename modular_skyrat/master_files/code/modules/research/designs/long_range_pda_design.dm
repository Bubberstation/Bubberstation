/datum/design/long_range_pda
	name = "long range PDA"
	id = "long range pda"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/modular_computer/pda/long_range
	category = list(
		RND_CATEGORY_MODULAR_COMPUTERS
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/obj/item/disk/design_disk/long_range_pda
	name = "far range PDA design disk"

/obj/item/disk/design_disk/long_range_pda/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/long_range_pda
