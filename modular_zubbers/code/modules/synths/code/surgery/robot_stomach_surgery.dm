/// Bioreactor Maintenance
/datum/surgery/robot/bioreactor
	name = "Bioreactor Maintenance"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB | SURGERY_SELF_OPERABLE
	organ_to_manipulate = ORGAN_SLOT_STOMACH
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/bioreactor/repair,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	desc = "A mechanical surgery procedure designed to repair an androids internal bioreactor."
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_bioreactor

/datum/surgery/robot/close_bioreactor
	name = "Close Surgery (Bioreactor Maintenance)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB | SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery/robot/bioreactor/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/stomach/bioreactor = target.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(isnull(bioreactor) || !issynthetic(target) || bioreactor.damage < 10)
		return FALSE
	return ..()
