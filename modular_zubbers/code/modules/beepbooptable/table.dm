

/obj/structure/table/optable/proc/ekg(mob/living/carbon/patient)
	var/most_severe
	if(!patient)
		most_severe = TRUE
		return
	if(patient.stat >= HARD_CRIT)
		playsound(computer, 'modular_zubbers/sound/machines/operating_table/flatline.ogg', 5)
		most_severe = TRUE
	if(patient.stat == SOFT_CRIT || BLOOD_VOLUME_SURVIVE > patient.blood_volume || organ_fatal_test(patient) && !most_severe)
		playsound(computer, pick('modular_zubbers/sound/machines/operating_table/ekg_alert.ogg', 'modular_zubbers/sound/machines/operating_table/flatline.ogg'), 5)
		most_severe = TRUE
	for(var/datum/wound/wound in patient.all_wounds && !most_severe)
		if(wound.severity >= WOUND_SEVERITY_MODERATE)
			playsound(computer, 'modular_zubbers/sound/machines/operating_table/quiet_double_beep.ogg', 5)
			most_severe = TRUE
			break
	if(patient.health <= patient.maxHealth && !most_severe)
		playsound(computer, 'modular_zubbers/sound/machines/operating_table/quiet_beep.ogg', 5)

	if(patient && patient.loc == src.loc)
		addtimer(CALLBACK(src, .proc/ekg, patient), 2 SECONDS, TIMER_OVERRIDE) // SFX length


/obj/structure/table/optable/proc/organ_fatal_test(mob/living/carbon/patient)
	var/obj/item/organ/internal/fatal_heart = patient?.get_organ_slot(ORGAN_SLOT_HEART)
	var/obj/item/organ/internal/fatal_liver = patient?.get_organ_slot(ORGAN_SLOT_LIVER)
	var/obj/item/organ/internal/fatal_lungs = patient?.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(fatal_heart.organ_flags & ORGAN_FAILING)
		return fatal_heart
	if(fatal_liver.organ_flags & ORGAN_FAILING)
		return fatal_liver
	if(fatal_lungs.organ_flags & ORGAN_FAILING)
		return fatal_lungs
