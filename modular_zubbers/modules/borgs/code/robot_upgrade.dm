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

/obj/item/borg/upgrade/healthanalyzer/action(mob/living/silicon/robot/borg)
	. = ..()
	if(.)
		for(var/obj/item/healthanalyzer/HA in borg.model.modules)
			borg.model.remove_module(HA, TRUE)

		var/obj/item/healthanalyzer/advanced/AHA = new /obj/item/healthanalyzer/advanced(borg.model)
		borg.model.basic_modules += AHA
		borg.model.add_module(AHA, FALSE, TRUE)

/obj/item/borg/upgrade/healthanalyzer/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/healthanalyzer/advanced/AHA in borg.model.modules)
			borg.model.remove_module(AHA, TRUE)

		var/obj/item/healthanalyzer/HA = new (borg.model)
		borg.model.basic_modules += HA
		borg.model.add_module(HA, FALSE, TRUE)


//Science inducer
/obj/item/borg/upgrade/inducer/sci
	name = "Research integrated power inducer"
	desc = "An integrated inducer that can charge a device's internal cell from power provided by the cyborg."
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH

/obj/item/borg/upgrade/inducer/sci/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/inducer/cyborg/sci/AC = locate() in R.model.modules
		if(AC)
			to_chat(user, span_warning("This unit is already equipped with an inducer!"))
			return FALSE
		AC = new(R.model)
		R.model.basic_modules += AC
		R.model.add_module(AC, FALSE, TRUE)

/obj/item/borg/upgrade/inducer/sci/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/inducer/cyborg/sci/AC in R.model.modules)
			R.model.remove_module(AC, TRUE)

//Bluespace RPED

/obj/item/borg/upgrade/brped
	name = "Research cyborg Rapid Part Exchange Device Upgrade"
	desc = "An upgrade to the Research model cyborg's standard RPED."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH

/obj/item/borg/upgrade/brped/action(mob/living/silicon/robot/borg)
	. = ..()
	if(.)
		for(var/obj/item/storage/part_replacer/cyborg/RPED in borg.model.modules)
			borg.model.remove_module(HA, TRUE)

		var/obj/item/storage/part_replacer/bluespace/BRPED = new /obj/item/healthanalyzer/advanced(borg.model)
		borg.model.basic_modules += BRPED
		borg.model.add_module(BRPED, FALSE, TRUE)

/obj/item/borg/upgrade/brped/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/storage/part_replacer/bluespace/BRPED in borg.model.modules)
			borg.model.remove_module(BRPED, TRUE)

		var/obj/item/storage/part_replacer/cyborg/RPED = new (borg.model)
		borg.model.basic_modules += RPED
		borg.model.add_module(RPED, FALSE, TRUE)
