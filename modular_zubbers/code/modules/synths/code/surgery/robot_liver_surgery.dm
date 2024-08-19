/// Reagent Processor Repair surgery
/datum/surgery/robot/reagent_pump
	name = "Reagent Processor Manual Reset"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB | SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/reagent_pump/repair,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A mechanical list of actions to reset the reagent processor and purge built up minerals."
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_reagent_pump

/datum/surgery/robot/close_reagent_pump
	name = "Close Surgery (Reagent Processor Manual Reset)"
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

/datum/surgery/robot/reagent_pump/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/liver/reagent_processor = target.get_organ_slot(ORGAN_SLOT_LIVER)
	if(isnull(reagent_processor) || !issynthetic(target) || reagent_processor.damage < 10)
		return FALSE
	return ..()
