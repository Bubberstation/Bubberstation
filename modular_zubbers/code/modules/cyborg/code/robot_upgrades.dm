// All this has for now is the affection module for regular cyborgs
/obj/item/borg/upgrade/affectionmodule2
	name = "alternative affection module"
	desc = "An alternative module that upgrades the ability of cyborgs to display affection."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/affectionmodule2/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	if(borg.hasAffection)
		to_chat(usr, span_warning("This unit already has a affection module installed!"))
		return FALSE
	if(R_TRAIT_WIDE in borg.model.model_features)
		to_chat(usr, span_warning("This unit's chassis does not support this module. Please use the other module."))
		return FALSE

	var/obj/item/borg_tongue/borg_tongue = new /obj/item/borg_tongue(borg.model)
	borg.model.basic_modules += borg_tongue
	borg.model.add_module(borg_tongue, FALSE, TRUE)
	var/obj/item/borg_nose/borg_nose = new /obj/item/borg_nose(borg.model)
	borg.model.basic_modules += borg_nose
	borg.model.add_module(borg_nose, FALSE, TRUE)
	borg.hasAffection = TRUE

/obj/item/borg/upgrade/affectionmodule2/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		return
	borg.hasAffection = FALSE
	for(var/obj/item/borg_tongue/borg_tongue in borg.model.modules)
		borg.model.remove_module(borg_tongue, TRUE)
	for(var/obj/item/borg_nose/borg_nose in borg.model.modules)
		borg.model.remove_module(borg_nose, TRUE)
