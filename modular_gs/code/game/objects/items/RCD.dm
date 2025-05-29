/datum/design/arcd
	name = "Advanced Rapid Construction Device (ARCD)"
	desc = "A tool that can construct and deconstruct walls, airlocks and floors on the fly. This model works at a distance."
	id = "arcd_design"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT, /datum/material/glass = MINERAL_MATERIAL_AMOUNT, /datum/material/diamond = 500, /datum/material/bluespace = 500)  // costs more than what it did in the autolathe, this one comes loaded.
	build_path = /obj/item/construction/rcd/arcd
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/techweb_node/blue_construct
	id = "blue_construct"
	display_name = "Bluespace Construction"
	description = "Augument rapid construction designs using bluespace tech for ranged operations"
	prereq_ids = list("adv_engi", "adv_bluespace")
	design_ids = list("arcd_design")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7000)

/obj/item/borg/upgrade/arcd
	name = "cyborg ARCD"
	desc = "A cybord RCG upgrade module to an ARCD model."
	icon_state = "cyborg_upgrade3"
	require_module = 1
	module_type = /obj/item/robot_module/engineering

/obj/item/borg/upgrade/arcd/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/construction/rcd/arcd/S = new(R.module)
		R.module.basic_modules += S
		R.module.add_module(S, FALSE, TRUE)

/obj/item/borg/upgrade/arcd/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		var/obj/item/construction/rcd/arcd/S = locate() in R.module
		R.module.remove_module(S, TRUE)

/datum/design/borg_arcd
	name = "Cyborg ARCD"
	id = "borg_arcd"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/arcd
	materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT, /datum/material/glass = MINERAL_MATERIAL_AMOUNT, /datum/material/diamond = 500, /datum/material/bluespace = 500)
	construction_time = 100
	category = list("Cyborg Upgrade Modules")
