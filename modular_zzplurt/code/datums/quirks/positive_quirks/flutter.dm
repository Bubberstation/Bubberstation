/datum/quirk/flutter
	name = "Flutter"
	desc = "You are able to move about freely in pressurized low-gravity environments be it through the use of wings, magic, or some other physiological nonsense."
	value = 1
	mob_trait = TRAIT_FLUTTER

/mob/Process_Spacemove(movement_dir, continuous_move)
	if(HAS_TRAIT(src, TRAIT_FLUTTER))
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/environment = T.return_air()
		if(environment.return_pressure() > 30)
			return TRUE
	. = ..()
