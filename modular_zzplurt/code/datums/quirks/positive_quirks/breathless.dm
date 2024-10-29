/datum/quirk/breathless
	name = "Breathless"
	desc = "Whether due to genetic engineering, medical technology, or bluespace magic, you no longer require air to function. This also means that administering life-saving maneuvers such as CPR is impossible."
	value = 3
	quirk_flags = QUIRK_PROCESSES
	gain_text = span_notice("You no longer need to breathe.")
	lose_text = span_notice("You need to breathe again...")
	medical_record_text = "Patient demonstrates no requirement for oxygen intake."
	mob_trait = TRAIT_NOBREATH
	hardcore_value = -3
	icon = FA_ICON_LUNGS

/datum/quirk/breathless/process(seconds_per_tick)
	var/mob/living/carbon/C = quirk_holder
	C.adjustOxyLoss(-3) // Fix for defibrillator "bug". probably not necessary in this codebase
