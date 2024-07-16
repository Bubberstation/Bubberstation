/datum/design/borg_upgrade_advcutter
	name = "Advanced Plasma Cutter"
	id = "borg_upgrade_advcutter"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advcutter
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
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
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
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
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
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

//so we have our own category
/datum/design/borg_upgrade_surgical_processor_sci
	name = "Research Surgical Processor"
	id = "borg_upgrade_surgicalprocessor_sci"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/processor
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

//Some new toys
/datum/design/experi_scanner/bluespace
	name = "Cyborg Bluespace Experimental Scanner"
	desc = "A version of the experiment scanner that allows for performing experiment scans from a distance."
	id = "bs_experi_scanner_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/borg/upgrade/experi_scanner
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)
