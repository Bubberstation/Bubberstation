/datum/surgery/robot/advanced/bioware/nerve_grounding
	name = "System Shock Dampening"
	desc = "A robotic upgrade which reroutes and grounds the patient's electricals, protecting them from electrical shocks."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/ground_nerves/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/advanced/bioware/close_nerve_grounding

	status_effect_gained = /datum/status_effect/bioware/nerves/grounded

/datum/surgery/robot/advanced/bioware/close_nerve_grounding
	name = "Close Surgery (System Shock Dampening)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery_step/apply_bioware/ground_nerves/mechanic
	name = "ground electricals (hand)"

/datum/surgery_step/apply_bioware/ground_nerves/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start rerouting [target]'s electricals."),
		span_notice("[user] starts rerouting [target]'s electricals."),
		span_notice("[user] starts manipulating [target]'s electrical system."),
	)

/datum/surgery_step/apply_bioware/ground_nerves/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You successfully reroute [target]'s electrical system!"),
		span_notice("[user] successfully reroutes [target]'s electrical system!"),
		span_notice("[user] finishes manipulating [target]'s electrical system."),
	)
	return ..()
