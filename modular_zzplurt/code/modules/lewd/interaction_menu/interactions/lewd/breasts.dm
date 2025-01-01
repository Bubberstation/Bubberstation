/datum/interaction/lewd/breastfeed
	name = "Breastfeed"
	description = "Breastfeed them."
	user_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	message = list(
		"pushes their breasts against %TARGET%'s mouth, squirting their warm %MILK% into their mouth.",
		"fills %TARGET%'s mouth with warm, sweet %MILK% as they squeeze their boobs, panting.",
		"lets a large stream of their own abundant %MILK% coat the back of %TARGET%'s throat."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 2
	user_arousal = 3
	target_pleasure = 0
	target_arousal = 2

/datum/interaction/lewd/breastfeed/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/organ/external/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(!breasts?.internal_fluid_datum)
		return

	var/datum/reagent/milk = find_reagent_object_from_type(breasts.internal_fluid_datum)
	var/list/original_messages = message.Copy()
	var/chosen_message = pick(message)
	chosen_message = replacetext(chosen_message, "%MILK%", lowertext(milk.name))
	message = list(chosen_message)
	. = ..()
	message = original_messages

/datum/interaction/lewd/breastfeed/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/obj/item/organ/external/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts?.internal_fluid_datum)
		// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
		var/milk_multiplier = 0.5
		if(breasts.internal_fluid_maximum > 0)
			milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

		var/transfer_amount = rand(1, 3 * milk_multiplier)
		var/datum/reagents/R = new(breasts.internal_fluid_maximum)
		breasts.transfer_internal_fluid(R, transfer_amount)
		R.trans_to(target, R.total_volume)
		qdel(R)

/datum/interaction/lewd/titgrope
	name = "Grope Breasts"
	description = "Grope their breasts."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_ANY)
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	message = list(
		"gently gropes %TARGET%'s breast.",
		"softly squeezes %TARGET%'s breasts.",
		"grips %TARGET%'s breasts.",
		"runs a few fingers over %TARGET%'s breast.",
		"delicately teases %TARGET%'s nipple.",
		"traces a touch across %TARGET%'s breast."
	)
	sound_possible = list('modular_zzplurt/sound/interactions/squelch1.ogg')
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	user_arousal = 2
	target_pleasure = 3
	target_arousal = 5

/datum/interaction/lewd/titgrope/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/reagent_containers/liquid_container
	var/list/original_messages = message.Copy()

	// Check for container
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		message = list("milks %TARGET%'s breasts into \the [liquid_container].")
		. = ..()
		message = original_messages
		return

	// Handle different intents
	switch(resolve_intent_name(user.combat_mode))
		if("harm")
			message = list(
				"aggressively gropes %TARGET%'s breast.",
				"grabs %TARGET%'s breasts.",
				"tightly squeezes %TARGET%'s breasts.",
				"slaps at %TARGET%'s breasts.",
				"gropes %TARGET%'s breasts roughly."
			)
		if("disarm")
			message = list(
				"playfully bats at %TARGET%'s breasts.",
				"teasingly gropes %TARGET%'s breasts.",
				"playfully squeezes %TARGET%'s breasts.",
				"mischievously fondles %TARGET%'s breasts.",
				"impishly teases %TARGET%'s nipples."
			)
		if("grab")
			message = list(
				"firmly grips %TARGET%'s breasts.",
				"possessively gropes %TARGET%'s breasts.",
				"eagerly kneads %TARGET%'s breasts.",
				"roughly fondles %TARGET%'s breasts.",
				"greedily squeezes %TARGET%'s breasts."
			)
	. = ..()
	message = original_messages

