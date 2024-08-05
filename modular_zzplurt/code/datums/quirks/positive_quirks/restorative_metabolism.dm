/datum/quirk/restorative_metabolism
	name = "Restorative Metabolism"
	desc = "Your body possesses a differentiated reconstutitive ability, allowing you to slowly recover from injuries. Note, however, that critical injuries, wounds or genetic damage will still require medical attention."
	value = 3
	mob_trait = TRAIT_RESTORATIVE_METABOLISM
	gain_text = span_notice("You feel a surge of reconstutitive vitality coursing through your body...")
	lose_text = span_notice("You sense your enhanced reconstutitive ability fading away...")
	quirk_flags = /datum/quirk::quirk_flags | QUIRK_PROCESSES

/datum/quirk/restorative_metabolism/process(seconds_per_tick)
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder

	H.adjustBruteLoss(-0.5)
	H.adjustFireLoss(-0.25)
	if(H.getBruteLoss() > 0 && H.getFireLoss() <= 50 || H.getFireLoss() > 0 && H.getFireLoss() <= 50)
		H.adjustBruteLoss(-0.5, forced = TRUE)
		H.adjustFireLoss(-0.25, forced = TRUE)
	else if (H.getToxLoss() <= 90)
		H.adjustToxLoss(-0.3, forced = TRUE)
