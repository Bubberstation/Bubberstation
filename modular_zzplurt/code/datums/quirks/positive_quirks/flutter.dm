/// Amount of drift force to apply when flying
#define FLUTTER_FUNCTIONAL_FORCE 1 NEWTONS
/// Minimum air pressure to allow movement
#define FLUTTER_MIN_PRESSURE WARNING_LOW_PRESSURE

/datum/quirk/flutter
	name = "Flutter"
	desc = "You are able to propel yourself forward in pressurized low-gravity environments. Slowing back down may be tricky."
	value = 2
	gain_text = span_notice("Your body is prepared to maneuver pressurized low-gravity environments.")
	lose_text = span_notice("You forget how to move around in low-gravity.")
	medical_record_text = "Patient demonstrates exceptional maneuverability in low-gravity environments."
	mob_trait = TRAIT_FLUTTER
	hardcore_value = -1
	icon = FA_ICON_PLANE

/datum/quirk/flutter/add(client/client_source)
	// Add movement element
	quirk_holder.AddElementTrait(TRAIT_FLUTTER_MOVE, TRAIT_FLUTTER, /datum/element/flutter_move, FLUTTER_FUNCTIONAL_FORCE, FLUTTER_MIN_PRESSURE)

	// Add drifting trait
	ADD_TRAIT(quirk_holder, TRAIT_NOGRAV_ALWAYS_DRIFT, TRAIT_FLUTTER)

/datum/quirk/flutter/remove()
	// Remove movement element
	REMOVE_TRAIT(quirk_holder, TRAIT_FLUTTER_MOVE, TRAIT_FLUTTER)

	// Remove drifting trait
	REMOVE_TRAIT(quirk_holder, TRAIT_NOGRAV_ALWAYS_DRIFT, TRAIT_FLUTTER)

#undef FLUTTER_FUNCTIONAL_FORCE
#undef FLUTTER_MIN_PRESSURE
