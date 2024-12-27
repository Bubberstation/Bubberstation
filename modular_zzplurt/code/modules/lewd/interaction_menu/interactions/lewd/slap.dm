/datum/interaction/lewd/slap
	name = "Slap Ass"
	description = "Slap their ass."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_BUTT = REQUIRE_GENITAL_EXPOSED)
	message = list(
		"slaps %TARGET% right on the ass!",
		"spanks %TARGET%'s ass!",
		"gives %TARGET%'s behind a good smack!",
		"lands a stinging slap on %TARGET%'s butt!"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/slap.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	target_pain = 10
	user_arousal = 2
	target_arousal = 0

/datum/interaction/lewd/slap/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/original_pleasure = target_pleasure
	if(HAS_TRAIT(target, TRAIT_MASOCHISM))
		target_pleasure = 2
	. = ..()
	target_pleasure = original_pleasure
