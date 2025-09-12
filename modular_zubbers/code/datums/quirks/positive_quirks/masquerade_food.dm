/datum/quirk/masquerade_food
	name = "Masquerade"
	desc = "A hemophage that has adapted to be able to consume normal food and drink.  Such an act is merely for pleasure, as they derive no nutritional benefit from such."
	icon = FA_ICON_MASKS_THEATER
	value = 2
	mob_trait = TRAIT_MASQUERADE_FOOD
	gain_text = span_notice("You feel that your body has adapted to consumption of normal food and drink without mixing in blood.")
	lose_text = span_danger("You feel that your body is no longer able to consume normal food or drink without mixing in blood.")
	medical_record_text = "Patient is able to consume food or drink without having to mix in blood, though they derive no nutritional benefit from it."
	species_whitelist = list(SPECIES_HEMOPHAGE)
