/datum/surgery/robot/advanced/bioware/cortex_imprint
	name = "Positronic OS Ver 2.0"
	desc = "A robotic upgrade which updates the patient's operating system to the 'latest version', whatever that means, making the brain able to bypass damage caused by minor brain traumas. \
		Shame about all the adware."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/imprint_cortex,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/advanced/bioware/close_cortex_imprint

/datum/surgery/robot/advanced/bioware/close_cortex_imprint
	name = "Close Surgery (Positronic OS Ver 2.0)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/advanced/bioware/cortex_imprint/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE
	return ..()

/datum/surgery_step/apply_bioware/imprint_cortex/mechanic
	name = "imprint cortex (multitool)"
	accept_hand = FALSE
	implements = list(
		TOOL_MULTITOOL = 95,
		TOOL_HEMOSTAT = 35,
		/obj/item/pen = 15
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'

/datum/surgery_step/apply_bioware/imprint_cortex/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start updating [target]'s operating system to a self-imprinting version."),
		span_notice("[user] starts updating [target]'s operating system to a self-imprinting version."),
		span_notice("[user] begins to perform surgery on [target]'s posibrain."),
	)

/datum/surgery_step/apply_bioware/imprint_cortex/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(!.)
		return

	display_results(
		user,
		target,
		span_notice("You update [target]'s operating system to a self-imprinting version!"),
		span_notice("[user] updates [target]'s operating system to a self-imprinting version!"),
		span_notice("[user] completes the surgery on [target]'s posibrain."),
	)

/datum/surgery_step/apply_bioware/imprint_cortex/mechanic/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_slot(ORGAN_SLOT_BRAIN))
		display_results(
			user,
			target,
			span_warning("You screw up, damaging the posibrain!"),
			span_warning("[user] screws up, damaging the posibrain!"),
			span_notice("[user] completes the surgery on [target]'s posibrain."),
		)
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
		target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	else
		user.visible_message(span_warning("[user] suddenly notices that the posibrain [user.p_they()] [user.p_were()] working on is not there anymore."), span_warning("You suddenly notice that the brain you were working on is not there anymore."))
	return FALSE
