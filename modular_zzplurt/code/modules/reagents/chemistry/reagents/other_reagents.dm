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

/datum/reagent/water/holywater/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()

	// Check for Hallowed.
	if(HAS_TRAIT(exposed_mob, TRAIT_HALLOWED))
		// Alert user of holy water effect.
		to_chat(exposed_mob, span_nicegreen("The holy water nourishes you!"))

		// Add positive mood.
		exposed_mob.add_mood_event("fav_food", /datum/mood_event/favorite_food)

/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Makes holy water generally good for Hallowed users
	// Directly foils the effect it has on bloodfledges.
	if(HAS_TRAIT(affected_mob, TRAIT_HALLOWED))
		// Reduce disgust, hunger, and thirst
		affected_mob.adjust_disgust(-2)
		affected_mob.adjust_nutrition(6)
		//affected_mob.adjust_thirst(6) //Needs thirst port

	// Makes holy water disgusting and hungering for bloodfledges
	// Directly antithetic to the effects of blood
	if(HAS_TRAIT(affected_mob, TRAIT_BLOODFLEDGE))
		affected_mob.adjust_disgust(2)
		affected_mob.adjust_nutrition(-6)

	// Cursed blood effect moved here
	if(HAS_TRAIT(affected_mob, TRAIT_CURSED_BLOOD))
		// Wait for stuttering, to match old effect
		if(!affected_mob.has_status_effect(/datum/status_effect/speech/stutter))
			return

		// Escape clause: 12% chance to continue
		if(!prob(12))
			return

		// Character speaks nonsense
		affected_mob.say(pick("Somebody help me...","Unshackle me please...","Anybody... I've had enough of this dream...","The night blocks all sight...","Oh, somebody, please..."), forced = "holy water")

		// Escape clause: 10% chance to continue
		if(!prob(10))
			return

		// Character has a seisure
		affected_mob.visible_message(span_danger("[affected_mob] starts having a seizure!"), span_userdanger("You have a seizure!"))
		affected_mob.Unconscious(120)
		to_chat(affected_mob, "<span class='cultlarge'>[pick("The moon is close. It will be a long hunt tonight.", "Ludwig, why have you forsaken me?", \
		"The night is near its end...", "Fear the blood...")]</span>")

		// Apply damage
		affected_mob.adjustToxLoss(1, 0)
		affected_mob.adjustFireLoss(1, 0)

		// Escape clause: 25% chance to continue
		if(!prob(25))
			return

		// Spontaneous combustion
		affected_mob.ignite_mob()
