/datum/interaction/lewd/nipplefuck
	name = "Nipplefuck"
	description = "Fuck their nipple."
	interaction_requires = list(
		INTERACTION_REQUIRE_TARGET_TOPLESS
	)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums all over %TARGET%'s nipple",
		"shoots their load into %TARGET%'s breast",
		"fills %TARGET%'s nipple with cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum all over %TARGET%'s nipple",
		"You shoot your load into %TARGET%'s breast",
		"You fill %TARGET%'s nipple with cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums all over your nipple",
		"%USER% shoots their load into your breast",
		"%USER% fills your nipple with cum"
	))
	message = list(
		"fucks %TARGET%'s nipple",
		"slides their cock into %TARGET%'s breast",
		"pounds %TARGET%'s nipple",
		"thrusts deep into %TARGET%'s nipple"
	)
	user_messages = list(
		"You feel %TARGET%'s nipple squeezing your cock",
		"The warmth of %TARGET%'s breast envelops your shaft",
		"%TARGET%'s nipple feels amazing around your cock"
	)
	target_messages = list(
		"You feel %USER%'s cock stretching your nipple",
		"%USER%'s shaft pushes deep into your breast",
		"The warmth of %USER%'s cock fills your nipple"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	target_pleasure = 2
	user_arousal = 6
	target_arousal = 4
	target_pain = 2
