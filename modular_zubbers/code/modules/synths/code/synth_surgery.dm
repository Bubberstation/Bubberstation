/datum/surgery/robot
	var/num_opening_steps
	var/num_steps_until_closing
	var/close_surgery
	var/is_closer = FALSE

/datum/surgery/robot/amputation
	name = "Amputation (Synthetic)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY
	target_mobtypes = list(/mob/living/carbon/human/species/synth)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/robot_sever_limb,
	)
	removes_target_bodypart = TRUE // SKYRAT EDIT ADDITION - Surgically unremovable limbs
	close_surgery = /datum/surgery/robot/close_amputation
	num_opening_steps = 3
	num_steps_until_closing = 6 // last step automatically closes

/datum/surgery/robot/close_amputation
	name = "Close Surgery (Amputation (Synthetic))"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/amputation/can_start(mob/user, mob/living/patient)
	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		return FALSE
	return ..()

/datum/surgery_step/robot_sever_limb
	name = "disconnect limb (wirecutters)"
	implements = list(
		/obj/item/shears = 300,
		TOOL_WIRECUTTER = 100,)
	time = 64
	//preop_sound = 'sound/surgery/scalpel1.ogg'
	//success_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/robot_sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to disconnect [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] begins to disconnect [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] begins to disconnect [target]'s [parse_zone(target_zone)]!"),
	)
	//display_pain(target, "You feel a gruesome pain in your [parse_zone(target_zone)]'s joint!")

/datum/surgery_step/robot_sever_limb/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You sever [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] severs [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] severs [target]'s [parse_zone(target_zone)]!"),
	)
	display_pain(target, "You can no longer feel your severed [parse_zone(target_zone)]!")

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID) && ishuman(user))
		var/mob/living/carbon/human/morbid_weirdo = user
		morbid_weirdo.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
	return ..()

//reattach plating
/datum/surgery_step/reattach_plating
	name = "reattach plating"
	implements = list(
		TOOL_CROWBAR = 100,
		TOOL_HEMOSTAT = 10,
	)
	time = 2.4 SECONDS

/datum/surgery_step/reattach_plating/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to reattach [target]'s [parse_zone(target_zone)] plating..."),
		"[user] begins to reattach [target]'s [parse_zone(target_zone)] plating.",
		"[user] begins to reattach [target]'s [parse_zone(target_zone)] plating.",
	)

/datum/surgery/robot/eye_surgery
	name = "Eye surgery"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	organ_to_manipulate = ORGAN_SLOT_EYES
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/robot_fix_eyes,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 1
	num_steps_until_closing = 3
	close_surgery = /datum/surgery/robot/close_eye_surgery

/datum/surgery/robot/close_eye_surgery
	name = "Close Surgery (Eye surgery)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	organ_to_manipulate = ORGAN_SLOT_EYES
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	steps = list(
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery_step/robot_fix_eyes
	name = "fix eyes (multitool)"
	implements = list(
		TOOL_MULTITOOL = 100,)
	time = 64

/datum/surgery/robot/eye_surgery/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/eyes/target_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	return !isnull(target_eyes)

/datum/surgery_step/robot_fix_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to fix [target]'s eyes..."),
		span_notice("[user] begins to fix [target]'s eyes."),
		span_notice("[user] begins to perform surgery on [target]'s eyes."),
	)
	//display_pain(target, "You feel a stabbing pain in your eyes!")

/datum/surgery_step/robot_fix_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/organ/internal/eyes/target_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	user.visible_message(span_notice("[user] successfully fixes [target]'s eyes!"), span_notice("You succeed in fixing [target]'s eyes."))
	display_results(
		user,
		target,
		span_notice("You succeed in fixing [target]'s eyes."),
		span_notice("[user] successfully fixes [target]'s eyes!"),
		span_notice("[user] completes the surgery on [target]'s eyes."),
	)
	display_pain(target, "Your vision blurs, but it seems like you can see a little better now!")
	target.remove_status_effect(/datum/status_effect/temporary_blindness)
	target.set_eye_blur_if_lower(70 SECONDS) //this will fix itself slowly.
	target_eyes.set_organ_damage(0) // heals nearsightedness and blindness from eye damage
	return ..()

/datum/surgery_step/robot_fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_by_type(/obj/item/organ/internal/brain))
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head, into your brain!")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
	else
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head!") // dunno who can feel pain w/o a brain but may as well be consistent.
	return FALSE

/datum/surgery/robot/ear_surgery
	name = "Ear surgery"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	organ_to_manipulate = ORGAN_SLOT_EARS
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/robot_fix_ears,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 5
	close_surgery = /datum/surgery/robot/close_ear_surgery

/datum/surgery/robot/close_ear_surgery
	name = "Close Surgery (Ear surgery)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	organ_to_manipulate = ORGAN_SLOT_EARS
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery_step/robot_fix_ears
	name = "fix ears (multitool)"
	implements = list(
		TOOL_MULTITOOL = 100)
	time = 64

/datum/surgery/robot/ear_surgery/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/ears/target_ears = target.get_organ_slot(ORGAN_SLOT_EARS)
	if(!target_ears)
		return FALSE
	return TRUE

/datum/surgery_step/robot_fix_ears/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to fix [target]'s ears..."),
		span_notice("[user] begins to fix [target]'s ears."),
		span_notice("[user] begins to perform surgery on [target]'s ears."),
	)
	//display_pain(target, "You feel a dizzying pain in your head!")

