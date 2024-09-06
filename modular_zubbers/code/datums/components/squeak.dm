/datum/component/squeak/Initialize(custom_sounds, volume_override, chance_override, step_delay_override, use_delay_override, extrarange, falloff_exponent, fallof_distance)
	. = ..()
	if(istype(parent, /obj/item/clothing/neck))
		RegisterSignal(parent, COMSIG_NECK_STEP_ACTION, PROC_REF(step_squeak))
