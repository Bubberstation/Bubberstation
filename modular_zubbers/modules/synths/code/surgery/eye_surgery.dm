/datum/surgery/robot/eye_surgery
	name = "Repair optics"
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
	surgery_flags = SURGERY_SELF_OPERABLE

/datum/surgery/robot/close_eye_surgery
	name = "Close Surgery (Repair optics)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	organ_to_manipulate = ORGAN_SLOT_EYES
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	steps = list(
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	surgery_flags = SURGERY_SELF_OPERABLE

/datum/surgery_step/robot_fix_eyes
	name = "fix eyes (multitool)"
	implements = list(
		TOOL_MULTITOOL = 100,)
	time = 6.4 SECONDS

/datum/surgery/robot/eye_surgery/can_start(mob/user, mob/living/carbon/target)
	..()
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
