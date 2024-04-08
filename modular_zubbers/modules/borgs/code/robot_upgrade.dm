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
/obj/item/borg/upgrade/inducer/sci
	name = "Research integrated power inducer"
	desc = "An integrated inducer that can charge a device's internal cell from power provided by the cyborg."
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH

/obj/item/borg/upgrade/inducer/sci/action(mob/living/silicon/robot/silicon_friend, user = usr)
	. = ..()
	if(.)
		var/obj/item/inducer/cyborg/sci/inter_inducer = locate() in silicon_friend
		if(inter_inducer)
			silicon_friend.balloon_alert(user, "already has one!")
			return FALSE

		inter_inducer = new(silicon_friend.model)
		silicon_friend.model.basic_modules += inter_inducer
		silicon_friend.model.add_module(inter_inducer, FALSE, TRUE)

/obj/item/borg/upgrade/inducer/sci/deactivate(mob/living/silicon/robot/silicon_friend, user = usr)
	. = ..()
	if(.)
		var/obj/item/inducer/cyborg/sci/inter_inducer = locate() in silicon_friend.model
		if(inter_inducer)
			silicon_friend.model.remove_module(inter_inducer, TRUE)

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
