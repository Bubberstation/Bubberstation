/datum/surgery/blood_filter/mechanic
	name = "Hydraulics Purge (blood filter)"
	requires_bodypart_type = BODYTYPE_ROBOTIC | BODYTYPE_NANO
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/filter_blood,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)

