/datum/interaction/lewd/facefuck_vagina
	name = "Facefuck (Vagina)"
	description = "Grind your pussy against their face."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_VAGINA)
	cum_target = list(CLIMAX_POSITION_USER = CLIMAX_TARGET_MOUTH)
	message = list(
		"grinds their pussy into %TARGET%'s face.",
		"grips the back of %TARGET%'s head, forcing them onto their pussy.",
		"rolls their pussy against %TARGET%'s tongue.",
		"slides %TARGET%'s mouth between their legs.",
		"looks %TARGET% in the eyes as their pussy presses into a waiting tongue.",
		"sways their hips, pushing their sex into %TARGET%'s face."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 5
	user_arousal = 8
	target_pleasure = 0
	target_arousal = 3

/datum/interaction/lewd/facefuck_penis
	name = "Facefuck (Penis)"
	description = "Fuck their mouth with your cock."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = CLIMAX_TARGET_MOUTH)
	message = list(
		"roughly fucks %TARGET%'s mouth.",
		"forces their cock down %TARGET%'s throat.",
		"pushes in against %TARGET%'s tongue until a tight gagging sound comes.",
		"grips %TARGET%'s hair and draws them to the base of their cock.",
		"looks %TARGET% in the eyes as their cock presses into a waiting tongue.",
		"rolls their hips hard, sinking into %TARGET%'s mouth."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 5
	target_pleasure = 0
	user_arousal = 8
	target_arousal = 3

/datum/interaction/lewd/throatfuck
	name = "Throatfuck"
	description = "Fuck their throat. (Warning: Causes oxygen damage)"
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_MOUTH)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_USER = CLIMAX_TARGET_MOUTH)
	message = list(
		"brutally shoves their cock into %TARGET%'s throat to make them gag.",
		"chokes %TARGET% on their cock, going in balls deep.",
		"slams in and out of %TARGET%'s mouth, their balls slapping off their face."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 7
	target_pleasure = 0
	user_arousal = 10
	target_arousal = 2
	target_pain = 5

/datum/interaction/lewd/throatfuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/stat_before = target.stat
	target.adjustOxyLoss(3)
	if(target.stat == UNCONSCIOUS && stat_before != UNCONSCIOUS)
		message = list("%TARGET% passes out on %USER%'s cock.")
