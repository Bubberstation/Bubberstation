// Empty shell

/datum/design/synthclone
	name = "Blank synthetic shell"
	id = "blanksynth"
	build_type = MECHFAB
	construction_time = 60 SECONDS
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,
					/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
					/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5,
					/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25)
	category = list(RND_CATEGORY_MECHFAB_SYNTH + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS)

	build_path = /mob/living/carbon/human/species/synth/empty

/datum/design/borg_upgrade_advcutter
	name = "Advanced Plasma Cutter"
	id = "borg_upgrade_advcutter"
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
	id = "borg_upgrade_advancedanalyzer"
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
	id = "borg_upgrade_brped"
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

/datum/design/borg_upgrade_inducer_sci
	name = "Research Cyborg inducer"
	id = "borg_upgrade_inducer_sci"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer_sci
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_dominatrix
	name = "Cyborg dominatrix module"
	id = "dominatrixmodule"
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

//so we have our own category
/datum/design/borg_upgrade_surgical_processor_sci
	name = "Research Surgical Processor"
	id = "borg_upgrade_surgicalprocessor_sci"
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
	id = "bs_experi_scanner_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/experi_scanner
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/module/mind_transfer
	name = "Mind Transference Module"
	id = "mod_mind_transfer"
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
	id = "rld_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/datum/design/xenoarch/equipment/bag_adv_borg
	name = "Cyborg Advanced Xenoarchaeology Bag"
	desc = "An improved bag to pick up strange rocks for science"
	id = "adv_xenoarchbag_cyborg"
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
	id = "pinpointer_vent_cyborg"
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
