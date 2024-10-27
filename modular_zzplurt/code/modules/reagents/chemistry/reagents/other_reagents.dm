/datum/reagent/hellwater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	// SPLURT EDIT - Check for Cursed Blood quirk
	// This replaces the normal reagent effect
	if(HAS_TRAIT(affected_mob, TRAIT_CURSED_BLOOD))
		affected_mob.adjustToxLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
		affected_mob.adjustOxyLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
		affected_mob.adjustBruteLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
		affected_mob.adjustFireLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
		affected_mob.extinguish_mob()
		holder.remove_reagent(type, 1)
		return

	// Run original
	. = ..()
