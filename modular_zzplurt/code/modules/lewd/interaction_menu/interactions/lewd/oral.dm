/datum/interaction/lewd/oral_vagina
	name = "Perform Oral"
	description = "Go down on them."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_VAGINA)
	cum_target = list(CLIMAX_POSITION_TARGET = CLIMAX_TARGET_MOUTH)
	message = list(
		"buries their face in %TARGET%'s pussy.",
		"nuzzles %TARGET%'s wet sex.",
		"finds their face caught between %TARGET%'s thighs.",
		"kneels down between %TARGET%'s legs.",
		"grips %TARGET%'s legs, pushing them apart.",
		"sinks their face in between %TARGET%'s thighs."
	)
	user_messages = list(
		"You feel %TARGET%'s warm wetness against your face.",
		"The scent of %TARGET%'s arousal fills your senses.",
		"You press your tongue deeper into %TARGET%'s folds."
	)
	target_messages = list(
		"%USER%'s tongue explores your pussy.",
		"You feel %USER%'s hot breath against your sex.",
		"The warmth of %USER%'s mouth sends shivers up your spine."
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
	target_pleasure = 5
	user_arousal = 3
	target_arousal = 7

/datum/interaction/lewd/oral_penis
	name = "Suck Cock"
	description = "Suck them off."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_TARGET = CLIMAX_TARGET_MOUTH)
	message = list(
		"takes %TARGET%'s cock into their mouth.",
		"wraps their lips around %TARGET%'s cock.",
		"finds their face between %TARGET%'s thighs.",
		"kneels down between %TARGET%'s legs.",
		"grips %TARGET%'s legs, kissing at the tip of their cock.",
		"goes down on %TARGET%."
	)
	user_messages = list(
		"You feel %TARGET%'s cock throb in your mouth.",
		"The taste of %TARGET%'s precum lingers on your tongue.",
		"You take %TARGET% deeper into your throat."
	)
	target_messages = list(
		"%USER%'s tongue swirls around your cock.",
		"You feel %USER%'s hot mouth envelope you.",
		"The warmth of %USER%'s throat makes you twitch."
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
	target_pleasure = 5
	user_arousal = 3
	target_arousal = 7

/datum/interaction/lewd/oral_penis/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob((target.dna.features["sexual_potency"] * 10) + 15))
		user.adjustOxyLoss(3)
		target.adjust_arousal(10)
		target.adjust_pleasure(10, user, interaction = src, position = CLIMAX_POSITION_TARGET)
