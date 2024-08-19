/datum/surgery/robot/ear_surgery
	name = "Repair mics"
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
	surgery_flags = SURGERY_SELF_OPERABLE

/datum/surgery/robot/close_ear_surgery
	name = "Close Surgery (Repair mics)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	organ_to_manipulate = ORGAN_SLOT_EARS
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	surgery_flags = SURGERY_SELF_OPERABLE

/datum/surgery_step/robot_fix_ears
	name = "fix ears (multitool)"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 35,
		/obj/item/pen = 15
	)
	time = 6.4 SECONDS
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'

/datum/surgery/robot/ear_surgery/can_start(mob/user, mob/living/carbon/target)
	..()
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
