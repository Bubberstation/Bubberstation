/datum/quirk/breathless
	name = "Breathless"
	desc = "Whether due to genetic engineering, technology, or bluespace magic, you no longer require air to function. This also means that administering life-saving manuevers such as CPR would be impossible."
	value = 3
	medical_record_text = "Patient's biology demonstrates no need for breathing."
	gain_text = span_notice("You no longer need to breathe.")
	lose_text = span_notice("You need to breathe again...")
	mob_trait = TRAIT_NOBREATH
	quirk_flags = /datum/quirk::quirk_flags | QUIRK_PROCESSES

/datum/quirk/breathless/process(seconds_per_tick)
	var/mob/living/carbon/C = quirk_holder
	C.adjustOxyLoss(-3) // Fix for defibrillator "bug". probably not necessary in this codebase
