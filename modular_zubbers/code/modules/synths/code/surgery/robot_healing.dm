/datum/surgery/robot/healing
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/robot_heal,
		/datum/surgery_step/mechanic_close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	replaced_by = /datum/surgery
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_SELF_OPERABLE

	/// The step to use in the 4th surgery step.
	var/healing_step_type
	/// If true, doesn't send the surgery preop message. Set during surgery.
	var/surgery_preop_message_sent = FALSE
	num_opening_steps = 1
	num_steps_until_closing = 2
	close_surgery = /datum/surgery/robot/close_healing

/datum/surgery/robot/close_healing
	steps = list(
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	replaced_by = /datum/surgery
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_IGNORE_CLOTHES | SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_SELF_OPERABLE
	is_closer = TRUE

/datum/surgery/robot/healing/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(
			/datum/surgery_step/mechanic_open,
			healing_step_type,
			/datum/surgery_step/mechanic_close,
		)

/datum/surgery/robot/healing/basic
	name = "Repair robotics (Basic)"
	desc = "A surgical procedure that provides repairs and maintenance to robotic parts. Is slightly more efficient when the patient is severely damaged."
	healing_step_type = /datum/surgery_step/robot_heal/basic
	replaced_by = /datum/surgery/robot/healing/upgraded

/datum/surgery/robot/healing/upgraded
	name = "Repair robotics (Adv.)"
	desc = "A surgical procedure that provides highly effective repairs and maintenance to robotic parts. Is somewhat more efficient when the patient is severely damaged."
	healing_step_type = /datum/surgery_step/robot_heal/upgraded
	replaced_by = /datum/surgery/robot/healing/experimental
	requires_tech = TRUE

/datum/surgery/robot/healing/experimental
	name = "Repair robotics (Exp.)"
	desc = "A surgical procedure that quickly provides highly effective repairs and maintenance to robotic parts. Is moderately more efficient when the patient is severely damaged."
	healing_step_type = /datum/surgery_step/robot_heal/experimental
	replaced_by = null
	requires_tech = TRUE
