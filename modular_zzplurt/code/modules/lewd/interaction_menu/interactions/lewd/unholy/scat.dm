/datum/interaction/lewd/unholy/faceshit
	name = "Face Shit"
	description = "Shit on their face."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_ANY)
	message = list(
		"squats over %TARGET%'s face and releases their bowels",
		"defecates right onto %TARGET%'s face",
		"lets loose their filth on %TARGET%'s face",
		"forces %TARGET% to experience their mess"
	)
	user_messages = list(
		"You feel relief as you release onto %TARGET%'s face",
		"You empty your bowels on %TARGET%'s face",
		"You make %TARGET% deal with your mess"
	)
	target_messages = list(
		"%USER% releases their filth right on your face",
		"You're forced to experience %USER%'s mess",
		"%USER%'s waste covers your face"
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 2
	target_arousal = 2

/datum/interaction/lewd/unholy/faceshit/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()

/datum/interaction/lewd/unholy/crotchshit
	name = "Crotch Shit"
	description = "Shit on their crotch."
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_ANY)
	message = list(
		"squats over %TARGET%'s crotch and releases their bowels",
		"defecates all over %TARGET%'s groin",
		"lets loose their filth on %TARGET%'s genitals",
		"forces %TARGET% to feel their mess"
	)
	user_messages = list(
		"You feel relief as you release onto %TARGET%'s crotch",
		"You empty your bowels on %TARGET%'s groin",
		"You make %TARGET% deal with your mess"
	)
	target_messages = list(
		"%USER% releases their filth right on your crotch",
		"You feel %USER%'s mess on your groin",
		"%USER%'s waste covers your genitals"
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 2
	target_arousal = 2

/datum/interaction/lewd/unholy/crotchshit/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()

/datum/interaction/lewd/unholy/shitfuck
	name = "Shit Fuck"
	description = "Fuck their ass + shit."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(
		CLIMAX_POSITION_USER = CLIMAX_PENIS,
		CLIMAX_POSITION_TARGET = CLIMAX_BOTH
	)
	cum_target = list(
		CLIMAX_POSITION_USER = ORGAN_SLOT_ANUS
	)
	message = list(
		"pounds %TARGET%'s ass while they release their bowels",
		"fucks %TARGET%'s hole as they defecate",
		"thrusts into %TARGET%'s ass as they make a mess",
		"fills %TARGET% with their cock while they empty themselves"
	)
	user_messages = list(
		"You feel %TARGET% releasing as you fuck them",
		"You pound %TARGET%'s ass as they make a mess",
		"You make %TARGET% feel full while they empty themselves"
	)
	target_messages = list(
		"You release your bowels as %USER% fucks you",
		"You feel %USER%'s cock while you make a mess",
		"You empty yourself as %USER% fills you up"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 6
	target_pleasure = 4
	user_arousal = 8
	target_arousal = 6

/datum/interaction/lewd/unholy/shitfuck/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()

/datum/interaction/lewd/unholy/shitfuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	conditional_pref_sound(user, pick('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg'), 80, TRUE, falloff_distance = sound_range, pref_to_check = /datum/preference/toggle/erp/sounds)

/datum/interaction/lewd/unholy/suck_shit
	name = "Suck Shit"
	description = "Suck the shit out of their asshole."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(
		CLIMAX_POSITION_TARGET = CLIMAX_BOTH
	)
	message = list(
		"presses their face between %TARGET%'s asscheeks and sucks out their filth",
		"eagerly consumes %TARGET%'s mess directly from the source",
		"feeds on %TARGET%'s waste eagerly",
		"puts their mouth on %TARGET%'s hole to taste their mess"
	)
	user_messages = list(
		"You consume %TARGET%'s waste directly from the source",
		"You suck the filth from %TARGET%'s asshole",
		"You taste %TARGET%'s mess on your tongue"
	)
	target_messages = list(
		"%USER% sucks your waste right out of your ass",
		"You feel %USER%'s mouth pulling your mess from your hole",
		"%USER% eagerly consumes your waste"
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 3
	user_arousal = 4
	target_arousal = 5

/datum/interaction/lewd/unholy/suck_shit/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()
