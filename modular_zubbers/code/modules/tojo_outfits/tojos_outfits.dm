// You'll find the icons in the Skyrat master files. It was way too much of a headache to pretend to care about
// the modularization when its been far abandoned due to lack of refactors to the species refit system.
//
// This is a cry for help, coders!

// Kiryu outfits, for a joke, but also a good looking uniform that everyone can use.

/obj/item/clothing/under/red_and_white_collared_outfit
	desc = "An outfit that screams 'I've never killed anyone!', which is probably true."
	name = "red and white collared outfit"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "whiteandred_kiryulmfao"
	worn_icon_state = "whiteandred_kiryulmfao"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/datum/loadout_item/uniform/miscellaneous/red_and_white_collared_outfit
	name = "red and white collared outfit"
	item_path = /obj/item/clothing/under/red_and_white_collared_outfit

