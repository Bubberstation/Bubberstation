/datum/interaction/lewd/titgrope_self
	name = "Grope Breasts (self)"
	description = "Grope your own breasts."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	user_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_ANY)
	usage = INTERACTION_SELF
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_BOTH)
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	message = list(
		"gently gropes their breast",
		"softly squeezes their breasts",
		"grips their breasts",
		"runs a few fingers over their breast",
		"delicately teases their nipple",
		"traces a touch across their breast"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/squelch1.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 2
	user_arousal = 3

/datum/interaction/lewd/titgrope_self/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(prob(5 + user.arousal))
		user.visible_message(span_lewd("<b>\The [user]</b> [pick(
			"shivers in arousal.",
			"moans quietly.",
			"breathes out a soft moan.",
			"gasps.",
			"shudders softly.",
			"trembles as their hands run across bare skin.")]"))

	var/obj/item/reagent_containers/liquid_container
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		var/obj/item/organ/external/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
		if(breasts?.internal_fluid_datum)
			// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
			var/milk_multiplier = 0.5
			if(breasts.internal_fluid_maximum > 0)
				milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

			var/transfer_amount = rand(1, 3 * milk_multiplier)
			var/datum/reagents/R = new(breasts.internal_fluid_maximum)
			breasts.transfer_internal_fluid(R, transfer_amount)
			R.trans_to(liquid_container, R.total_volume)
			qdel(R)

/datum/interaction/lewd/self_nipsuck
	name = "Suck Nipples (self)"
	description = "Suck your own nipples."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_MOUTH)
	user_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	usage = INTERACTION_SELF
	message = list(
		"brings their own milk tanks to their mouth and sucks deeply into them",
		"takes a big sip of their own fresh milk",
		"fills their own mouth with a big gulp of their warm milk"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/oral1.ogg',
		'modular_zzplurt/sound/interactions/oral2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	user_arousal = 5

/datum/interaction/lewd/self_nipsuck/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/obj/item/organ/external/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts?.internal_fluid_datum)
		// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
		var/milk_multiplier = 0.5
		if(breasts.internal_fluid_maximum > 0)
			milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

		var/transfer_amount = rand(1, 3 * milk_multiplier)
		var/datum/reagents/R = new(breasts.internal_fluid_maximum)
		breasts.transfer_internal_fluid(R, transfer_amount)
		R.trans_to(user, R.total_volume)
		qdel(R)

/datum/interaction/lewd/breastfuck_self
	name = "Breastfuck (self)"
	description = "Fuck your own breasts."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	user_required_parts = list(
		ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED,
		ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED
	)
	usage = INTERACTION_SELF
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums all over their own breasts",
		"shoots their load onto their tits",
		"covers their breasts in cum"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum all over your own breasts",
		"You shoot your load onto your tits",
		"You cover your breasts in cum"
	))
	message = list(
		"fucks their own breasts",
		"slides their cock between their breasts",
		"thrusts between their tits",
		"pleasures themself with their breasts"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	user_arousal = 6
