/datum/surgery/blood_filter/mechanic
	name = "Hydraulics Purge"
	requires_bodypart_type = BODYTYPE_ROBOTIC | BODYTYPE_NANO
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/filter_blood,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)

/datum/surgery/blood_filter/mechanic/can_start(mob/user, mob/living/carbon/target)
	if(HAS_TRAIT(target, TRAIT_HUSK)) //You can filter the blood of a dead person just not husked
		return FALSE
	return ..()
