/*
	Grants the user a pro skateboard upon spawning, in addition to reducing the stamina loss from grinding,
	doing tricks, and bumping into something while riding on skateboards by 70% and motorized wheelchairs by 30%.
	This also applies the same reduction to any stun or paralyze that occurs due to crashing, and provides a chance
	to avoid brain damage when crashing. Soft caps also get automatically flipped when initially equipped by the user.

	Any children types of the skateboard are included in this, such as Wheely-Heels.
*/

//Variable used when calculating stamina damage for skateboards, motorized wheelchairs, etc.
#define QUIRK_BROSKATER_MULTIPLIER 0.3
#define QUIRK_BROSKATER_WHEELCHAIR_MULTIPLIER 0.7

/datum/quirk/item_quirk/bro_skater
	name = "Bro Skater"
	desc = "You're a little too into old-earth skater culture! You're much more used to riding and \
		falling off skateboards, needing less stamina to do kickflips and taking less damage upon \
		bumping into something. You also have a propensity for being 'cool' while wearing soft-caps."
	icon = FA_ICON_HAND_MIDDLE_FINGER
	value = 6
	mob_trait = TRAIT_BROSKATER
	gain_text = span_notice("You feel like hitting a sick grind!")
	lose_text = span_danger("You no longer feel like you're in touch with the youth.")
	medical_record_text = "Patient reported latest injuries arose from \"failing to catch a sick grind\"."

/datum/quirk/item_quirk/bro_skater/add_unique(client/client_source)
	give_item_to_holder(/obj/item/melee/skateboard/pro, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))
