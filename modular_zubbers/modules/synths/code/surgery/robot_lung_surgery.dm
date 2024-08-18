/// Heatsink Repair Surgery
/datum/surgery/robot/heatsink
	name = "Heatsink Maintenance"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB | SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/weld_plating_slice,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/heatsink/repair,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/weld_plating,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A mechanical surgery procedure designed to repair an androids internal heatsink."
	num_opening_steps = 4
	num_steps_until_closing = 7
	close_surgery = /datum/surgery/robot/close_heatsink

/datum/surgery/robot/close_heatsink
	name = "Close Surgery (Heatsink Maintenance)"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB | SURGERY_SELF_OPERABLE
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/weld_plating
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery/robot/heatsink/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	var/obj/item/organ/internal/lungs/target_lungs = target.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(isnull(target_lungs) || !issynthetic(target) || target_lungs.damage < 10 )
		return FALSE
	return ..()
