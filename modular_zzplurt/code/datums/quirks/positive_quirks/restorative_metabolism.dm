/datum/quirk/restorative_metabolism
	name = "Restorative Metabolism"
	desc = "Your body possesses a differentiated reconstructive ability, allowing you to slowly recover from injuries. Critical injuries, wounds, and genetic damage will still require medical attention."
	value = 10
	quirk_flags = QUIRK_PROCESSES
	gain_text = span_notice("You feel a surge of reconstructive vitality coursing through your body...")
	lose_text = span_notice("You sense your enhanced reconstructive ability fading away...")
	medical_record_text = "Patient possesses a self-reconstructive condition. Medical care is only required under extreme circumstances."
	mob_trait = TRAIT_RESTORATIVE_METABOLISM
	hardcore_value = -10
	icon = FA_ICON_NOTES_MEDICAL

/datum/quirk/restorative_metabolism/process(seconds_per_tick)
	var/mob/living/carbon/human/H = quirk_holder

	H.adjustBruteLoss(-0.5)
	H.adjustFireLoss(-0.25)
	if(H.getBruteLoss() > 0 && H.getFireLoss() <= 50 || H.getFireLoss() > 0 && H.getFireLoss() <= 50)
		H.adjustBruteLoss(-0.5, forced = TRUE)
		H.adjustFireLoss(-0.25, forced = TRUE)
	else if (H.getToxLoss() <= 90)
		H.adjustToxLoss(-0.3, forced = TRUE)
