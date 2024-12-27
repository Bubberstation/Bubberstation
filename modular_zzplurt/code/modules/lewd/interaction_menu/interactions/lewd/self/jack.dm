/datum/interaction/lewd/jack_self
	name = "Jack Off (self)"
	description = "Jerk yourself off."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	user_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	usage = INTERACTION_SELF
	cum_genital = list(CLIMAX_POSITION_USER = CLIMAX_PENIS)
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"cums hard on their hand",
		"shoots their load onto their fingers",
		"ejaculates onto their palm"
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"You cum hard on your hand",
		"You shoot your load onto your fingers",
		"You ejaculate onto your palm"
	))
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	message = list(
		"jerks themself off",
		"works their shaft",
		"strokes their cock",
		"wanks their cock hard"
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

/datum/interaction/lewd/jack_self/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
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

/datum/interaction/lewd/jack_self/post_climax(mob/living/carbon/human/user, mob/living/carbon/human/target, position)
	var/obj/item/reagent_containers/liquid_container
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		var/obj/item/organ/external/genital/penis/penis = user.get_organ_slot(ORGAN_SLOT_PENIS)
		if(penis?.internal_fluid_datum)
			var/datum/reagents/R = new(penis.internal_fluid_maximum)
			penis.transfer_internal_fluid(R, penis.internal_fluid_count)
			R.trans_to(liquid_container, R.total_volume)
			qdel(R)
	. = ..()
