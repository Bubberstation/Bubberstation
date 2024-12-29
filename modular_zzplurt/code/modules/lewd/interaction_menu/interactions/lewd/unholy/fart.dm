/datum/interaction/lewd/unholy/facefart
	name = "Face Fart"
	description = "Fart on their face."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_ANY)
	message = list(
		"presses their ass against %TARGET%'s face and lets out a fart",
		"releases gas right into %TARGET%'s face",
		"lets loose a nasty fart on %TARGET%'s face",
		"forces %TARGET% to smell their flatulence"
	)
	user_messages = list(
		"You feel relief as you release gas in %TARGET%'s face",
		"You let out a fart right on %TARGET%'s face",
		"You make %TARGET% smell your gas"
	)
	target_messages = list(
		"%USER% releases their gas right in your face",
		"You're forced to smell %USER%'s fart",
		"%USER%'s flatulence fills your nostrils"
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 2
	target_arousal = 2

/datum/interaction/lewd/unholy/facefart/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()

/datum/interaction/lewd/unholy/crotchfart
	name = "Crotch Fart"
	description = "Fart on their crotch."
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_ANY)
	message = list(
		"presses their ass against %TARGET%'s crotch and lets out a fart",
		"releases gas all over %TARGET%'s groin",
		"lets loose a nasty fart on %TARGET%'s genitals",
		"forces %TARGET% to feel their flatulence"
	)
	user_messages = list(
		"You feel relief as you release gas on %TARGET%'s crotch",
		"You let out a fart right on %TARGET%'s groin",
		"You make %TARGET% feel your gas"
	)
	target_messages = list(
		"%USER% releases their gas right on your crotch",
		"You feel %USER%'s fart on your groin",
		"%USER%'s flatulence washes over your genitals"
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 2
	user_arousal = 3
	target_arousal = 4

/datum/interaction/lewd/unholy/crotchfart/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()

/datum/interaction/lewd/unholy/fartfuck
	name = "Fart Fuck"
	description = "Fuck their ass + fart."
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
		"pounds %TARGET%'s ass while letting out farts",
		"releases gas while fucking %TARGET%'s hole",
		"farts with each thrust into %TARGET%'s ass",
		"fills %TARGET% with their flatulence while fucking them"
	)
	user_messages = list(
		"You feel relief as you release gas while fucking %TARGET%",
		"You let out farts as you pound %TARGET%'s ass",
		"You make %TARGET% feel your gas inside them"
	)
	target_messages = list(
		"%USER% releases their gas inside your ass",
		"You feel %USER%'s farts filling you up",
		"%USER%'s flatulence mingles with their thrusts"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 6
	target_pleasure = 4
	user_arousal = 8
	target_arousal = 6

/datum/interaction/lewd/unholy/fartfuck/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()

/datum/interaction/lewd/unholy/fartfuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	conditional_pref_sound(user, pick('modular_zzplurt/sound/interactions/bang1.ogg',
						'modular_zzplurt/sound/interactions/bang2.ogg',
						'modular_zzplurt/sound/interactions/bang3.ogg'), 80, TRUE, falloff_distance = sound_range, pref_to_check = /datum/preference/toggle/erp/sounds)

/datum/interaction/lewd/unholy/suck_fart
	name = "Suck Fart"
	description = "Suck the farts out of their asshole."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(
		CLIMAX_POSITION_TARGET = CLIMAX_BOTH
	)
	message = list(
		"presses their face between %TARGET%'s asscheeks and inhales their farts",
		"sucks the gas right out of %TARGET%'s ass",
		"breathes in %TARGET%'s flatulence deeply",
		"puts their mouth on %TARGET%'s hole to taste their gas"
	)
	user_messages = list(
		"You inhale %TARGET%'s farts directly from the source",
		"You suck the gas from %TARGET%'s asshole",
		"You taste %TARGET%'s flatulence on your tongue"
	)
	target_messages = list(
		"%USER% sucks your farts right out of your ass",
		"You feel %USER%'s mouth pulling gas from your hole",
		"%USER% inhales your flatulence eagerly"
	)
	sound_possible = list()
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 3
	user_arousal = 4
	target_arousal = 5

/datum/interaction/lewd/unholy/suck_fart/New()
	sound_possible = GLOB.brap_noises // GLOB.brap_noises: expected a constant expression
	. = ..()
