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
	target_pleasure = 0

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
	var/obj/item/organ/external/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts?.internal_fluid_datum)
		// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
		var/milk_multiplier = 0.5
		if(breasts.internal_fluid_maximum > 0)
			milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

		var/transfer_amount = rand(1, 3 * milk_multiplier)
		target.reagents.add_reagent(breasts.internal_fluid_datum, transfer_amount)
		breasts.internal_fluid_count = max(0, breasts.internal_fluid_count - transfer_amount)
	. = ..()

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
	target_pleasure = 3

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
				liquid_container.reagents.add_reagent(breasts.internal_fluid_datum, transfer_amount)
				breasts.internal_fluid_count = max(0, breasts.internal_fluid_count - transfer_amount)

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
			message = list(pick(arousal_messages))
			. = ..()
			if(target.arousal < 5)
				target.adjust_arousal(5)
			return
	. = ..()
