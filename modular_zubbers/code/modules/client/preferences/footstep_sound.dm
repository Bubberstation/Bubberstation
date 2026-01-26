/datum/preference/choiced/footstep_sound
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "footstep_sound"

/datum/preference/choiced/footstep_sound/init_possible_values()
	return list("Default", "Shoes", "Highheels", "Claws", "Hooves")

/datum/preference/choiced/footstep_sound/create_default_value()
	return "Default"

/datum/preference/choiced/footstep_sound/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "Default")
		return

	/// Either use the TG footstep_type here, or specify a special_footstep_sounds list.
	/// special_footstep_sounds list formatting must be: list(list(sounds, go, here), volume, range modifier)
	/// Note: special_footstep_sounds will play the same effect on all turfs, but TG footstep sounds are very hardcoded
	/// so if you want a new custom set of sounds that's the least-painful method of adding them, with the caveat of not being able to
	/// support turf-based sounds.
	var/static/list/value_to_define = list(
		"Shoes" = FOOTSTEP_MOB_SHOE,
		"Claws" = FOOTSTEP_MOB_CLAW,
		"Highheels" = list(list(
			'modular_zubbers/sound/effects/footstep/highheel1.ogg',
			'modular_zubbers/sound/effects/footstep/highheel2.ogg',
			'modular_zubbers/sound/effects/footstep/highheel3.ogg',
			'modular_zubbers/sound/effects/footstep/highheel4.ogg'), 70, 1),
		"Hooves" = list(list(
			'modular_zubbers/sound/effects/footstep/hardhoof1.ogg',
			'modular_zubbers/sound/effects/footstep/hardhoof2.ogg',
			'modular_zubbers/sound/effects/footstep/hardhoof3.ogg',
			'modular_zubbers/sound/effects/footstep/hardhoof4.ogg'), 35, 1),
	)
	var/footstep_type = value_to_define[value]

	var/obj/item/bodypart/leg/left_leg = target.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/right_leg = target.get_bodypart(BODY_ZONE_R_LEG)
	if(islist(footstep_type))
		left_leg?.special_footstep_sounds = footstep_type
		right_leg?.special_footstep_sounds = footstep_type
	else
		left_leg?.footstep_type = footstep_type
		right_leg?.footstep_type = footstep_type

	target.footstep_type = footstep_type // We are most likely going to have our legs get replaced during char creation immediately, so this is necessary to apply to any subsequent legs that get added.
