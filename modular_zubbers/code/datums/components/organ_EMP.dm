/datum/component/organ_emp_effects
	var/emp_vulnerability = 0
	var/valid_type = /obj/item/organ

/datum/component/organ_emp_effects/Initialize(emp_vulnerability)
	if(ispath(parent, valid_type))
		return COMPONENT_INCOMPATIBLE

	if(emp_vulnerability)
		src.emp_vulnerability = emp_vulnerability

/datum/component/organ_emp_effects/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, PROC_REF(on_parent_emp))

/datum/component/organ_emp_effects/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_EMP_ACT)

/datum/component/organ_emp_effects/proc/on_parent_emp(obj/item/organ/organ, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(organ, severe_cooldown))
		emp_special_effects(parent)
		COOLDOWN_START(organ, severe_cooldown, 30 SECONDS)
	if(prob(emp_vulnerability/severity))
		organ.organ_flags |= ORGAN_EMP

/datum/component/organ_emp_effects/proc/emp_special_effects(obj/item/organ/organ)
	return

/datum/component/organ_emp_effects/lungs
	valid_type = /obj/item/organ/lungs

/datum/component/organ_emp_effects/lungs/emp_special_effects(obj/item/organ/organ)
	if(!isnull(organ.owner))
		organ.owner.losebreath += 20
