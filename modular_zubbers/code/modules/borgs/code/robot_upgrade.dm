/obj/item/borg/upgrade/transform/ntjack
	name = "borg module picker (Centcom)"
	desc = "Allows you to to turn a cyborg into a experimental nanotrasen cyborg."
	icon_state = "cyborg_upgrade3"
	new_model = /obj/item/robot_model/centcom

/obj/item/borg/upgrade/transform/ntjack/action(mob/living/silicon/robot/cyborg, user = usr)
	return ..()

/obj/item/borg/upgrade/transform/security
	name = "borg model picker (Security)"
	desc = "Allows you to to turn a cyborg into a Security model, shitsec abound."
	icon_state = "cyborg_upgrade3"
	new_model = /obj/item/robot_model/security

//Research borg upgrades

//ADVANCED ROBOTICS REPAIR
/obj/item/borg/upgrade/healthanalyzer
	name = "Research cyborg advanced Health Analyzer"
	desc = "An upgrade to the Research model cyborg's standard health analyzer."
	icon_state = "cyborg_upgrade3"
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
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_remove = list(/obj/item/storage/part_replacer)

// Drapes upgrades
/obj/item/borg/upgrade/processor/Initialize()
	. = ..()
	model_type += /obj/item/robot_model/sci
	model_flags += BORG_MODEL_RESEARCH
	items_to_remove = list(/obj/item/surgical_drapes)

// Engineering BRPED
/obj/item/borg/upgrade/rped/Initialize()
	. = ..()
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_add -= list(/obj/item/storage/part_replacer)