/datum/surgery_step/robot_fix_ears/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/organ/internal/ears/target_ears = target.get_organ_slot(ORGAN_SLOT_EARS)
	display_results(
		user,
		target,
		span_notice("You succeed in fixing [target]'s ears."),
		span_notice("[user] successfully fixes [target]'s ears!"),
		span_notice("[user] completes the surgery on [target]'s ears."),
	)
	display_pain(target, "Your head swims, but it seems like you can feel your hearing coming back!")
	target_ears.deaf = (20) //deafness works off ticks, so this should work out to about 30-40s
	target_ears.set_organ_damage(0)
	return ..()

/datum/surgery_step/robot_fix_ears/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_by_type(/obj/item/organ/internal/brain))
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head, into your brain!")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
	else
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head!") // dunno who can feel pain w/o a brain but may as well be consistent.
	return FALSE

/datum/surgery/robot/brain_surgery
	name = "Reset Posibrain Logic (Brain Surgery)"
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_robot_brain,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_brain_surgery
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST) // The brains are in the chest
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A surgical procedure that restores the default behavior logic and personality matrix of an IPC posibrain."

/datum/surgery/robot/close_brain_surgery
	name = "Close Surgery (Reset Posibrain Logic (Brain Surgery))"
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST) // The brains are in the chest
	requires_bodypart_type = BODYTYPE_ROBOTIC

/datum/surgery/robot/brain_surgery/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	var/obj/item/organ/internal/brain/synth/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain) && !issynthetic(target))
		return FALSE
	else
		return TRUE

/datum/surgery/robot/positronic_restoration
	name = "Posibrain Reboot (Revival)"
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/finalize_positronic_restoration,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A surgical procedure that reboots a positronic brain."
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_positronic_restoration

/datum/surgery/robot/close_positronic_restoration
	name = "Close Surgery (Posibrain Reboot (Revival))"
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC

/datum/surgery/robot/chassis_restoration/can_start(mob/user, mob/living/carbon/target)
	if(!..() || target.stat != DEAD ||  !target.get_organ_slot(ORGAN_SLOT_BRAIN))
		return FALSE

	return TRUE

/datum/surgery_step/extract_implant/robot
	name = "extract implant (crowbar)"
	implements = list(
		TOOL_CROWBAR = 100,
		TOOL_HEMOSTAT = 65,
		/obj/item/kitchen/fork = 35)

/datum/surgery/robot/implant_removal
	name = "Implant Removal"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	target_mobtypes = list(/mob/living/carbon/human) // Simpler mobs don't have bodypart types
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/extract_implant/robot,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,)
	num_opening_steps = 2
	num_steps_until_closing = 5
	close_surgery = /datum/surgery/robot/close_implant_removal

/datum/surgery/robot/close_implant_removal
	name = "Close Surgery (Implant Removal)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	target_mobtypes = list(/mob/living/carbon/human) // Simpler mobs don't have bodypart types
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,)
	is_closer = TRUE

/datum/surgery/robot/prosthetic_replacement
	name = "Synthetic limb replacement"
	surgery_flags = NONE
	requires_bodypart_type = BODYTYPE_ROBOTIC
	target_mobtypes = list(/mob/living/carbon/human/species/synth)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/add_prosthetic,
	)
	num_opening_steps = 2
	num_steps_until_closing = 4
	close_surgery = /datum/surgery/robot/close_prosthetic_replacement

/datum/surgery/robot/close_prosthetic_replacement
	name = "Close Surgery (Synthetic limb replacement)"
	surgery_flags = NONE
	requires_bodypart_type = BODYTYPE_ROBOTIC
	target_mobtypes = list(/mob/living/carbon/human/species/synth)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/prosthetic_replacement/can_start(mob/user, mob/living/carbon/target)
	if(!iscarbon(target))
		return FALSE
	var/mob/living/carbon/carbon_target = target
	if(!carbon_target.get_bodypart(user.zone_selected)) //can only start if limb is missing
		return TRUE
	return FALSE

/datum/surgery/robot/organ_manipulation
	name = "Prosthesis organ manipulation"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_SELF_OPERABLE | SURGERY_REQUIRE_LIMB
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs/internal/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 5
	close_surgery = /datum/surgery/robot/close_organ_manipulation

/datum/surgery/robot/close_organ_manipulation/
	name = "Close Surgery (Prosthesis organ manipulation)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_SELF_OPERABLE | SURGERY_REQUIRE_LIMB
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/next_step(mob/living/user, modifiers)
	if(location != user.zone_selected)
		return FALSE
	if(user.combat_mode)
		return FALSE
	if(step_in_progress)
		return TRUE

	var/try_to_fail = FALSE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		try_to_fail = TRUE

	var/datum/surgery_step/step = get_surgery_step()
	if(isnull(step))
		return FALSE
	var/obj/item/tool = user.get_active_held_item()
	if(step.try_op(user, target, user.zone_selected, tool, src, try_to_fail))
		return TRUE
	if(tool && tool.tool_behaviour) //Mechanic surgery isn't done with just surgery tools
		to_chat(user, span_warning("This step requires a different tool!"))
		return TRUE

	return FALSE

/datum/surgery/robot/organ_manipulation/soft
	possible_locs = list(
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_PRECISE_EYES,
		BODY_ZONE_PRECISE_MOUTH,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs/internal/mechanic,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 2
	num_steps_until_closing = 4
	close_surgery = /datum/surgery/robot/organ_manipulation/soft/close

/datum/surgery/robot/organ_manipulation/soft/close
	name = "Close Surgery (Prosthesis organ manipulation)"
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/organ_manipulation/external
	name = "Prosthetic feature manipulation"
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/manipulate_organs/external/mechanic,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 2
	num_steps_until_closing = 3
	close_surgery = /datum/surgery/robot/organ_manipulation/external/close

/datum/surgery/robot/organ_manipulation/external/close
	name = "Close Surgery (Prosthetic feature manipulation)"
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
