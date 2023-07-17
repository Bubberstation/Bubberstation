// All this has for now is the affection module for regular cyborgs

/obj/item/borg_tongue
	name = "synthetic tongue"
	desc = "Useful for licking people's faces and whatnot."
	icon = 'modular_skyrat/modules/altborgs/icons/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/borg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(check_zone(borg.zone_selected) == "head")
		borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]'s face!"), span_notice("You affectionally lick \the [mob]'s face!"))
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
	else
		borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]!"), span_notice("You affectionally lick \the [mob]!"))
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)

/obj/item/borg_nose
	name = "nuzzle module"
	desc = "The NUZZLE module"
	icon = 'modular_skyrat/modules/altborgs/icons/robot_items.dmi'
	icon_state = "nose"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	force = 0

/obj/item/borg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_attack_animation(target, null, src)
	user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))

