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
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/healthanalyzer/advanced)
	items_to_remove = list(/obj/item/healthanalyzer)


//Science inducer
/obj/item/borg/upgrade/inducer_sci
	name = "Research integrated power inducer"
	desc = "An integrated inducer that can charge a device's internal cell from power provided by the cyborg."
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/inducer/cyborg/sci)

//Bluespace RPED
/obj/item/borg/upgrade/brped
	name = "Research cyborg Rapid Part Exchange Device Upgrade"
	desc = "An upgrade to the Research model cyborg's standard RPED."
	icon_state = "module_engineer"
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
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING
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


// Mining Borg Vent Pinpointer

/obj/item/borg/upgrade/pinpointer/vent
	name = "Vent Pinpointer"
	desc = "A modularized tracking device. It will locate and point to nearby vents."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/pinpointer/vent)

/// "Good Borg" Obedience Training
/mob/living/silicon/robot
	var/hasToys = FALSE

/obj/item/borg/upgrade/obediencemodule
	name = "Cyborg Obedience Module"
	desc = "A module that greatly upgrades the ability of borgs to display affection."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
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
