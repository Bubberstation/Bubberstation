/datum/quirk/kiss_slut
	name = "Kiss Slut"
	desc = "The sheer thought of kissing someone makes you blush and overheat, sending you into a spiral of passion."
	value = 0
	gain_text = span_purple("Thoughts of smooching invade your mind.")
	lose_text = span_purple("You feel like your lips have had enough for now.")
	medical_record_text = "Patient seems to demonstrate an extraordinary liking in kissing."
	mob_trait = TRAIT_KISS_SLUT //No use for this yet
	icon = FA_ICON_FACE_KISS_WINK_HEART
	erp_quirk = TRUE
	mail_goodies = list (
		/obj/item/lipstick/random = 20,
		/obj/item/lipstick/hypnosyndie = 1 // Very small chance of ERP lipstick
	)
