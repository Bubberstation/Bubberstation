/datum/interaction/lewd/kiss
	name = "Kiss"
	description = "Kiss them deeply."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH, INTERACTION_REQUIRE_TARGET_MOUTH)
	message = list(
		"gives an intense, lingering kiss to %TARGET%.",
		"kisses %TARGET% deeply.",
		"slides their tongue into %TARGET%'s mouth.",
		"presses their lips against %TARGET%'s.",
		"gives %TARGET% a passionate kiss."
	)
	user_messages = list(
		"You feel %TARGET%'s warm lips against yours.",
		"Your tongue dances with %TARGET%'s.",
		"The taste of %TARGET%'s mouth lingers on your lips."
	)
	target_messages = list(
		"%USER%'s tongue explores your mouth.",
		"You feel %USER%'s lips press against yours.",
		"The warmth of %USER%'s kiss sends shivers down your spine."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/kiss1.ogg',
		'modular_zzplurt/sound/interactions/kiss2.ogg',
		'modular_zzplurt/sound/interactions/kiss3.ogg',
		'modular_zzplurt/sound/interactions/kiss4.ogg',
		'modular_zzplurt/sound/interactions/kiss5.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 2
	target_arousal = 2

/datum/interaction/lewd/kiss/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	
	// Check if user has TRAIT_KISS_SLUT and increase their lust
	if(HAS_TRAIT(user, TRAIT_KISS_SLUT))
		user.adjust_pleasure(10, target, interaction = src, position = CLIMAX_POSITION_USER)
		user.adjust_arousal(10)
	// Check if target has TRAIT_KISS_SLUT and increase their lust
	if(HAS_TRAIT(target, TRAIT_KISS_SLUT))
		target.adjust_pleasure(10, user, interaction = src, position = CLIMAX_POSITION_TARGET)
		target.adjust_arousal(10)
