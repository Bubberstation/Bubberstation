/datum/reagent/drug/aphrodisiac/camphor/overdose_effects(mob/living/carbon/human/exposed_mob)
	. = ..() // Call parent to handle base genital resets
	var/modified_genitals = FALSE

	if(exposed_mob.get_organ_slot(ORGAN_SLOT_BELLY))
		var/obj/item/organ/external/genital/belly/mob_belly = exposed_mob.get_organ_slot(ORGAN_SLOT_BELLY)
		var/original_belly_size = exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/belly_size)
		if(original_belly_size)
			if(mob_belly?.genital_size > original_belly_size)
				mob_belly.genital_size -= belly_size_reduction_step
				mob_belly.update_sprite_suffix()
				modified_genitals = TRUE
			if(mob_belly?.genital_size < original_belly_size)
				mob_belly.genital_size += belly_size_increase_step
				mob_belly.update_sprite_suffix()
				modified_genitals = TRUE

	if(exposed_mob.get_organ_slot(ORGAN_SLOT_BUTT))
		var/obj/item/organ/external/genital/butt/mob_butt = exposed_mob.get_organ_slot(ORGAN_SLOT_BUTT)
		var/original_butt_size = exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/butt_size)
		if(original_butt_size)
			if(mob_butt?.genital_size > original_butt_size)
				mob_butt.genital_size -= butt_size_reduction_step
				mob_butt.update_sprite_suffix()
				modified_genitals = TRUE
			if(mob_butt?.genital_size < original_butt_size)
				mob_butt.genital_size += butt_size_increase_step
				mob_butt.update_sprite_suffix()
				modified_genitals = TRUE

	if(modified_genitals)
		exposed_mob.update_body()
