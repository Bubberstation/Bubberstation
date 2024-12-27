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
