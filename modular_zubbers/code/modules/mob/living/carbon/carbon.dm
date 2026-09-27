// Override file for handling additional effects.
/mob/living/carbon/vomit(vomit_flags, vomit_type, lost_nutrition, distance, purge_ratio)

	// Override to make hemos vomit blood when they vomit.
	var/obj/item/organ/stomach/stomach = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!(vomit_flags & MOB_VOMIT_BLOOD) && HAS_TRAIT(stomach, TRAIT_STOMACH_BLOOD_VOMIT))
		vomit_flags |= MOB_VOMIT_BLOOD

	. = ..()

//Override for changing night vision and other sight-based traits.
/mob/living/carbon/get_sight_and_cutoffs()
	var/new_sight = NONE
	if(HAS_TRAIT(src, TRAIT_TRUE_NIGHT_VISION))
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_HIGH)

	if(HAS_TRAIT(src, TRAIT_MESON_VISION))
		new_sight |= SEE_TURFS
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_MEDIUM)

	if(HAS_TRAIT(src, TRAIT_THERMAL_VISION))
		new_sight |= SEE_MOBS
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_MEDIUM)

	if(HAS_TRAIT(src, TRAIT_NIGHT_VISION))
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_MEDIUM)

	if(HAS_TRAIT(src, TRAIT_XRAY_VISION))
		new_sight |= SEE_TURFS|SEE_MOBS|SEE_OBJS

	if(HAS_TRAIT(src, TRAIT_ECHOLOCATOR))
		new_sight |= SEE_MOBS|SEE_TURFS
		lighting_cutoff = max(lighting_cutoff, LIGHTING_CUTOFF_FULLBRIGHT)

	var/list/return_list = list(new_sight)
	SEND_SIGNAL(src, COMSIG_CARBON_UPDATE_SIGHT_CUTOFFS, return_list)
	return return_list[1]
