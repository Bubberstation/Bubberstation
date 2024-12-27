/datum/interaction/lewd/handjob
	name = "Handjob"
	description = "Jerk them off."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_TARGET = null)
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	message = list(
		"jerks %TARGET% off",
		"works %TARGET%'s shaft",
		"wanks %TARGET%'s cock hard"
	)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"cums all over %USER%'s hand.",
			"shoots their load onto %USER%'s palm.",
			"covers %USER%'s fingers in cum."
		)
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"you cum all over %USER%'s hand.",
			"you shoot your load onto %USER%'s palm.",
			"you cover %USER%'s fingers in cum."
		)
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"%TARGET% cums all over your hand.",
			"%TARGET% shoots their load onto your palm.",
			"%TARGET% covers your fingers in cum."
		)
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/bang1.ogg',
		'modular_zzplurt/sound/interactions/bang2.ogg',
		'modular_zzplurt/sound/interactions/bang3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	user_arousal = 3
	target_pleasure = 4
	target_arousal = 6

/datum/interaction/lewd/handjob/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/reagent_containers/liquid_container

	// Check active hand first
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		// Check if pulling a container
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	// Add container text to message if needed
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

/datum/interaction/lewd/handjob/show_climax(mob/living/carbon/human/cumming, mob/living/carbon/human/came_in, position)
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/reagent_containers/liquid_container

		// Check active hand first
		var/obj/item/cached_item = came_in.get_active_held_item()
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item
		else
			// Check if pulling a container
			cached_item = came_in.pulling
			if(istype(cached_item, /obj/item/reagent_containers))
				liquid_container = cached_item

		if(liquid_container)
			// Store original lists, with null checks
			var/list/original_message_overrides = cum_message_text_overrides[position]
			var/list/original_self_overrides = cum_self_text_overrides[position]
			var/list/original_partner_overrides = cum_partner_text_overrides[position]
			original_message_overrides = original_message_overrides?.Copy()
			original_self_overrides = original_self_overrides?.Copy()
			original_partner_overrides = original_partner_overrides?.Copy()

			// Set container-specific messages
			cum_message_text_overrides[position] = list("cums into \the [liquid_container].")
			cum_self_text_overrides[position] = list("you cum into \the [liquid_container].")
			cum_partner_text_overrides[position] = list("%TARGET% cums into \the [liquid_container].")

			. = ..()

			// Restore original messages
			cum_message_text_overrides[position] = original_message_overrides
			cum_self_text_overrides[position] = original_self_overrides
			cum_partner_text_overrides[position] = original_partner_overrides
			return

	. = ..()

/datum/interaction/lewd/handjob/post_climax(mob/living/carbon/human/cumming, mob/living/carbon/human/came_in, position)
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/reagent_containers/liquid_container

		// Check active hand first
		var/obj/item/cached_item = came_in.get_active_held_item()
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item
		else
			// Check if pulling a container
			cached_item = came_in.pulling
			if(istype(cached_item, /obj/item/reagent_containers))
				liquid_container = cached_item

		if(liquid_container)
			var/obj/item/organ/external/genital/testicles/testicles = cumming.get_organ_slot(ORGAN_SLOT_TESTICLES)
			if(testicles)
				testicles.transfer_internal_fluid(liquid_container.reagents, testicles.internal_fluid_count)

	. = ..()
