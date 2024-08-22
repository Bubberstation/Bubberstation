/datum/surgery/robot/advanced/bioware/muscled_veins
	name = "Hydraulics Redundancy Subroutine"
	desc = "A robotic upgrade which adds sophisticated hydraulics redundancies, allowing a patient to pump hydraulic fluid without a dedicated pump."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/muscled_veins/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/advanced/bioware/close_muscled_veins

	status_effect_gained = /datum/status_effect/bioware/heart/muscled_veins

/datum/surgery/robot/advanced/bioware/close_muscled_veins
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery_step/apply_bioware/muscled_veins/mechanic
	name = "optimize hydraulics (hand)"

/datum/surgery_step/apply_bioware/muscled_veins/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start attaching synth-muscles to [target]'s hydraulic system."),
		span_notice("[user] starts attaching synth-muscles to [target]'s hydraulic system."),
		span_notice("[user] starts manipulating [target]'s hydraulic system."),
	)

/datum/surgery_step/apply_bioware/muscled_veins/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(!.)
		return

	display_results(
		user,
		target,
		span_notice("You reshape [target]'s hydraulic system, adding makeshift redundant pumps!"),
		span_notice("[user] reshapes [target]'s hydraulic system, adding makeshift redundant pumps!"),
		span_notice("[user] finishes manipulating [target]'s hydraulic system."),
	)
