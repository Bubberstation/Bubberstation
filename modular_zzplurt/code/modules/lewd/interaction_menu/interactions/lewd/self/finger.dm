/datum/interaction/lewd/finger_self_vagina
	name = "Finger Pussy (self)"
	description = "Finger your own pussy."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	user_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	usage = INTERACTION_SELF
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_VAGINA)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums hard on their fingers",
		"shudders as they cum on their hand",
		"fingers themself to climax"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum hard on your fingers",
		"You shudder as you cum on your hand",
		"You finger yourself to climax"
	))
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	message = list(
		"fingers their pussy deep",
		"fingers their pussy",
		"plays with their pussy",
		"fingers their own pussy hard"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	user_arousal = 6

/datum/interaction/lewd/finger_self_vagina/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		var/list/original_messages = message.Copy()
		var/chosen_message = pick(message)
		message = list("[chosen_message] over \the [liquid_container]")
		interaction_modifier_flags |= INTERACTION_OVERRIDE_FLUID_TRANSFER
		. = ..()
		interaction_modifier_flags &= ~INTERACTION_OVERRIDE_FLUID_TRANSFER
		message = original_messages
	else
		. = ..()

/datum/interaction/lewd/finger_self_vagina/post_climax(mob/living/carbon/human/user, mob/living/carbon/human/target, position)
	var/obj/item/reagent_containers/liquid_container
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		var/obj/item/organ/external/genital/vagina/vagina = user.get_organ_slot(ORGAN_SLOT_VAGINA)
		if(vagina?.internal_fluid_datum)
			var/datum/reagents/R = new(vagina.internal_fluid_maximum)
			vagina.transfer_internal_fluid(R, vagina.internal_fluid_count)
			R.trans_to(liquid_container, R.total_volume)
			qdel(R)
	. = ..()

/datum/interaction/lewd/finger_self_anus
	name = "Finger Ass (self)"
	description = "Finger your own ass."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	user_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	usage = INTERACTION_SELF
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_BOTH)
	message = list(
		"fingers themself",
		"fingers their asshole",
		"fingers themself hard"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 3
	user_arousal = 5
