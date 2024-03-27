/datum/surgery/robot/positronic_restoration
	name = "Posibrain Reboot (Revival)"
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/finalize_positronic_restoration,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A surgical procedure that reboots a positronic brain."
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_positronic_restoration

/datum/surgery/robot/close_positronic_restoration
	name = "Close Surgery (Posibrain Reboot (Revival))"
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC

/datum/surgery/robot/chassis_restoration/can_start(mob/user, mob/living/carbon/target)
	if(!..() || target.stat != DEAD ||  !target.get_organ_slot(ORGAN_SLOT_BRAIN))
		return FALSE

	return TRUE
