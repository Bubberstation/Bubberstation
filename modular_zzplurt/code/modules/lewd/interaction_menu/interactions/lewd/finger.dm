/datum/interaction/lewd/finger
	name = "Finger Pussy"
	description = "Finger their pussy."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_VAGINA)
	cum_target = list(CLIMAX_POSITION_TARGET = null)
	additional_details = list(INTERACTION_FILLS_CONTAINERS)
	message = list(
		"fingers %TARGET%",
		"fingers %TARGET%'s pussy",
		"fingers %TARGET% hard"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 3
	user_arousal = 3
	target_arousal = 5
	target_pain = 0

/datum/interaction/lewd/finger/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()
	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		interaction_modifier_flags |= INTERACTION_OVERRIDE_FLUID_TRANSFER
		message = list(
			"fingers %TARGET% over \the [liquid_container]",
			"fingers %TARGET%'s pussy above \the [liquid_container]",
			"fingers %TARGET% hard while holding \the [liquid_container]"
		)
	. = ..()
	message = original_messages
	interaction_modifier_flags &= ~INTERACTION_OVERRIDE_FLUID_TRANSFER

/datum/interaction/lewd/finger/post_climax(mob/living/carbon/human/cumming, mob/living/carbon/human/came_in, position)
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/reagent_containers/liquid_container

		var/obj/item/cached_item = came_in.get_active_held_item()
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item
		else
			cached_item = came_in.pulling
			if(istype(cached_item, /obj/item/reagent_containers))
				liquid_container = cached_item

		if(liquid_container)
			var/obj/item/organ/external/genital/vagina/vagina = cumming.get_organ_slot(ORGAN_SLOT_VAGINA)
			if(vagina)
				vagina.transfer_internal_fluid(liquid_container.reagents, vagina.internal_fluid_count)

	. = ..()

/datum/interaction/lewd/fingerass
	name = "Finger Ass"
	description = "Finger their ass."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_ANUS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_BOTH)
	message = list(
		"fingers %TARGET%'s ass",
		"fingers %TARGET%'s asshole",
		"fingers %TARGET% hard"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/champ_fingering.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 3
	user_arousal = 3
	target_arousal = 5
	target_pain = 2

