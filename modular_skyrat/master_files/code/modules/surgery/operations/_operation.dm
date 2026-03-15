/datum/surgery_operation/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	// warning for unanesthetized surgery
	var/mob/living/patient = get_patient(operating_on)
	if(!(HAS_TRAIT(patient, TRAIT_ANALGESIA) || patient.stat >= UNCONSCIOUS))
		patient.balloon_alert(surgeon, "not numbed!")

/// Makes the organ operable again
/datum/surgery_operation/organ/proc/make_operable(obj/item/organ/organ)
	REMOVE_TRAIT(organ, TRAIT_ORGAN_OPERATED_ON, TRAIT_GENERIC)

/datum/surgery_operation/limb
	/// Body type blocked from performing this operation
	var/blocked_bodytype = NONE

/datum/surgery_operation/organ
	/// Body type blocked from performing this operation
	var/blocked_organ_flag = NONE
