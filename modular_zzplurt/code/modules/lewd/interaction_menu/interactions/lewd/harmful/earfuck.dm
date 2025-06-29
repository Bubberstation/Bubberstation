/datum/interaction/lewd/extreme/harmful/earfuck
	name = "Earfuck"
	description = "Fuck their ear."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums deep into %TARGET%'s ear",
		"shoots their load into %TARGET%'s ear canal",
		"fills %TARGET%'s ear with their cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum deep into %TARGET%'s ear",
		"You shoot your load into %TARGET%'s ear canal",
		"You fill %TARGET%'s ear with your cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums deep into your ear",
		"%USER% shoots their load into your ear canal",
		"%USER% fills your ear with their cum"
	))
	message = list(
		"pounds into %TARGET%'s ear.",
		"shoves their cock deep into %TARGET%'s skull",
		"thrusts in and out of %TARGET%'s ear.",
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

/datum/interaction/lewd/extreme/harmful/earfuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob(15))
		target.bleed(2)
	if(prob(25))
		target.adjustOrganLoss(ORGAN_SLOT_EARS, rand(3,7))
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))

/datum/interaction/lewd/extreme/harmful/earsocketfuck
	name = "Earsocketfuck"
	description = "Fuck their earsocket."
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums deep into %TARGET%'s empty ear socket",
		"shoots their load into %TARGET%'s skull",
		"fills %TARGET%'s ear socket with their cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum deep into %TARGET%'s empty ear socket",
		"You shoot your load into %TARGET%'s skull",
		"You fill %TARGET%'s ear socket with your cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums deep into your empty ear socket",
		"%USER% shoots their load into your skull",
		"%USER% fills your ear socket with their cum"
	))
	message = list(
		"pounds into %TARGET%'s earsocket.",
		"shoves their cock deep into %TARGET%'s skull",
		"thrusts in and out of %TARGET%'s earsocket.",
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

/datum/interaction/lewd/extreme/harmful/earsocketfuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob(15))
		target.bleed(2)
	if(prob(25))
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))
