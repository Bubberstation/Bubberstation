/datum/interaction/lewd/nipsuck
	name = "Suck Nipples"
	description = "Suck their nipples."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	message = list(
		"gently sucks on %TARGET%'s nipple.",
		"gently nibs %TARGET%'s nipple.",
		"licks %TARGET%'s nipple."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	user_arousal = 2
	target_pleasure = 3
	target_arousal = 5

/datum/interaction/lewd/nipsuck/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()

	// Handle different intents
	switch(resolve_intent_name(user.combat_mode))
		if("harm")
			message = list(
				"bites %TARGET%'s nipple.",
				"aggressively sucks %TARGET%'s nipple."
			)
			target_pleasure = 4 // Aggressive sucking has higher rewards
			target_arousal = 5
		if("disarm")
			message = list(
				"playfully nibbles %TARGET%'s nipple.",
				"teasingly sucks %TARGET%'s nipple.",
				"gently bites %TARGET%'s nipple."
			)
		if("grab")
			message = list(
				"sucks %TARGET%'s nipple intently.",
				"feasts on %TARGET%'s nipple.",
				"glomps %TARGET%'s nipple."
			)
			target_pleasure = 4 // Intent sucking has higher rewards
			target_arousal = 5
	. = ..()
	message = original_messages

/datum/interaction/lewd/nipsuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/obj/item/organ/external/genital/breasts/breasts = target.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts?.internal_fluid_datum)
		// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
		var/milk_multiplier = 0.5
		if(breasts.internal_fluid_maximum > 0)
			milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

		var/transfer_amount = rand(1, 2 * milk_multiplier)
		var/intent = resolve_intent_name(user.combat_mode)
		if(intent == "harm" || intent == "grab")
			transfer_amount = rand(1, 3 * milk_multiplier) // More aggressive sucking gets more milk

		var/datum/reagents/R = new(breasts.internal_fluid_maximum)
		breasts.transfer_internal_fluid(R, transfer_amount)
		R.trans_to(user, R.total_volume)
		qdel(R)

	if(!user.combat_mode && prob(5 + target.arousal))
		var/list/arousal_messages
		switch(resolve_intent_name(user.combat_mode))
			if("help")
				arousal_messages = list(
					"%TARGET% shivers in arousal.",
					"%TARGET% moans quietly.",
					"%TARGET% breathes out a soft moan.",
					"%TARGET% gasps.",
					"%TARGET% shudders softly.",
					"%TARGET% trembles as their chest gets molested."
				)
			if("disarm")
				arousal_messages = list(
					"%TARGET% playfully squirms.",
					"%TARGET% wiggles teasingly.",
					"%TARGET% lets out a playful moan.",
					"%TARGET% bites their lip.",
					"%TARGET% squirms from the teasing."
				)
			if("grab")
				arousal_messages = list(
					"%TARGET% moans eagerly.",
					"%TARGET% presses their chest forward.",
					"%TARGET% lets out a wanting groan.",
					"%TARGET% quivers with excitement.",
					"%TARGET% shivers with anticipation."
				)

		if(arousal_messages)
			message = list(pick(arousal_messages))
