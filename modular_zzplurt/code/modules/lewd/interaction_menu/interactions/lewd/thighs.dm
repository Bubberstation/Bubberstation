/datum/interaction/lewd/thighs_penis
	name = "Thigh Smother (Penis)"
	description = "Smother them with your penis."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = CLIMAX_TARGET_MOUTH)
	message = list(
		"presses their weight down onto %TARGET%'s face, blocking their vision completely.",
		"forces their cock into %TARGET%'s face as they're stuck locked between their thighs.",
		"slips their cock into %TARGET%'s helpless mouth, keeping their shaft pressed hard into their face."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bj10.ogg',
		'modular_zzplurt/sound/interactions/bj3.ogg',
		'modular_zzplurt/sound/interactions/foot_wet1.ogg',
		'modular_zzplurt/sound/interactions/foot_dry3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	target_pleasure = 0
	user_arousal = 6
	target_arousal = 2

/datum/interaction/lewd/thighs_vagina
	name = "Thigh Smother (Vagina)"
	description = "Smother them with your pussy."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_VAGINA)
	cum_target = list(CLIMAX_POSITION_USER = CLIMAX_TARGET_MOUTH)
	message = list(
		"presses their weight down onto %TARGET%'s face, blocking their vision completely.",
		"rides %TARGET%'s face, grinding their wet pussy all over it.",
		"grinds their pussy into %TARGET%'s face."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bj10.ogg',
		'modular_zzplurt/sound/interactions/bj3.ogg',
		'modular_zzplurt/sound/interactions/foot_wet1.ogg',
		'modular_zzplurt/sound/interactions/foot_dry3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	target_pleasure = 0
	user_arousal = 6
	target_arousal = 2

/datum/interaction/lewd/thighfuck
	name = "Thighfuck"
	description = "Fuck their thighs."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_BOTTOMLESS)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums all over %TARGET%'s thighs",
		"shoots their load onto %TARGET%'s legs",
		"covers %TARGET%'s thighs in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum all over %TARGET%'s thighs",
		"You shoot your load onto %TARGET%'s legs",
		"You cover %TARGET%'s thighs in cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums all over your thighs",
		"%USER% shoots their load onto your legs",
		"%USER% covers your thighs in cum"
	))
	message = list(
		"fucks %TARGET%'s thighs",
		"slides their cock between %TARGET%'s legs",
		"thrusts between %TARGET%'s thighs",
		"pounds against %TARGET%'s legs"
	)
	user_messages = list(
		"You feel %TARGET%'s thighs squeezing your cock",
		"The warmth between %TARGET%'s legs feels amazing",
		"%TARGET%'s soft thighs feel great around your shaft"
	)
	target_messages = list(
		"You feel %USER%'s cock sliding between your thighs",
		"%USER%'s shaft rubs between your legs",
		"The warmth of %USER%'s cock presses against your thighs"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	target_pleasure = 0
	user_arousal = 6
	target_arousal = 4

/datum/interaction/lewd/thighjob
	name = "Give Thighjob"
	description = "Pleasure them with your thighs."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_BOTTOMLESS)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"cums all over %USER%'s thighs",
		"shoots their load onto %USER%'s legs",
		"covers %USER%'s thighs in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"%TARGET% cums all over your thighs",
		"%TARGET% shoots their load onto your legs",
		"%TARGET% covers your thighs in cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_TARGET = list(
		"You cum all over %USER%'s thighs",
		"You shoot your load onto %USER%'s legs",
		"You cover %USER%'s thighs in cum"
	))
	message = list(
		"squeezes %TARGET%'s cock between their thighs",
		"works %TARGET%'s shaft with their legs",
		"pleasures %TARGET% with their thighs",
		"rubs %TARGET%'s cock between their legs"
	)
	user_messages = list(
		"You feel %TARGET%'s cock throbbing between your thighs",
		"The warmth of %TARGET%'s shaft feels nice between your legs",
		"You squeeze %TARGET%'s cock with your thighs"
	)
	target_messages = list(
		"%USER%'s warm thighs squeeze your cock",
		"Your shaft slides between %USER%'s legs",
		"The softness of %USER%'s thighs feels amazing"
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
