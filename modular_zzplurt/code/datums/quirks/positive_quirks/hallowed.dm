/datum/quirk/hallowed
	name = "Hallowed"
	desc = "You have been blessed by a higher power, or are otherwise imbued with holy energy in some way. Your divine presence drives away unholy magics! Holy water is extra potent for you."
	value = 1 // Maybe up the cost if more is added later.
	gain_text = span_notice("You feel holy energy radiating through your body.")
	lose_text = span_notice("You feel your holy energy fading away...")
	medical_record_text = "Patient is under the influence of an unidentified hallowed blessing. Please consult a chaplain."
	mob_trait = TRAIT_HALLOWED
	hardcore_value = -1
	icon = FA_ICON_CHURCH
	mail_goodies = list (
		/obj/item/reagent_containers/cup/glass/bottle/holywater = 1
	)

/datum/quirk/hallowed/add(client/client_source)
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Give the holy trait.
	ADD_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Give the antimagic trait.
	ADD_TRAIT(quirk_mob, TRAIT_ANTIMAGIC, "quirk_hallowed")

	// Makes the user holy.
	quirk_mob.mind.holy_role = HOLY_ROLE_DEACON

	// Add status effect
	quirk_holder.apply_status_effect(/datum/status_effect/headpat_hater)

/datum/quirk/hallowed/remove()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove the holy trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Remove the antimagic trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_ANTIMAGIC, "quirk_hallowed")

	// Makes the user not holy.
	quirk_mob.mind.holy_role = NONE

	// Remove status effect
	quirk_holder.remove_status_effect(/datum/status_effect/headpat_hater)

// Set effect examine text
/datum/status_effect/headpat_hater/get_examine_text()
	return span_notice("[owner.p_They()] radiate[owner.p_s()] divine power.")

/datum/reagent/water/holywater/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()

	// Check for Hallowed.
	if(HAS_TRAIT(exposed_mob, TRAIT_HALLOWED))
		// Alert user of holy water effect.
		to_chat(exposed_mob, span_nicegreen("The holy water nourishes and energizes you!"))

		// Add positive mood.
		exposed_mob.add_mood_event("fav_food", /datum/mood_event/favorite_food)

/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)

	//Makes holy water generally good for Hallowed users.
	//Holy water is tough to get in comparison to other medicine anyways.
	if(HAS_TRAIT(affected_mob, TRAIT_HALLOWED))
		// Reduce disgust.
		affected_mob.adjust_disgust(-3)

		// Restore stamina.
		affected_mob.adjustStaminaLoss(3)

		// Reduce hunger and thirst.
		affected_mob.adjust_nutrition(3)
		//affected_mob.adjust_thirst(3) //Needs thirst port

		// Heal brute and burn.
		// Accounts for robotic limbs.
		affected_mob.heal_overall_damage(2,2)
		// Heal oxygen.
		affected_mob.adjustOxyLoss(-2)
		// Heal clone.
		//affected_mob.adjustCloneLoss(-2) //Needs cloning port

		// Need to remove the holy water from consumer eventually.
		holder.remove_reagent(type, 0.2)

		// Negate all other holy water effects.
		return

	// Return normally.
	. = ..()

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
