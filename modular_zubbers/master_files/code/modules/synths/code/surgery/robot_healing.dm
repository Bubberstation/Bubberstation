// Override of skyrat code

/datum/surgery/robot_healing // This doesn't need to be a /robot surgery because close is already an alternate step
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/robot_heal,
		/datum/surgery_step/mechanic_close,
	)

/datum/surgery/robot_healing/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(
			/datum/surgery_step/mechanic_open,
			healing_step_type,
			/datum/surgery_step/mechanic_close,
		)
