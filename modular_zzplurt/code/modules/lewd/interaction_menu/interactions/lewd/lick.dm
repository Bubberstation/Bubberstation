/datum/interaction/lewd/rimjob
	name = "Rim"
	description = "Lick their ass."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_BOTH)
	message = list(
		"licks %TARGET%'s asshole.",
		"rims %TARGET% deeply.",
		"buries their tongue in %TARGET%'s ass.",
		"presses their tongue against %TARGET%'s pucker.",
		"gives %TARGET%'s ass a passionate licking."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 4
	user_arousal = 3
	target_arousal = 6

/datum/interaction/lewd/lickfeet
	name = "Lick Feet"
	description = "Lick their feet."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH, INTERACTION_REQUIRE_TARGET_FEET)
	message = list(
		"licks %TARGET%'s bare feet.",
		"runs their tongue along %TARGET%'s soles.",
		"laps at %TARGET%'s toes.",
		"tastes %TARGET%'s bare feet."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3

/datum/interaction/lewd/lickfeet/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()
	var/obj/item/clothing/shoes/shoes = target.get_item_by_slot(ITEM_SLOT_FEET)

	if(shoes)
		message = list(
			"licks %TARGET%'s [shoes.name].",
			"runs their tongue over %TARGET%'s [shoes.name].",
			"drags their tongue across %TARGET%'s [shoes.name].",
			"tastes %TARGET%'s [shoes.name]."
		)
	. = ..()
	message = original_messages

/datum/interaction/lewd/lick_sweat
	name = "Lick Sweat"
	description = "Lick their sweat."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	message = list(
		"licks the sweat off %TARGET%'s skin",
		"tastes %TARGET%'s salty sweat",
		"runs their tongue along %TARGET%'s sweaty body",
		"savors the taste of %TARGET%'s perspiration"
	)
	user_messages = list(
		"You taste %TARGET%'s salty sweat",
		"The tang of %TARGET%'s sweat fills your mouth",
		"You savor the salty taste of %TARGET%'s skin"
	)
	target_messages = list(
		"You feel %USER%'s tongue licking your sweat",
		"%USER%'s wet tongue slides across your sweaty skin",
		"The warmth of %USER%'s mouth tingles against your damp skin"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3

/datum/interaction/lewd/lick_nuts
	name = "Lick Balls"
	description = "Lick their balls."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_TESTICLES = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	message = list(
		"licks %TARGET%'s balls",
		"sucks on %TARGET%'s testicles",
		"tongues %TARGET%'s ballsack",
		"worships %TARGET%'s balls with their tongue"
	)
	user_messages = list(
		"You feel %TARGET%'s balls against your tongue",
		"The taste of %TARGET%'s sack fills your mouth",
		"You lavish attention on %TARGET%'s balls"
	)
	target_messages = list(
		"%USER%'s tongue works over your balls",
		"You feel %USER%'s hot mouth on your sack",
		"The warmth of %USER%'s tongue makes your balls tingle"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bj1.ogg',
		'modular_zzplurt/sound/interactions/bj2.ogg',
		'modular_zzplurt/sound/interactions/bj3.ogg',
		'modular_zzplurt/sound/interactions/bj4.ogg',
		'modular_zzplurt/sound/interactions/bj5.ogg',
		'modular_zzplurt/sound/interactions/bj6.ogg',
		'modular_zzplurt/sound/interactions/bj7.ogg',
		'modular_zzplurt/sound/interactions/bj8.ogg',
		'modular_zzplurt/sound/interactions/bj9.ogg',
		'modular_zzplurt/sound/interactions/bj10.ogg',
		'modular_zzplurt/sound/interactions/bj11.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 3
	user_arousal = 3
	target_arousal = 5
