#define RESTMETA_BRUTE_THRESHOLD 50
#define RESTMETA_BRUTE_AMOUNT -0.5
#define RESTMETA_BURN_THRESHOLD 50
#define RESTMETA_BURN_AMOUNT -0.25
#define RESTMETA_TOX_THRESHOLD 50
#define RESTMETA_TOX_AMOUNT -0.3

/datum/quirk/restorative_metabolism
	name = "Restorative Metabolism"
	desc = "Your body possesses a differentiated reconstructive ability, allowing you to slowly recover from light to moderate injuries. Critical injuries, wounds, and genetic damage will still require medical attention."
	value = 10
	quirk_flags = QUIRK_PROCESSES
	gain_text = span_notice("You feel a surge of reconstructive vitality coursing through your body...")
	lose_text = span_notice("You sense your enhanced reconstructive ability fading away...")
	medical_record_text = "Patient possesses a self-reconstructive condition. Medical care is only required under extreme circumstances."
	mob_trait = TRAIT_RESTORATIVE_METABOLISM
	hardcore_value = -10
	icon = FA_ICON_BRIEFCASE_MEDICAL

/datum/quirk/restorative_metabolism/process(seconds_per_tick)
	// Quirk holder must be injured
	if(quirk_holder.health >= quirk_holder.maxHealth)
		// Do nothing
		return

	// Define health needing updates
	var/need_mob_update = FALSE

	// Check brute threshold
	if(quirk_holder.getBruteLoss() <= RESTMETA_BRUTE_THRESHOLD)
		need_mob_update += quirk_holder.adjustBruteLoss(RESTMETA_BRUTE_AMOUNT, updating_health = FALSE)

	// Check burn threshold
	if(quirk_holder.getFireLoss() <= RESTMETA_BURN_THRESHOLD)
		need_mob_update += quirk_holder.adjustFireLoss(RESTMETA_BURN_AMOUNT, updating_health = FALSE)

	// Check tox threshold
	if(quirk_holder.getToxLoss() <= RESTMETA_TOX_THRESHOLD)
		need_mob_update += quirk_holder.adjustToxLoss(RESTMETA_TOX_AMOUNT, updating_health = FALSE, forced = TRUE)

	// Check if healing will be applied
	if(need_mob_update)
		// Update health
		quirk_holder.updatehealth()

#undef RESTMETA_BRUTE_THRESHOLD
#undef RESTMETA_BRUTE_AMOUNT
#undef RESTMETA_BURN_THRESHOLD
#undef RESTMETA_BURN_AMOUNT
#undef RESTMETA_TOX_THRESHOLD
#undef RESTMETA_TOX_AMOUNT
