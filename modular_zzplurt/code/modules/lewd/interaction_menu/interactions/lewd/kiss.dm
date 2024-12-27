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

/datum/interaction/lewd/kiss/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.arousal < 5)
		user.adjust_arousal(5)
	if(target.arousal < 5)
		target.adjust_arousal(5)
	. = ..()
