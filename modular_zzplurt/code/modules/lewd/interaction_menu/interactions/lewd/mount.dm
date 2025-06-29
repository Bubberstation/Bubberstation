/datum/interaction/lewd/mount_vagina
	name = "Mount (Vagina)"
	description = "Mount them with your pussy."
	user_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_VAGINA, CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = ORGAN_SLOT_PENIS, CLIMAX_POSITION_TARGET = ORGAN_SLOT_VAGINA)
	message = list(
		"rides %TARGET%'s cock.",
		"forces %TARGET%'s cock into their pussy.",
		"slides their pussy onto %TARGET%'s cock.",
		"impales themself on %TARGET%'s cock."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 7
	target_pleasure = 7
	user_arousal = 10
	target_arousal = 10

/datum/interaction/lewd/mount_anus
	name = "Mount (Anus)"
	description = "Mount them with your ass."
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_BOTH, CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = null, CLIMAX_POSITION_TARGET = ORGAN_SLOT_ANUS)
	message = list(
		"rides %TARGET%'s cock with their ass.",
		"forces %TARGET%'s cock into their ass.",
		"slides their ass onto %TARGET%'s cock.",
		"impales their ass on %TARGET%'s cock."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	target_pleasure = 7
	user_arousal = 8
	target_arousal = 10
	user_pain = 3

/datum/interaction/lewd/mount_face
	name = "Mount Face"
	description = "Sit on their face."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	message = list(
		"grinds their ass into %TARGET%'s face.",
		"shoves their ass into %TARGET%'s face.",
		"plants their ass right on %TARGET%'s face.",
		"grabs the back of %TARGET%'s head and forces it into their asscheeks."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/squelch1.ogg',
		'modular_zzplurt/sound/interactions/squelch2.ogg',
		'modular_zzplurt/sound/interactions/squelch3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	target_pleasure = 0
	user_arousal = 5
	target_arousal = 3
