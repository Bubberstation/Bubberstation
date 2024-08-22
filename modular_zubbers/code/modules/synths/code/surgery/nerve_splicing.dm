/datum/surgery/robot/advanced/bioware/nerve_splicing
	name = "System Automatic Reset Subroutine"
	desc = "A robotic upgrade which upgrades a patient's automatic systems, making them more resistant to stuns."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/apply_bioware/splice_nerves/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

/datum/surgery/robot/advanced/bioware/close_nerve_splicing
	name = "Close Surgery (System Automatic Reset Subroutine)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

/datum/surgery_step/apply_bioware/splice_nerves/mechanic
	name = "splice electricals (hand)"

/datum/surgery_step/apply_bioware/splice_nerves/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start splicing together [target]'s electricals."),
		span_notice("[user] starts splicing together [target]'s electricals."),
		span_notice("[user] starts manipulating [target]'s electrical system."),
	)

/datum/surgery_step/apply_bioware/splice_nerves/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(!.)
		return

	display_results(
		user,
		target,
		span_notice("You successfully splice [target]'s electrical system!"),
		span_notice("[user] successfully splices [target]'s electrical system!"),
		span_notice("[user] finishes manipulating [target]'s electrical system."),
	)
