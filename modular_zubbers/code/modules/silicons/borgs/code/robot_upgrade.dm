/obj/item/borg/upgrade/transform/ntjack
	name = "borg module picker (Centcom)"
	desc = "Allows you to to turn a cyborg into a experimental nanotrasen cyborg."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/centcom

/obj/item/borg/upgrade/transform/ntjack/action(mob/living/silicon/robot/cyborg, user = usr)
	return ..()

/obj/item/borg/upgrade/transform/security
	name = "borg model picker (Security)"
	desc = "Allows you to to turn a cyborg into a Security model, shitsec abound."
	icon_state = "module_security"
	new_model = /obj/item/robot_model/security

//Research borg upgrades

//ADVANCED ROBOTICS REPAIR
/obj/item/borg/upgrade/healthanalyzer
	name = "Research cyborg advanced Health Analyzer"
	desc = "An upgrade to the Research model cyborg's standard health analyzer."
	icon_state = "module_medical"
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/healthanalyzer/advanced)
	items_to_remove = list(/obj/item/healthanalyzer)


//Science inducer
/obj/item/borg/upgrade/inducer_sci
	name = "Research integrated power inducer"
	desc = "An integrated inducer that can charge a device's internal cell from power provided by the cyborg."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/inducer/cyborg/sci)

//Bluespace RPED
/obj/item/borg/upgrade/brped
	name = "Research cyborg Rapid Part Exchange Device Upgrade"
	desc = "An upgrade to the Research model cyborg's standard RPED."
	icon_state = "module_engineer"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_remove = list(/obj/item/storage/part_replacer)

// Drapes upgrades
/obj/item/borg/upgrade/processor/Initialize(mapload)
	. = ..()
	model_type += /obj/item/robot_model/sci
	model_flags += BORG_MODEL_RESEARCH

// Engineering BRPED
/obj/item/borg/upgrade/rped/Initialize(mapload)
	. = ..()
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_add -= list(/obj/item/storage/part_replacer)

//Upgrade for the experi scanner
/obj/item/borg/upgrade/experi_scanner
	name = "Research cyborg BlueSpace Experi-Scanner"
	desc = "An upgrade to the Research model cyborg's standard health analyzer."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/experi_scanner/bluespace)
	items_to_remove = list(/obj/item/experi_scanner)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)


// Borg Dom Aura :)
/obj/item/borg/upgrade/dominatrixmodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("This unit already has a 'recreational' module installed!"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/dominant_aura)

/obj/item/borg/upgrade/dominatrixmodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE
		borg.remove_quirk(/datum/quirk/dominant_aura)

// Engineering RLD
/obj/item/borg/upgrade/rld
	name = "Engineering Cyborg Rapid Lighting Device Upgrade"
	desc = "An upgrade to allow a cyborg to use a Rapid Lighting Device."
	icon_state = "module_engineer"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/janitor)
	model_flags = list(BORG_MODEL_ENGINEERING, BORG_MODEL_JANITOR)
	items_to_add = list(/obj/item/construction/rld/cyborg)

// Borg Advanced Xenoarchaeology Bag

/obj/item/borg/upgrade/xenoarch/adv
	name = "Cyborg Advanced Xenoarchaeology Bag"
	desc = "An improved bag to pick up strange rocks for science"
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner, /obj/item/robot_model/sci)
	model_flags = list(BORG_MODEL_MINER, BORG_MODEL_RESEARCH)
	items_to_add = list(/obj/item/storage/bag/xenoarch/adv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2.5)

// Mining Borg Vent Pinpointer

/obj/item/borg/upgrade/pinpointer/vent
	name = "Vent Pinpointer"
	desc = "A modularized tracking device. It will locate and point to nearby vents."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/pinpointer/vent)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

//Borg Proto-Kinetic Accelerators

/obj/item/borg/upgrade/modkit/action(mob/living/silicon/robot/mining_mods)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/recharge/kinetic_accelerator/pkamods in mining_mods.model.modules)
			return install(pkamods, usr, FALSE)

/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg
	desc = "Portable particle accelerator. Only Usable on lavaland"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg
	desc = "A PKA with a three shot magazine"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg
	desc = "A PKA that fires three shots with a longer cooldown."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg
	desc = "A Snub Nosed PKA with more mode capacity but less damage and range."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg
	desc = "Creates a shockwave around the user, with the same power as the base PKA."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg
	desc = "Fires the same bombs used by the mining modsuit. Only usable on lavaland"
	holds_charge = TRUE
	unique_frequency = TRUE

// Mining Borg PKA Upgrades

/obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)

/// "Good Borg" Obedience Training
/mob/living/silicon/robot
	var/hasToys = FALSE

/obj/item/borg/upgrade/obediencemodule
	name = "Cyborg Obedience Module"
	desc = "A module that greatly upgrades the ability of borgs to display affection."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	custom_price = 0

	items_to_add = list(/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/spanking_pad,
						/obj/item/tickle_feather,
						/obj/item/clothing/erp_leash,
						)

// WellTrained Obedience Behaviour
/obj/item/borg/upgrade/obediencemodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("This unit already has a 'recreational' module installed!"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/obediencemodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE

		borg.remove_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/detailer
	name = "janitor detailing toolset"
	desc = "Upgrades a janitor cyborgs tiling capabilities while adding the ability to modify floor decals."
	icon_state = "module_janitor"
	custom_materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*15.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

	items_to_add = list(/obj/item/construction/rtd/borg,
						/obj/item/airlock_painter/decal/cyborg,
						)

/obj/item/borg/upgrade/cyborg_cable_coil
	name = "integrated cable coil"
	desc = "Condensed spooling technology allows cabling technology in janitorial modules."
	icon_state = "module_janitor"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

	items_to_add = list (/obj/item/stack/cable_coil)

//Research cyborg RCD

/obj/item/borg/upgrade/robotics_rcd
	name = "Research cyborg synthetic repair tool"
	desc = "A cut down RCD designed to assist in synthetic repairs."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/construction/rcd/borg/robotics_rcd)

/obj/item/borg/upgrade/hypospray
	model_type = list(/obj/item/robot_model/medical, /obj/item/robot_model/tarkon)
	model_flags = list(BORG_MODEL_MEDICAL, BORG_MODEL_TARKON)
