/datum/interaction/lewd/extreme/harmful/eyefuck
	name = "Eyefuck"
	description = "Fuck their eye."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums deep into %TARGET%'s eye",
		"shoots their load into %TARGET%'s eye socket",
		"fills %TARGET%'s eye with their cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum deep into %TARGET%'s eye",
		"You shoot your load into %TARGET%'s eye socket",
		"You fill %TARGET%'s eye with your cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums deep into your eye",
		"%USER% shoots their load into your eye socket",
		"%USER% fills your eye with their cum"
	))
	message = list(
		"pounds into %TARGET%'s eye.",
		"shoves their cock deep into %TARGET%'s skull",
		"thrusts in and out of %TARGET%'s eye.",
		"goes balls deep into %TARGET%'s cranium over and over again."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ1.ogg',
		'modular_zzplurt/sound/interactions/champ2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 5
	target_pleasure = 0
	user_arousal = 8
	target_arousal = 0
	target_pain = 15

/datum/interaction/lewd/extreme/harmful/eyefuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob(15))
		target.bleed(2)
	if(prob(25))
		target.adjustOrganLoss(ORGAN_SLOT_EYES, rand(3,7))
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))

/datum/interaction/lewd/extreme/harmful/eyesocketfuck
	name = "Eyesocketfuck"
	description = "Fuck their eyesocket."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums deep into %TARGET%'s empty eye socket",
		"shoots their load into %TARGET%'s skull",
		"fills %TARGET%'s eye socket with their cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum deep into %TARGET%'s empty eye socket",
		"You shoot your load into %TARGET%'s skull",
		"You fill %TARGET%'s eye socket with your cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums deep into your empty eye socket",
		"%USER% shoots their load into your skull",
		"%USER% fills your eye socket with their cum"
	))
	message = list(
		"pounds into %TARGET%'s eyesocket.",
		"shoves their cock deep into %TARGET%'s skull",
		"thrusts in and out of %TARGET%'s eyesocket.",
		"goes balls deep into %TARGET%'s cranium over and over again."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ1.ogg',
		'modular_zzplurt/sound/interactions/champ2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 5
	target_pleasure = 0
	user_arousal = 8
	target_arousal = 0
	target_pain = 15

/datum/interaction/lewd/extreme/harmful/eyesocketfuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob(15))
		target.bleed(2)
	if(prob(25))
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))