/datum/interaction/lewd/titgrope/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/reagent_containers/liquid_container

		var/obj/item/cached_item = user.get_active_held_item()
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item
		else
			cached_item = user.pulling
			if(istype(cached_item, /obj/item/reagent_containers))
				liquid_container = cached_item

		if(liquid_container)
			var/obj/item/organ/external/genital/breasts/breasts = target.get_organ_slot(ORGAN_SLOT_BREASTS)
			if(breasts?.internal_fluid_datum)
				// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
				var/milk_multiplier = 0.5
				if(breasts.internal_fluid_maximum > 0)
					milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

				var/transfer_amount = rand(1, 3 * milk_multiplier)
				var/datum/reagents/R = new(breasts.internal_fluid_maximum)
				breasts.transfer_internal_fluid(R, transfer_amount)
				R.trans_to(liquid_container, R.total_volume)
				qdel(R)

	// Handle arousal effects based on intent
	var/intent = resolve_intent_name(user.combat_mode)
	if(intent != "harm" && prob(5 + target.arousal))
		var/list/arousal_messages
		switch(intent)
			if("help")
				arousal_messages = list(
					"%TARGET% shivers in arousal.",
					"%TARGET% moans quietly.",
					"%TARGET% breathes out a soft moan.",
					"%TARGET% gasps.",
					"%TARGET% shudders softly.",
					"%TARGET% trembles as hands run across bare skin."
				)
			if("disarm")
				arousal_messages = list(
					"%TARGET% playfully squirms.",
					"%TARGET% lets out a teasing giggle.",
					"%TARGET% bites their lip.",
					"%TARGET% wiggles teasingly.",
					"%TARGET% gives a flirtatious gasp."
				)
			if("grab")
				arousal_messages = list(
					"%TARGET% moans eagerly.",
					"%TARGET% presses into the touch.",
					"%TARGET% lets out a wanting groan.",
					"%TARGET% quivers with excitement.",
					"%TARGET% shivers with anticipation."
				)

		if(arousal_messages)
			var/target_message = list(pick(arousal_messages))
			target.visible_message(span_lewd(replacetext(target_message, "%TARGET%", target)))

/datum/interaction/lewd/breastsmother
	name = "Breast Smother"
	description = "Smother them with your breasts."
	interaction_requires = list(
		INTERACTION_REQUIRE_TARGET_MOUTH
	)
	user_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	message = list(
		"presses their breasts against %TARGET%'s face",
		"smothers %TARGET%'s face with their tits",
		"forces %TARGET%'s face between their breasts",
		"pins %TARGET%'s head between their boobs"
	)
	user_messages = list(
		"You feel %TARGET%'s face pressed between your breasts",
		"You hold %TARGET%'s head against your chest",
		"You keep %TARGET%'s face buried in your cleavage"
	)
	target_messages = list(
		"Your face is pressed between %USER%'s breasts",
		"%USER%'s tits smother your face",
		"Your vision is filled with %USER%'s cleavage"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3

/datum/interaction/lewd/breastsmother/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob((user.dna.features["sexual_potency"] * 5) + 10))
		target.adjustOxyLoss(2)
		target.adjust_arousal(5)
		user.adjust_arousal(8)

/datum/interaction/lewd/do_boobjob
	name = "Give Boobjob"
	description = "Give them a boobjob."
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	user_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"cums all over %USER%'s breasts",
		"shoots their load onto %USER%'s tits",
		"covers %USER%'s chest in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"%TARGET% cums all over your breasts",
		"%TARGET% shoots their load onto your tits",
		"%TARGET% covers your chest in cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"You cum all over %USER%'s breasts",
		"You shoot your load onto %USER%'s tits",
		"You cover %USER%'s chest in cum"
	))
	message = list(
		"wraps their breasts around %TARGET%'s cock",
		"works %TARGET%'s shaft between their tits",
		"pleasures %TARGET% with their breasts",
		"squeezes their breasts around %TARGET%'s cock"
	)
	user_messages = list(
		"You feel %TARGET%'s cock throbbing between your breasts",
		"The warmth of %TARGET%'s shaft feels nice between your tits",
		"You squeeze your breasts around %TARGET%'s cock"
	)
	target_messages = list(
		"%USER%'s soft breasts squeeze your cock",
		"Your shaft slides between %USER%'s tits",
		"The softness of %USER%'s breasts feels amazing"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 4
	user_arousal = 4
	target_arousal = 6
