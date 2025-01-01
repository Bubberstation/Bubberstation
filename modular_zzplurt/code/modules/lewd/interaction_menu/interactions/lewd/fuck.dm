/datum/interaction/lewd/fuck
	name = "Fuck"
	description = "Fuck their pussy."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS, CLIMAX_POSITION_TARGET = CLIMAX_VAGINA)
	cum_target = list(CLIMAX_POSITION_USER = ORGAN_SLOT_VAGINA, CLIMAX_POSITION_TARGET = ORGAN_SLOT_PENIS)
	message = list(
		"pounds %TARGET%'s pussy.",
		"shoves their cock deep into %TARGET%'s pussy.",
		"thrusts in and out of %TARGET%'s cunt.",
		"goes balls deep into %TARGET%'s pussy over and over again."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ1.ogg',
		'modular_zzplurt/sound/interactions/champ2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 8
	target_pleasure = 8
	user_arousal = 12
	target_arousal = 12

/datum/interaction/lewd/fuck/anal
	name = "Anal Fuck"
	description = "Fuck their ass."
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS, CLIMAX_POSITION_TARGET = CLIMAX_BOTH)
	cum_target = list(CLIMAX_POSITION_USER = ORGAN_SLOT_ANUS, CLIMAX_POSITION_TARGET = ORGAN_SLOT_PENIS)
	message = list(
		"thrusts in and out of %TARGET%'s ass.",
		"pounds %TARGET%'s ass.",
		"slams their hips up against %TARGET%'s ass hard.",
		"goes balls deep into %TARGET%'s ass over and over again."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_use = TRUE
	user_pleasure = 8
	target_pleasure = 4
	user_arousal = 12
	target_arousal = 8
	target_pain = 3

/datum/interaction/lewd/breastfuck
	name = "Breast Fuck"
	description = "Fuck their breasts."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = ORGAN_SLOT_BREASTS)
	message = list(
		"fucks %TARGET%'s breasts.",
		"grinds their cock between %TARGET%'s boobs.",
		"thrusts into %TARGET%'s tits.",
		"grabs %TARGET%'s breasts together and presses their cock between them."
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
	user_arousal = 8
	target_arousal = 3

/datum/interaction/lewd/footfuck
	name = "Foot Fuck"
	description = "Rub your cock on their foot."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_FEET)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"cums all over %TARGET%'s foot.",
			"shoots their load on %TARGET%'s sole.",
			"covers %TARGET%'s toes in cum."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"you cum all over %TARGET%'s foot.",
			"you shoot your load on %TARGET%'s sole.",
			"you cover %TARGET%'s toes in cum."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"%USER% cums all over your foot.",
			"%USER% shoots their load on your sole.",
			"%USER% covers your toes in cum."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	message = list(
		"fucks %TARGET%'s foot.",
		"rubs their cock on %TARGET%'s foot.",
		"grinds their cock on %TARGET%'s foot."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/foot_dry1.ogg',
		'modular_zzplurt/sound/interactions/foot_dry3.ogg',
		'modular_zzplurt/sound/interactions/foot_wet1.ogg',
		'modular_zzplurt/sound/interactions/foot_wet2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	target_pleasure = 0
	user_arousal = 6
	target_arousal = 2

/datum/interaction/lewd/footfuck/double
	name = "Double Foot Fuck"
	description = "Rub your cock between their feet."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_FEET)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"cums all over %TARGET%'s feet.",
			"shoots their load on %TARGET%'s soles.",
			"covers %TARGET%'s toes in cum."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"you cum all over %TARGET%'s feet.",
			"you shoot your load on %TARGET%'s soles.",
			"you cover %TARGET%'s toes in cum."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"%USER% cums all over your feet.",
			"%USER% shoots their load on your soles.",
			"%USER% covers your toes in cum."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	message = list(
		"fucks %TARGET%'s feet.",
		"rubs their cock between %TARGET%'s feet.",
		"thrusts their cock between %TARGET%'s feet.",
		"grinds their cock between %TARGET%'s feet."
	)
	user_arousal = 15
	target_arousal = 5

/datum/interaction/lewd/footfuck/vag
	name = "Vaginal Foot Grind"
	description = "Rub your vagina on their foot."
	user_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_VAGINA)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"squirts all over %TARGET%'s foot.",
			"orgasms on %TARGET%'s sole.",
			"coats %TARGET%'s toes with their juices."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"you squirt all over %TARGET%'s foot.",
			"you orgasm on %TARGET%'s sole.",
			"you coat %TARGET%'s toes with your juices."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"%USER% squirts all over your foot.",
			"%USER% orgasms on your sole.",
			"%USER% coats your toes with their juices."
		),
		CLIMAX_POSITION_TARGET = list()
	)
	message = list(
		"grinds their pussy against %TARGET%'s foot.",
		"rubs their clit on %TARGET%'s foot.",
		"ruts on %TARGET%'s foot."
	)
	sound_use = TRUE
	user_pleasure = 15
	target_pleasure = 0
	user_arousal = 20
	target_arousal = 5

/datum/interaction/lewd/cockfuck
	name = "Cockfuck"
	description = "Fuck their cock."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(
		CLIMAX_POSITION_USER = CLIMAX_PENIS,
		CLIMAX_POSITION_TARGET = CLIMAX_PENIS
	)
	cum_target = list(
		CLIMAX_POSITION_USER = ORGAN_SLOT_PENIS,
		CLIMAX_POSITION_TARGET = ORGAN_SLOT_PENIS
	)
	message = list(
		"pushes their cock into %TARGET%'s urethra",
		"penetrates %TARGET%'s cock with their own",
		"thrusts deep into %TARGET%'s cockhole",
		"fucks %TARGET%'s cock from the inside"
	)
	user_messages = list(
		"You feel %TARGET%'s cock squeezing around yours",
		"The warmth of %TARGET%'s urethra envelops your shaft",
		"%TARGET%'s cock tightens around yours as you thrust deeper"
	)
	target_messages = list(
		"You feel %USER%'s cock stretching your urethra",
		"%USER%'s shaft pushes deep inside your cock",
		"The warmth of %USER%'s cock fills your shaft from within"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 6
	target_pleasure = 6
	user_arousal = 8
	target_arousal = 8
	target_pain = 4
