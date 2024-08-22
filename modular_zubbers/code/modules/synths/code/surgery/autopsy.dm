/datum/surgery/robot/autopsy
	name = "System Failure Analysis"
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/autopsy,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	num_opening_steps = 2
	num_steps_until_closing = 4
	close_surgery = /datum/surgery/robot/close_autopsy

/datum/surgery/robot/close_autopsy
	name = "Close Surgery (System Failure Analysis)"
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE

/datum/surgery/robot/autopsy/can_start(mob/user, mob/living/patient)
	if(!..())
		return FALSE
	if(patient.stat != DEAD)
		return FALSE
	if(HAS_TRAIT_FROM(patient, TRAIT_DISSECTED, AUTOPSY_TRAIT))
		return FALSE
	return TRUE
