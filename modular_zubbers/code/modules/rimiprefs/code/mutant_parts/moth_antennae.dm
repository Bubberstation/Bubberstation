/datum/preference/toggle/mutant_toggle/moth_antennae
	savefile_key = "moth_antennae_toggle"
	relevant_mutant_bodypart = "moth_antennae"

/datum/preference/choiced/mutant/moth_antennae
	main_feature_name = "Moth Antennae"
	savefile_key = "feature_moth_antennae"
	relevant_mutant_bodypart = "moth_antennae"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_antennae
	var/icon/moth_head

/datum/preference/choiced/mutant/moth_antennae/New()
	. = ..()
	moth_head = icon('icons/mob/human/species/moth/bodyparts.dmi', "moth_head")
	moth_head.Blend(icon('icons/mob/human/human_face.dmi', "motheyes_l"), ICON_OVERLAY)
	moth_head.Blend(icon('icons/mob/human/human_face.dmi', "motheyes_r"), ICON_OVERLAY)

/datum/preference/choiced/mutant/moth_antennae/generate_icon(datum/sprite_accessory/sprite_accessory, dir)
	var/icon/icon_with_antennae = new(moth_head)
	icon_with_antennae.Blend(icon(sprite_accessory.icon, "m_moth_antennae_[sprite_accessory.icon_state]_FRONT"), ICON_OVERLAY)
	icon_with_antennae.Scale(64, 64)
	icon_with_antennae.Crop(15, 64, 15 + 31, 64 - 31)

	return icon_with_antennae

/datum/preference/mutant_color/moth_antennae
	savefile_key = "moth_antennae_color"
	relevant_mutant_bodypart = "moth_antennae"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_antennae

/datum/preference/emissive_toggle/moth_antennae
	savefile_key = "moth_antennae_emissive"
	relevant_mutant_bodypart = "moth_antennae"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_antennae
