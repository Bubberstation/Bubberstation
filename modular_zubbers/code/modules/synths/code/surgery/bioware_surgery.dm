/datum/surgery/robot/advanced/bioware
	name = "Enhancement surgery"
	/// What status effect is gained when the surgery is successful?
	/// Used to check against other bioware types to prevent stacking.
	var/status_effect_gained = /datum/status_effect/bioware

/datum/surgery/robot/advanced/bioware/can_start(mob/user, mob/living/carbon/human/target)
	if(!..())
		return FALSE
	if(!istype(target))
		return FALSE
	if(target.has_status_effect(status_effect_gained))
		return FALSE
	return TRUE
