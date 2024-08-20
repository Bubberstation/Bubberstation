/datum/surgery/robot/advanced/pacify
	name = "Aggression Suppression Programming"
	desc = "Malware which permanently inhibits the aggression programming of the patient's neural network, making the patient unwilling to cause direct harm."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/pacify/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/advanced/close_pacify

/datum/surgery/robot/advanced/close_pacify
	name = "Close Surgery (Aggression Suppression Programming)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/advanced/pacify/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	var/obj/item/organ/internal/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE

/datum/surgery_step/pacify/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to pacify [target]..."),
		span_notice("[user] begins to fix [target]'s posibrain."),
		span_notice("[user] begins to perform surgery on [target]'s posibrain."),
	)
	display_pain(target, "Your head pounds with unimaginable pain!")

/datum/surgery_step/pacify/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You succeed in neurologically pacifying [target]."),
		span_notice("[user] successfully fixes [target]'s posibrain!"),
		span_notice("[user] completes the surgery on [target]'s posibrain."),
	)
	target.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_LOBOTOMY)
	return ..()

/datum/surgery_step/pacify/mechanic/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You screw up, rewiring [target]'s brain the wrong way around..."),
		span_warning("[user] screws up, causing posibrain damage!"),
		span_notice("[user] completes the surgery on [target]'s posibrain."),
	)
	target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	return FALSE
