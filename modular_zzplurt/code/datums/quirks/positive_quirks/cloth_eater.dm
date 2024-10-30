/datum/quirk/cloth_eater
	name = "Clothes Eater"
	desc = "You can eat most apparel to gain a boost in mood, and to gain some nutrients. Insects already have this."
	value = 2
	gain_text = span_notice("Jumpsuits start to look like an appealing snack.")
	lose_text = span_notice("Cloth doesn't seem appetizing anymore.")
	medical_record_text = "Patient demonstrates a moth-like tendency to consume clothing items."
	mob_trait = TRAIT_CLOTH_EATER
	icon = FA_ICON_SHIRT
	var/mood_category ="cloth_eaten"
