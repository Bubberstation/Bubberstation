/datum/surgery/robot/advanced/brainwashing_sleeper
	name = "Sleeper Agent Reprogramming"
	desc = "Malware which directly implants the sleeper protocol directive into the robotic patient's operating system, making it their absolute priority. It can be cleared using a mindshield implant."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/brainwash/sleeper_agent/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/advanced/close_brainwashing_sleeper

/datum/surgery/robot/advanced/close_brainwashing_sleeper
	name = "Close Surgery (Sleeper Agent Reprogramming)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/advanced/brainwashing_sleeper/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return FALSE
	var/obj/item/organ/internal/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE
	return TRUE

/datum/surgery_step/brainwash/sleeper_agent/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	objective = pick(possible_objectives)
	display_results(
		user,
		target,
		span_notice("You begin to reprogram [target]..."),
		"[user] begins to fix [target]'s posibrain.",
		"[user] begins to perform surgery on [target]'s posibrain.",
	)
