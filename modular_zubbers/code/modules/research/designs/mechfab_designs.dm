// Empty shell

/datum/design/synthclone
	name = "Blank synthetic shell"
	build_type = MECHFAB
	construction_time = 60 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25
	)
	category = list(RND_CATEGORY_MECHFAB_SYNTH + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS)
	inherit_materials = DESIGN_DONT_INHERIT_MATS

	build_path = /mob/living/carbon/human/species/synth/empty

/datum/design/borg_upgrade_advcutter
	name = "Advanced Plasma Cutter"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advcutter
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

//research cyborg upgrades
/datum/design/borg_upgrade_advancedhealth
	name = "Research Advanced Health Analyzer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/healthanalyzer
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH,
	)

//Blue space Rped upgrade
/datum/design/borg_upgrade_brped
	name = "Bluespace Rapid Part Exchange Device"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/brped
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_upgrade_research_rcd
	name = "Research cyborg synthetic repair tool"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/robotics_rcd
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_upgrade_inducer_sci
	name = "Research Cyborg inducer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer_sci
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_dominatrix
	name = "Cyborg dominatrix module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/dominatrixmodule
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_obedience
	name = "Cyborg Obedience Module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/obediencemodule
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_waddle
	name = "Cyborg Waddle Module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/waddle_module
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

//so we have our own category
/datum/design/borg_upgrade_surgical_processor_sci
	name = "Research Surgical Processor"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/processor
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

//Some new toys
/datum/design/experi_scanner/bluespace_borg
	name = "Cyborg Bluespace Experimental Scanner"
	desc = "A version of the experiment scanner that allows for performing experiment scans from a distance."
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/experi_scanner
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/module/mind_transfer
	name = "Mind Transference Module"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/mod/module/mind_swap
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/rld
	name = "Cyborg Rapid Lighting Device"
	desc = "A device that allows rapid, range deployment of lights and glowsticks."
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

//	JANITOR CYBORG UPGRADES

/datum/design/borg_upgrade_detailer
	name = "Detailing Tools"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/detailer
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*15.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/rld_janitor
	name = "Cyborg Rapid Lighting Device"
	desc = "A device that allows rapid, range deployment of lights and glowsticks."
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/cyborg_cable_coil
	name = "Integrated Cable Coil"
	desc = "Condensed spooling technology allows cabling technology in janitorial modules."
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/cyborg_cable_coil
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/xenoarch/equipment/bag_adv_borg
	name = "Cyborg Advanced Xenoarchaeology Bag"
	desc = "An improved bag to pick up strange rocks for science"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/borg/upgrade/xenoarch/adv
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/pinpointer/vent
	name = "Vent Pinpointer"
	desc = "A modularized tracking device. It will locate and point to nearby vents."
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/pinpointer/vent
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/module/protean/servo
	name = "Protean Servo Module"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/protean_servo

/datum/design/module/hat_stabilizer
	name = "Hat Stabilizer Module"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/mod/module/hat_stabilizer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

//Borg PKAs

/datum/design/kinetic_accelerator/railgun/cyborg
	name = "proto-kinetic railgun"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::desc
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/repeater/cyborg
	name = "proto-kinetic repeater"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::desc
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/shotgun/cyborg
	name = "proto-kinetic shotgun"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::desc
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/glock/cyborg
	name = "proto-kinetic pistol"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::desc
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/shockwave/cyborg
	name = "proto-kinetic shockwave"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::desc
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/m79/cyborg
	name = "proto-kinetic grenade launcher"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::desc
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
