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

/// Quadruped special module
/obj/item/borg/upgrade/squadrupedmodule
	name = "small quadruped borg affection module"
	desc = "A module that upgrades the ability of small quadruped borgs to display affection."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/squadrupedmodule/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	if(borg.hasAffection)
		to_chat(usr, span_warning("This unit already has a affection module installed!"))
		return FALSE
	if(!(TRAIT_R_SQUADRUPED in borg.model.model_features))
		to_chat(usr, span_warning("This unit's chassis does not support this module."))
		return FALSE

	var/obj/item/quadborg_tongue/quadtongue = new /obj/item/quadborg_tongue(borg.model)
	borg.model.basic_modules += quadtongue
	borg.model.add_module(quadtongue, FALSE, TRUE)
	var/obj/item/quadborg_nose/quadnose = new /obj/item/quadborg_nose(borg.model)
	borg.model.basic_modules += quadnose
	borg.model.add_module(quadnose, FALSE, TRUE)
	borg.hasAffection = TRUE

/obj/item/borg/upgrade/squadrupedmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		return
	borg.hasAffection = FALSE
	for(var/obj/item/quadborg_tongue/quadtongue in borg.model.modules)
		borg.model.remove_module(quadtongue, TRUE)
	for(var/obj/item/quadborg_nose/quadnose in borg.model.modules)
		borg.model.remove_module(quadnose, TRUE)
