/datum/preference/choiced/mutant/pod_hair
	savefile_key = "feature_pod_hair"
	main_feature_name = "Hairstyle"
	relevant_mutant_bodypart = "pod_hair"
	default_accessory_name = "Ivy"
	should_generate_icons = TRUE
	supplemental_features = list("pod_hair_color")
	var/icon/pod_head

/datum/preference/choiced/mutant/pod_hair/New()
	. = ..()
	pod_head = icon('icons/mob/human/bodyparts_greyscale.dmi', "pod_head_m")
	pod_head.Blend(COLOR_GREEN, ICON_MULTIPLY)

/datum/preference/choiced/mutant/pod_hair/generate_icon(datum/sprite_accessory/pod_hair, dir)
	var/icon/icon_with_hair = new(pod_head)
	var/icon/icon_adj = icon(pod_hair.icon, "m_pod_hair_[pod_hair.icon_state]_ADJ")
	var/icon/icon_front = icon(pod_hair.icon, "m_pod_hair_[pod_hair.icon_state]_FRONT_OVER")
	icon_front.Blend(COLOR_MAGENTA, ICON_MULTIPLY)
	icon_adj.Blend(COLOR_VIBRANT_LIME, ICON_MULTIPLY)
	icon_adj.Blend(icon_front, ICON_OVERLAY)
	icon_with_hair.Blend(icon_adj, ICON_OVERLAY)
	icon_with_hair.Scale(64, 64)
	icon_with_hair.Crop(15, 64, 15 + 31, 64 - 31)

	return icon_with_hair

/datum/preference/choiced/mutant/pod_hair/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/species_path = preferences?.read_preference(/datum/preference/choiced/species)
	if(!ispath(species_path, /datum/species/pod)) // This is what we do so it doesn't show up on non-podpeople.
		return

	return ..()

/datum/preference/mutant_color/pod_hair_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_key = "pod_hair_color"
	relevant_mutant_bodypart = "pod_hair"
	type_to_check = /datum/preference/choiced/mutant/pod_hair

/datum/preference/emissive_toggle/pod_hair_emissive
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_key = "pod_hair_emissive"
	relevant_mutant_bodypart = "pod_hair"
	type_to_check = /datum/preference/choiced/mutant/pod_hair
