/datum/surgery/robot/advanced/bioware/cortex_folding
	name = "Posibrain Labyrinthian Programming"
	desc = "A robotic upgrade which reprograms the patient's neural network in a downright eldritch programming language, giving space to non-standard neural patterns."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/fold_cortex/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/advanced/bioware/close_cortex_folding

/datum/surgery/robot/advanced/bioware/close_cortex_folding
	name = "Close Surgery (Posibrain Labyrinthian Programming)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/advanced/bioware/cortex_folding/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE
	return ..()

/datum/surgery_step/apply_bioware/fold_cortex/mechanic
	name = "reprogram cortex (multitool)"
	accept_hand = FALSE
	implements = list(
		TOOL_MULTITOOL = 95,
		TOOL_HEMOSTAT = 35,
		/obj/item/pen = 15
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'

/datum/surgery_step/apply_bioware/fold_cortex/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start reprogramming [target]'s neural network into a fractal pattern."),
		span_notice("[user] starts reprogramming [target]'s neural network into a fractal pattern."),
		span_notice("[user] begins to perform surgery on [target]'s posibrain."),
	)

/datum/surgery_step/apply_bioware/fold_cortex/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(!.)
		return

	display_results(
		user,
		target,
		span_notice("You reprogram [target]'s neural network into a fractal pattern!"),
		span_notice("[user] reprograms [target]'s neural network into a fractal pattern!"),
		span_notice("[user] completes the surgery on [target]'s posibrain."),
	)

/datum/surgery_step/apply_bioware/fold_cortex/mechanic/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
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
		user.visible_message(span_warning("[user] suddenly notices that the posibrain [user.p_they()] [user.p_were()] working on is not there anymore."), span_warning("You suddenly notice that the posibrain you were working on is not there anymore."))
	return FALSE
