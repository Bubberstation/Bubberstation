/datum/surgery_operation/organ/repair
	/// Organ requires this much damage before it can be operated on
	var/requires_organ_damage

/datum/surgery_operation/organ/repair/state_check(obj/item/organ/organ)
	. = ..()
	// Ensure organ has the required amount of damage
	if(!isnull(requires_organ_damage) && (organ.damage < requires_organ_damage))
		return FALSE

// This is so that you can do organ surgeries multiple times on slimepeople.
/datum/surgery_operation/organ/repair/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	if(istype(organ, /obj/item/organ/lungs/slime))
		addtimer(CALLBACK(PROC_REF(make_operable), organ, surgeon, tool, operation_args), 30 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)

/datum/surgery_operation/organ/repair/lobectomy/mechanic
	blocked_organ_flag = ORGAN_SYNTHETIC_FROM_SPECIES

/datum/surgery_operation/organ/repair/hepatectomy/mechanic
	blocked_organ_flag = ORGAN_SYNTHETIC_FROM_SPECIES

/datum/surgery_operation/organ/repair/coronary_bypass/mechanic
	blocked_organ_flag = ORGAN_SYNTHETIC_FROM_SPECIES

/datum/surgery_operation/organ/repair/gastrectomy/mechanic
	blocked_organ_flag = ORGAN_SYNTHETIC_FROM_SPECIES

/datum/surgery_operation/organ/repair/brain/mechanic
	blocked_organ_flag = ORGAN_SYNTHETIC_FROM_SPECIES
