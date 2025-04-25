/datum/interaction/lewd/bellyfuck
	name = "Bellyfuck"
	description = "Fuck their belly."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_TOPLESS)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums all over %TARGET%'s belly",
		"shoots their load onto %TARGET%'s stomach",
		"covers %TARGET%'s navel in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum all over %TARGET%'s belly",
		"You shoot your load onto %TARGET%'s stomach",
		"You cover %TARGET%'s navel in cum"
	))
	cum_partner_text_overrides = list(CLIMAX_POSITION_USER = list(
		"%USER% cums all over your belly",
		"%USER% shoots their load onto your stomach",
		"%USER% covers your navel in cum"
	))
	message = list(
		"rubs their cock against %TARGET%'s belly",
		"fucks %TARGET%'s navel",
		"grinds their cock on %TARGET%'s stomach",
		"thrusts against %TARGET%'s belly"
	)
	user_messages = list(
		"You feel %TARGET%'s warm skin against your cock",
		"The softness of %TARGET%'s belly feels good against your shaft",
		"%TARGET%'s belly feels amazing against your cock"
	)
	target_messages = list(
		"You feel %USER%'s cock rubbing against your belly",
		"%USER%'s shaft slides across your stomach",
		"The warmth of %USER%'s cock presses against your navel"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	target_pleasure = 0
	user_arousal = 5
	target_arousal = 2

/datum/interaction/lewd/nuzzle_belly
	name = "Nuzzle Belly"
	description = "Nuzzle their belly."
	interaction_requires = list(INTERACTION_REQUIRE_TARGET_TOPLESS)
	message = list(
		"nuzzles %TARGET%'s belly",
		"rubs their face against %TARGET%'s stomach",
		"presses their cheek to %TARGET%'s navel",
		"snuggles against %TARGET%'s tummy"
	)
	user_messages = list(
		"You feel %TARGET%'s warm skin against your face",
		"The softness of %TARGET%'s belly feels nice against your cheek",
		"%TARGET%'s stomach is warm and inviting"
	)
	target_messages = list(
		"You feel %USER%'s face nuzzling your belly",
		"%USER%'s cheek rubs softly against your stomach",
		"The warmth of %USER%'s face presses against your navel"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 2
	target_arousal = 3

/datum/interaction/lewd/deflate_belly
	name = "Deflate Belly"
	description = "Deflate belly."
	user_required_parts = list(ORGAN_SLOT_BELLY = REQUIRE_GENITAL_ANY)
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HUMAN)
	usage = INTERACTION_SELF
	message = list(
		"deflates their belly",
		"lets out air from their belly",
		"makes their belly smaller"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	user_arousal = 0

/datum/interaction/lewd/deflate_belly/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/obj/item/organ/genital/belly/gut = user.get_organ_slot(ORGAN_SLOT_BELLY)
	if(gut)
		gut.set_size(gut.genital_size - 1)
		user.update_body()

/datum/interaction/lewd/inflate_belly
	name = "Inflate Belly"
	description = "Inflate belly."
	user_required_parts = list(ORGAN_SLOT_BELLY = REQUIRE_GENITAL_ANY)
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HUMAN)
	usage = INTERACTION_SELF
	message = list(
		"inflates their belly",
		"makes their belly bigger",
		"expands their belly"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	user_arousal = 0

/datum/interaction/lewd/inflate_belly/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/obj/item/organ/genital/belly/gut = user.get_organ_slot(ORGAN_SLOT_BELLY)
	if(gut)
		gut.set_size(gut.genital_size + 1)
		user.update_body()
