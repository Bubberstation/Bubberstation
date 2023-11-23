/obj/item/head_convert_device
	name = "HCD"
	desc = "This device is be able to bypass Mindshield implant and Loyalty to convert people to the Revolution."
	icon = 'icons/obj/device.dmi'
	icon_state = "autosurgeon_syndicate"
	inhand_icon_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/head_convert_device/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	if(. || IS_REVOLUTIONARY(target_mob) || !IS_HEAD_REVOLUTIONARY(user))
		return
	if(HAS_TRAIT(target_mob, TRAIT_MINDSHIELD))
		remove_mindshield(target_mob, user)
		return
	if(!(target_mob.mind.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND))
		return
	if(!check_valid_target(target_mob, user))
		return
	convert_head(target_mob, user)

/obj/item/head_convert_device/proc/check_valid_target(mob/living/target_mob, mob/living/user)
	if(target_mob.stat == DEAD)
		return
	if(target_mob.stat != CONSCIOUS)
		to_chat(user, span_warning("[target_mob.p_They()] must be conscious before you can convert [target_mob.p_them()]!!"))
		return
	if(isnull(target_mob.mind) || !GET_CLIENT(target_mob))
		to_chat(user, span_warning("[target_mob]'s mind is so vacant that it is not susceptible to influence!"))
		return
	return TRUE

/obj/item/head_convert_device/proc/remove_mindshield(mob/living/target_mob, mob/living/user)
	var/obj/item/implant/mindshield/mindshield = locate() in target_mob.implants
	if(!istype(mindshield))
		user.balloon_alert(user, "too loyal!")
		return
	user.balloon_alert(user, "removing mindshield!")
	playsound(target_mob.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)
	if(!do_after(user, 5 SECONDS, target_mob, progress = TRUE))
		user.balloon_alert(user, "interrupted!")
		return
	mindshield.removed(mindshield.imp_in)
	user.balloon_alert(user, "mindshield removed!")

/obj/item/head_convert_device/proc/convert_head(mob/living/target_mob, mob/living/user)
	user.balloon_alert(user, "converting!")
	playsound(target_mob.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)
	if(!do_after(user, 5 SECONDS, target_mob, progress = TRUE))
		user.balloon_alert(user, "interrupted!")
		return
	var/datum/antagonist/rev/converter = user.mind.has_antag_datum(/datum/antagonist/rev, TRUE)
	if(!check_valid_target(target_mob, user))
		return
	target_mob.mind.assigned_role.departments_bitflags &= ~DEPARTMENT_BITFLAG_COMMAND
	converter.add_revolutionary(target_mob.mind)
