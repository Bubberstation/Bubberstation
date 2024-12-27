//SPLURT EDIT REMOVAL BEGIN - Interactions - Moved climax defines to global defines
/*
#define CLIMAX_VAGINA "Vagina"
#define CLIMAX_PENIS "Penis"
#define CLIMAX_BOTH "Both"
*/
//SPLURT EDIT REMOVAL END

#define CLIMAX_ON_FLOOR "On the floor"
#define CLIMAX_IN_OR_ON "Climax in or on someone"

/mob/living/carbon/human
	/// Used to prevent nightmare scenarios.
	var/refractory_period

/mob/living/carbon/human/proc/climax(manual = TRUE, mob/living/carbon/human/partner, datum/interaction/climax_interaction, interaction_position)
	if (CONFIG_GET(flag/disable_erp_preferences))
		return

	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/autocum) && !manual)
		return
	if(refractory_period > REALTIMEOFDAY)
		return
	refractory_period = REALTIMEOFDAY + 30 SECONDS
	if(has_status_effect(/datum/status_effect/climax_cooldown) || !client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	if(HAS_TRAIT(src, TRAIT_NEVERBONER) || has_status_effect(/datum/status_effect/climax_cooldown) || (!has_vagina() && !has_penis()))
		visible_message(span_purple("[src] twitches, trying to cum, but with no result."), \
			span_purple("You can't have an orgasm!"))
		return TRUE

	// Reduce pop-ups and make it slightly more frictionless (lewd).
	var/climax_choice = has_penis() ? CLIMAX_PENIS : CLIMAX_VAGINA

	if(manual)
		var/list/genitals = list()
		if(has_vagina())
			genitals.Add(CLIMAX_VAGINA)
			if(has_penis())
				genitals.Add(CLIMAX_PENIS)
				genitals.Add(CLIMAX_BOTH)
		else if(has_penis())
			genitals.Add(CLIMAX_PENIS)
		climax_choice = tgui_alert(src, "You are climaxing, choose which genitalia to climax with.", "Genitalia Preference!", genitals)
	//SPLURT EDIT ADDITION BEGIN - Interactions
	else if(climax_interaction?.cum_genital[interaction_position])
		climax_choice = climax_interaction.cum_genital[interaction_position]
	//SPLURT EDIT ADDITION END
	switch(gender)
		if(MALE)
			conditional_pref_sound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)
		if(FEMALE)
			conditional_pref_sound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)

	var/self_orgasm = FALSE
	var/self_their = p_their()

	if(climax_choice == CLIMAX_PENIS || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/external/genital/penis/penis = get_organ_slot(ORGAN_SLOT_PENIS)
		if(!get_organ_slot(ORGAN_SLOT_TESTICLES)) //If we have no god damn balls, we can't cum anywhere... GET BALLS!
			visible_message(span_userlove("[src] orgasms, but nothing comes out of [self_their] penis!"), \
				span_userlove("You orgasm, it feels great, but nothing comes out of your penis!"))

		else if(is_wearing_condom())
			var/obj/item/clothing/sextoy/condom/condom = get_item_by_slot(LEWD_SLOT_PENIS)
			condom.condom_use()
			visible_message(span_userlove("[src] shoots [self_their] load into the [condom], filling it up!"), \
				span_userlove("You shoot your thick load into the [condom] and it catches it all!"))

		else if(!is_bottomless() && penis.visibility_preference != GENITAL_ALWAYS_SHOW)
			visible_message(span_userlove("[src] cums inside [self_their] clothes!"), \
				span_userlove("You shoot your load, but you weren't naked, so you mess up your clothes!"))
			self_orgasm = TRUE

		else
			var/list/interactable_inrange_humans = list()

			// Unfortunately prefs can't be checked here, because byond/tgstation moment.
			for(var/mob/living/carbon/human/iterating_human in (view(1, src) - src))
				interactable_inrange_humans[iterating_human.name] = iterating_human

			var/list/buttons = list(CLIMAX_ON_FLOOR)
			if(interactable_inrange_humans.len)
				buttons += CLIMAX_IN_OR_ON

			var/penis_climax_choice = climax_interaction && !manual ? CLIMAX_IN_OR_ON : tgui_alert(src, "Choose where to shoot your load.", "Load preference!", buttons) //SPLURT EDIT CHANGE - Interactions

			var/create_cum_decal = FALSE

			if(!penis_climax_choice || penis_climax_choice == CLIMAX_ON_FLOOR)
				create_cum_decal = TRUE
				visible_message(span_userlove("[src] shoots [self_their] sticky load onto the floor!"), \
					span_userlove("You shoot string after string of hot cum, hitting the floor!"))

			else
				var/target_choice = climax_interaction && !manual ? partner?.name : tgui_input_list(src, "Choose a person to cum in or on.", "Choose target!", interactable_inrange_humans) //SPLURT EDIT CHANGE - Interactions
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src] shoots [self_their] sticky load onto the floor!"), \
						span_userlove("You shoot string after string of hot cum, hitting the floor!"))
				else
					var/mob/living/carbon/human/target_human = climax_interaction && !manual && partner ? partner : interactable_inrange_humans[target_choice] //SPLURT EDIT CHANGE - Interactions
					var/target_human_them = target_human.p_them()

					var/list/target_buttons = list()

					if(!target_human.wear_mask)
						target_buttons += "mouth"
					if(target_human.has_vagina(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_VAGINA
					if(target_human.has_anus(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_ANUS //SPLURT EDIT CHANGE - Interactions - Changed asshole to anus for consistency
					if(target_human.has_penis(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_PENIS
						var/obj/item/organ/external/genital/penis/other_penis = target_human.get_organ_slot(ORGAN_SLOT_PENIS)
						if(other_penis.sheath != "None")
							target_buttons += "sheath"
					target_buttons += "On [target_human_them]"

					//SPLURT EDIT CHANGE BEGIN - Interactions
					var/climax_into_choice
					var/interaction_inside = partner?.get_organ_slot(climax_interaction?.cum_target[interaction_position]) || target_buttons.Find(climax_interaction?.cum_target[interaction_position])

					if(climax_interaction && !manual && interaction_inside)
						climax_into_choice = climax_interaction.cum_target[interaction_position]
					else if(manual)
						climax_into_choice = tgui_input_list(src, "Where on or in [target_human] do you wish to cum?", "Final frontier!", target_buttons)
					else
						climax_into_choice = "On [target_human_them]"

					if(climax_interaction && !manual && climax_interaction.show_climax(src, target_human, interaction_position))
						create_cum_decal = !interaction_inside
					else if(!climax_into_choice)
					//SPLURT EDIT CHANGE END
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] shoots their sticky load onto the floor!"), \
							span_userlove("You shoot string after string of hot cum, hitting the floor!"))
					else if(climax_into_choice == "On [target_human_them]")
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] shoots their sticky load onto [target_human]!"), \
							span_userlove("You shoot string after string of hot cum onto [target_human]!"))
					else
						visible_message(span_userlove("[src] hilts [self_their] cock into [target_human]'s [climax_into_choice], shooting cum into [target_human_them]!"), \
							span_userlove("You hilt your cock into [target_human]'s [climax_into_choice], shooting cum into [target_human_them]!"))
						to_chat(target_human, span_userlove("Your [climax_into_choice] fills with warm cum as [src] shoots [self_their] load into it."))

			var/obj/item/organ/external/genital/testicles/testicles = get_organ_slot(ORGAN_SLOT_TESTICLES)
			//SPLURT EDIT CHANGE BEGIN - Interactions
			if(!(climax_interaction?.interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER))
				if(create_cum_decal)
					if(HAS_TRAIT(src, TRAIT_MESSY))
						// Transfer reagents to the turf using liquids system
						var/datum/reagents/R = new(testicles.internal_fluid_maximum)
						testicles.transfer_internal_fluid(R, testicles.internal_fluid_count * 0.6)
						if(partner && partner != src)
							// Get turf between src and partner for directional splatter
							var/turf/T = get_turf(partner)
							T.add_liquid_from_reagents(R, FALSE, 1, get_turf(src), partner)
						else
							var/turf/T = get_turf(src)
							T.add_liquid_from_reagents(R, FALSE, 1)
						qdel(R)
					else
						testicles.transfer_internal_fluid(null, testicles.internal_fluid_count * 0.6)
						add_cum_splatter_floor(get_turf(src))
				else if(partner)
					// Transfer reagents directly to partner
					var/datum/reagents/R = new(testicles.internal_fluid_maximum)
					testicles.transfer_internal_fluid(R, testicles.internal_fluid_count * 0.6)
					R.trans_to(partner, R.total_volume)
					qdel(R)
				else
					testicles.transfer_internal_fluid(null, testicles.internal_fluid_count * 0.6)
			//SPLURT EDIT CHANGE END

		try_lewd_autoemote("moan")
		if(climax_choice == CLIMAX_PENIS)
			apply_status_effect(/datum/status_effect/climax)
			apply_status_effect(/datum/status_effect/climax_cooldown)
			if(self_orgasm)
				add_mood_event("orgasm", /datum/mood_event/climaxself)
			return TRUE

	if(climax_choice == CLIMAX_VAGINA || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/external/genital/vagina/vagina = get_organ_slot(ORGAN_SLOT_VAGINA)
		//SPLURT EDIT CHANGE BEGIN - Interactions
		if(!is_bottomless() && vagina.visibility_preference != GENITAL_ALWAYS_SHOW)
			visible_message(span_userlove("[src] cums in [self_their] underwear from [self_their] vagina!"), \
					span_userlove("You cum in your underwear from your vagina! Eww."))
			self_orgasm = TRUE
		else
			var/list/interactable_inrange_humans = list()

			for(var/mob/living/carbon/human/iterating_human in (view(1, src) - src))
				interactable_inrange_humans[iterating_human.name] = iterating_human

			var/list/buttons = list(CLIMAX_ON_FLOOR)
			if(interactable_inrange_humans.len)
				buttons += CLIMAX_IN_OR_ON

			var/vagina_climax_choice = climax_interaction && !manual ? CLIMAX_IN_OR_ON : tgui_alert(src, "Choose where to squirt.", "Squirt preference!", buttons)

			var/create_cum_decal = FALSE

			if(!vagina_climax_choice || vagina_climax_choice == CLIMAX_ON_FLOOR)
				create_cum_decal = TRUE
				visible_message(span_userlove("[src] twitches and moans as [p_they()] squirt on the floor!"), \
					span_userlove("You twitch and moan as you squirt on the floor!"))

			else
				var/target_choice = climax_interaction && !manual ? partner.name : tgui_input_list(src, "Choose who to squirt on.", "Choose target!", interactable_inrange_humans)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src] twitches and moans as [p_they()] squirt on the floor!"), \
						span_userlove("You twitch and moan as you squirt on the floor!"))
				else
					var/mob/living/carbon/human/target_human = climax_interaction && !manual ? partner : interactable_inrange_humans[target_choice]
					var/target_human_them = target_human.p_them()

					var/list/target_buttons = list()

					if(!target_human.wear_mask)
						target_buttons += "mouth"
					if(target_human.has_vagina(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_VAGINA
					if(target_human.has_anus(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_ANUS
					if(target_human.has_penis(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_PENIS
						var/obj/item/organ/external/genital/penis/other_penis = target_human.get_organ_slot(ORGAN_SLOT_PENIS)
						if(other_penis.sheath != "None")
							target_buttons += "sheath"
					target_buttons += "On [target_human_them]"

					var/climax_into_choice
					var/interaction_inside = partner?.get_organ_slot(climax_interaction?.cum_target[interaction_position]) || target_buttons.Find(climax_interaction?.cum_target[interaction_position])

					if(climax_interaction && !manual && interaction_inside)
						climax_into_choice = climax_interaction.cum_target[interaction_position]
					else if(manual)
						climax_into_choice = tgui_input_list(src, "Where on or in [target_human] do you wish to squirt?", "Final frontier!", target_buttons)
					else
						climax_into_choice = "On [target_human_them]"

					if(climax_interaction && !manual && climax_interaction.show_climax(src, target_human, interaction_position))
						create_cum_decal = !interaction_inside
					else if(!climax_into_choice)
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] squirts on the floor!"), \
							span_userlove("You squirt on the floor!"))
					else if(climax_into_choice == "On [target_human_them]")
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] squirts all over [target_human]!"), \
							span_userlove("You squirt all over [target_human]!"))
					else
						visible_message(span_userlove("[src] squirts into [target_human]'s [climax_into_choice]!"), \
							span_userlove("You squirt into [target_human]'s [climax_into_choice]!"))
						to_chat(target_human, span_userlove("Your [climax_into_choice] fills with [src]'s fluids."))

			if(!(climax_interaction?.interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER))
				if(create_cum_decal)
					if(HAS_TRAIT(src, TRAIT_MESSY))
						var/datum/reagents/R = new(vagina.internal_fluid_maximum)
						vagina.transfer_internal_fluid(R, vagina.internal_fluid_count)
						if(partner && partner != src)
							var/turf/T = get_turf(partner)
							T.add_liquid_from_reagents(R, FALSE, 1, get_turf(src), partner)
						else
							var/turf/T = get_turf(src)
							T.add_liquid_from_reagents(R, FALSE, 1)
						qdel(R)
					else
						vagina.transfer_internal_fluid(null, vagina.internal_fluid_count)
						add_cum_splatter_floor(get_turf(src), female = TRUE)
				else if(partner)
					var/datum/reagents/R = new(vagina.internal_fluid_maximum)
					vagina.transfer_internal_fluid(R, vagina.internal_fluid_count)
					R.trans_to(partner, R.total_volume)
					qdel(R)
				else
					vagina.transfer_internal_fluid(null, vagina.internal_fluid_count)
		//SPLURT EDIT CHANGE END

	apply_status_effect(/datum/status_effect/climax)
	apply_status_effect(/datum/status_effect/climax_cooldown)
	if(self_orgasm)
		add_mood_event("orgasm", /datum/mood_event/climaxself)

	// SPLURT EDIT ADDITION BEGIN - Interactions
	if(climax_interaction && !manual)
		climax_interaction.post_climax(src, partner, interaction_position)
	//SPLURT EDIT ADDITION END
	return TRUE

//SPLURT EDIT REMOVAL BEGIN - Interactions - Moved climax defines to global defines
/*
#undef CLIMAX_VAGINA
#undef CLIMAX_PENIS
#undef CLIMAX_BOTH
*/
//SPLURT EDIT REMOVAL END

#undef CLIMAX_ON_FLOOR
#undef CLIMAX_IN_OR_ON
