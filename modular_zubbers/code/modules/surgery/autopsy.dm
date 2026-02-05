/datum/surgery/autopsy/xenomorph
	name = "Xenomorph Autopsy"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_MORBID_CURIOSITY
	target_mobtypes = list(/mob/living/basic/alien, /mob/living/carbon/alien)

/datum/experiment/autopsy/xenomorph/is_valid_autopsy(mob/target)
	return (isalien(target) || istype(target, /mob/living/basic/alien))
