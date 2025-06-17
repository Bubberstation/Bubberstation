/obj/item/organ/eyes/synth
	name = "optical sensors"
	icon_state = "eyes_cyber"
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
	maxHealth = 1 * STANDARD_ORGAN_THRESHOLD
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/eyes/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				to_chat(owner, span_warning("Alert:Severe electromagnetic interference clouds your optics with static. Error Code: I-CS6"))
				apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
			if(EMP_LIGHT)
				to_chat(owner, span_warning("Alert: Mild interference clouds your optics with static. Error Code: I-CS0"))
				apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)

/datum/design/synth_eyes
	name = "Optical Sensors"
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
	id = "synth_eyes"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/eyes/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
