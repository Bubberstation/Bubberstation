/datum/interaction/lewd/nuts
	name = "Nuts to Face"
	description = "Put your balls in their face."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_TESTICLES = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = CLIMAX_TARGET_MOUTH)
	message = list(
		"grabs the back of %TARGET%'s head and pulls it into their crotch.",
		"jams their nutsack right into %TARGET%'s face.",
		"roughly grinds their fat nutsack into %TARGET%'s mouth.",
		"pulls out their saliva-covered nuts from %TARGET%'s violated mouth and then wipes off the slime onto their face.",
		"wedges a digit into the side of %TARGET%'s jaw and pries it open before using their other hand to shove their whole nutsack inside!",
		"stands with their groin inches away from %TARGET%'s face, then thrusting their hips forward and smothering %TARGET%'s whole face with their heavy ballsack."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	target_pleasure = 0
	user_arousal = 5
	target_arousal = 2

/datum/interaction/lewd/nut_smack
	name = "Smack Nuts"
	description = "Smack their nuts."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_TESTICLES = REQUIRE_GENITAL_EXPOSED)
	message = list(
		"smacks %TARGET%'s nuts!",
		"slaps %TARGET%'s balls!",
		"gives %TARGET%'s testicles a slap!",
		"whacks %TARGET% right in the nuts!"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/slap.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = -10
	target_pain = 15
	user_arousal = 2
	target_arousal = 0

/datum/interaction/lewd/nut_smack/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/original_pleasure = target_pleasure
	if(HAS_TRAIT(target, TRAIT_MASOCHISM))
		target_pleasure = abs(original_pleasure) * 1.5 // Masochists get 50% more pleasure from the pain
	. = ..()
	target_pleasure = original_pleasure
