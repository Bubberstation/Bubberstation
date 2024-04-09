#define MINDSHIELD_STEP_1 "mindshield_step_1"
#define MINDSHIELD_STEP_2 "mindshield_step_2"
#define MINDSHIELD_STEP_TIME 15 SECONDS
#define CONVERT_STEP_1 "convert_step_1"
#define CONVERT_STEP_2 "convert_step_2"
#define CONVERT_STEP_3 "convert_step_3"
#define CONVERT_STEP_4 "convert_step_4"
#define CONVERT_STEP_TIME 15 SECONDS

/obj/item/head_convert_device
	name = "HCD"
	desc = "There is a note below the device, saying 'This device is be able to bypass Mindshield implant and Loyalty to convert people'."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "autosurgeon_syndicate"
	inhand_icon_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL
	var/mob/living/carbon/human/target
	var/target_name
	var/step

/obj/item/head_convert_device/examine(mob/user)
	. = ..()
	. += span_info("Use the device to clear current target.")
	. += span_notice("Current target is: [target_name ? target_name : "NOT SET"].")

/obj/item/head_convert_device/attack_self(mob/user, modifiers)
	. = ..()
	clear_settings(user)

/obj/item/head_convert_device/proc/clear_settings(mob/user)
	step = null
	target = null
	target_name = null
	user.balloon_alert(user, "target cleared!")

/obj/item/head_convert_device/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	if(. || IS_REVOLUTIONARY(target_mob) || !IS_HEAD_REVOLUTIONARY(user))
		return
	if(HAS_TRAIT(target_mob, TRAIT_MINDSHIELD))
		remove_mindshield(target_mob, user)
		return
	if(!(target_mob.mind.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND))
		say("Device is only compatible with Heads of Staff.")
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
		say("Target is too loyal for this device!")
		return
	if(target != target_mob)
		target = target_mob
		target_name = target.real_name
		step = MINDSHIELD_STEP_1
	playsound(target_mob.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	switch(step)
		if(MINDSHIELD_STEP_1)
			say("Mindshield detected. Locating it...")
		if(MINDSHIELD_STEP_2)
			say("Mindshield located. Removing it...")

	if(!do_after(user, MINDSHIELD_STEP_TIME, target_mob, progress = TRUE))
		user.balloon_alert(user, "interrupted!")
		return

	switch(step)
		if(MINDSHIELD_STEP_1)
			step = MINDSHIELD_STEP_2
			attack(target_mob, user)
		if(MINDSHIELD_STEP_2)
			mindshield.removed(target_mob)
			say("Mindshield successfully removed.")
			clear_settings(user)

/obj/item/head_convert_device/proc/convert_head(mob/living/target_mob, mob/living/user)
	if(!check_valid_target(target_mob, user))
		return
	if(target != target_mob)
		target = target_mob
		target_name = target.real_name
		step = CONVERT_STEP_1
	playsound(target_mob.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	switch(step)
		if(CONVERT_STEP_1)
			say("Extreme Loyalty detected. Locating the source...")
		if(CONVERT_STEP_2)
			say("Source of Loyalty detected. Creating counter-measures...")
		if(CONVERT_STEP_3)
			say("Deploying counter-measures...")
		if(CONVERT_STEP_4)
			say("Finalizing the conversion...")

	if(!do_after(user, CONVERT_STEP_TIME, target_mob, progress = TRUE))
		user.balloon_alert(user, "interrupted!")
		return

	switch(step)
		if(CONVERT_STEP_1)
			step = CONVERT_STEP_2
			attack(target_mob, user)
		if(CONVERT_STEP_2)
			step = CONVERT_STEP_3
			attack(target_mob, user)
		if(CONVERT_STEP_3)
			step = CONVERT_STEP_4
			attack(target_mob, user)
		if(CONVERT_STEP_4)
			var/datum/antagonist/rev/converter = user.mind.has_antag_datum(/datum/antagonist/rev, TRUE)
			target_mob.mind.assigned_role.departments_bitflags &= ~DEPARTMENT_BITFLAG_COMMAND
			clear_settings(user)
			if(converter.add_revolutionary(target_mob.mind))
				say("Target is successfully converted.")
				return
			say("Unexpected error detected. Please, consult Syndicate tech-support.")

#undef MINDSHIELD_STEP_1
#undef MINDSHIELD_STEP_2
#undef MINDSHIELD_STEP_TIME
#undef CONVERT_STEP_1
#undef CONVERT_STEP_2
#undef CONVERT_STEP_3
#undef CONVERT_STEP_4
#undef CONVERT_STEP_TIME
