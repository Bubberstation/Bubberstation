/obj/item/organ/ears/werewolf
	name = "lupine ears"
	desc = "These ears are large and pointed, all the better to hear you with, my dear."
	organ_traits = list(TRAIT_GOOD_HEARING, TRAIT_HEARING_SENSITIVE) // We can hear whispers, but loud noises make us sad.

	preference = "feature_werewolf_ears"
	restyle_flags = EXTERNAL_RESTYLE_FLESH
	overrides_sprite_datum_organ_type = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears
