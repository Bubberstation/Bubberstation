/datum/surgery/robot/advanced/bioware/vein_threading
	name = "Hydraulics Routing Optimization"
	desc = "A robotic upgrade which severely reduces the amount of hydraulic fluid lost in case of injury."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/thread_veins/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 3
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/advanced/bioware/close_vein_threading

/datum/surgery/robot/advanced/bioware/close_vein_threading
	name = "Close Surgery (Hydraulics Routing Optimization)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery_step/apply_bioware/thread_veins/mechanic
	name = "reroute hydraulics (hand)"

/datum/surgery_step/apply_bioware/thread_veins/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start rerouting [target]'s hydraulic system."),
		span_notice("[user] starts rerouting [target]'s hydraulic system."),
		span_notice("[user] starts manipulating [target]'s hydraulic system."),
	)

/datum/surgery_step/apply_bioware/thread_veins/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(!.)
		return

	display_results(
		user,
		target,
		span_notice("You reroute [target]'s hydraulic system into a resistant mesh!"),
		span_notice("[user] reroutes [target]'s hydraulic system into a resistant mesh!"),
		span_notice("[user] finishes manipulating [target]'s hydraulic system."),
	)

