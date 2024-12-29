/datum/interaction/lewd/armpit_fuck
	name = "Armpit Fuck"
	description = "Fuck their armpit."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_TOPLESS)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums all over %TARGET%'s armpit",
		"shoots their load into %TARGET%'s pit",
		"covers %TARGET%'s underarm in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum all over %TARGET%'s armpit",
		"You shoot your load into %TARGET%'s pit",
		"You cover %TARGET%'s underarm in cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums all over your armpit",
		"%USER% shoots their load into your pit",
		"%USER% covers your underarm in cum"
	))
	message = list(
		"fucks %TARGET%'s armpit",
		"slides their cock into %TARGET%'s underarm",
		"thrusts into %TARGET%'s pit",
		"pounds %TARGET%'s armpit"
	)
	user_messages = list(
		"You feel %TARGET%'s warm pit around your cock",
		"The softness of %TARGET%'s armpit feels good against your shaft",
		"%TARGET%'s underarm squeezes your cock nicely"
	)
	target_messages = list(
		"You feel %USER%'s cock rubbing in your armpit",
		"%USER%'s shaft slides against your underarm",
		"The warmth of %USER%'s cock presses into your pit"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	target_pleasure = 0
	user_arousal = 5
	target_arousal = 2

/datum/interaction/lewd/armpit_lick
	name = "Lick Armpit"
	description = "Lick their armpit."
	interaction_requires = list(
		INTERACTION_REQUIRE_SELF_MOUTH,
		INTERACTION_REQUIRE_TARGET_TOPLESS
	)
	message = list(
		"licks %TARGET%'s armpit",
		"runs their tongue along %TARGET%'s underarm",
		"tastes %TARGET%'s pit",
		"plants their face in %TARGET%'s armpit"
	)
	user_messages = list(
		"You taste %TARGET%'s armpit",
		"The scent of %TARGET%'s pit fills your nose",
		"You savor the taste of %TARGET%'s underarm"
	)
	target_messages = list(
		"You feel %USER%'s tongue in your armpit",
		"%USER%'s wet tongue slides across your pit",
		"The warmth of %USER%'s mouth tingles your underarm"
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

/datum/interaction/lewd/armpit_smother
	name = "Armpit Smother"
	description = "Press your armpit against their face."
	interaction_requires = list(
		INTERACTION_REQUIRE_TARGET_MOUTH,
		INTERACTION_REQUIRE_SELF_TOPLESS
	)
	message = list(
		"presses their armpit against %TARGET%'s face",
		"smothers %TARGET%'s face with their pit",
		"forces %TARGET%'s face into their underarm",
		"pins %TARGET%'s head under their arm"
	)
	user_messages = list(
		"You feel %TARGET%'s face pressed into your pit",
		"You hold %TARGET%'s head against your underarm",
		"You keep %TARGET%'s face buried in your armpit"
	)
	target_messages = list(
		"Your face is pressed into %USER%'s armpit",
		"%USER%'s underarm smothers your face",
		"Your nose fills with the scent of %USER%'s pit"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3

/datum/interaction/lewd/armpit_pitjob
	name = "Give Pitjob"
	description = "Jerk them off with your armpit."
	interaction_requires = list(
		INTERACTION_REQUIRE_SELF_TOPLESS
	)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"cums all over %USER%'s armpit",
		"shoots their load into %USER%'s pit",
		"covers %USER%'s underarm in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"%TARGET% cums all over your armpit",
		"%TARGET% shoots their load into your pit",
		"%TARGET% covers your underarm in cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"You cum all over %USER%'s armpit",
		"You shoot your load into %USER%'s pit",
		"You cover %USER%'s underarm in cum"
	))
	message = list(
		"works %TARGET%'s cock with their armpit",
		"squeezes %TARGET%'s shaft between their arm and chest",
		"jerks %TARGET% off with their pit",
		"pleasures %TARGET%'s cock with their underarm"
	)
	user_messages = list(
		"You feel %TARGET%'s cock throb in your armpit",
		"The warmth of %TARGET%'s shaft fills your pit",
		"You squeeze %TARGET%'s cock with your underarm"
	)
	target_messages = list(
		"%USER%'s warm pit strokes your cock",
		"Your shaft slides between %USER%'s arm and chest",
		"The softness of %USER%'s armpit feels amazing"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 3
	user_arousal = 2
	target_arousal = 5
