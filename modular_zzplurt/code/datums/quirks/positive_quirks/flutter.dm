/datum/quirk/flutter
	name = "Flutter"
	desc = "You are able to move freely in pressurized low-gravity environments."
	value = 2
	gain_text = span_notice("Your body is prepared to maneuver pressurized low-gravity environments.")
	lose_text = span_notice("You forget how to move around in low-gravity.")
	medical_record_text = "Patient demonstrates exceptional maneuverability in low-gravity environments."
	mob_trait = TRAIT_FLUTTER
	hardcore_value = -1
	icon = FA_ICON_DOVE

/mob/Process_Spacemove(movement_dir, continuous_move)
	if(HAS_TRAIT(src, TRAIT_FLUTTER))
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/environment = T.return_air()
		if(environment.return_pressure() > 30)
			return TRUE
	. = ..()
