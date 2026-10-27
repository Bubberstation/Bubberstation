#define CLIMAX_VAGINA "Vagina"
#define CLIMAX_PENIS "Penis"
#define CLIMAX_BOTH "Both"

#define CLIMAX_ON_FLOOR "On the floor"
#define CLIMAX_IN_OR_ON "Climax in or on someone"
#define CLIMAX_OPEN_CONTAINER "Fill reagent container"
#define CLIMAX_PORTAL "Through the portal"

// both of these are pretty much arbitrary
#define MIN_CUM_THRESHOLD 5
#define MIN_VAGINA_WETNESS_THRESHOLD 3.33

/mob/living/carbon/human
	/// Used to prevent nightmare scenarios.
	var/refractory_period

/mob/living/carbon/human/climax(manual = TRUE)
	if (CONFIG_GET(flag/disable_erp_preferences))
		return

	#ifndef TESTING
	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/autocum) && !manual)
		return
	#endif

	if(refractory_period > REALTIMEOFDAY)
		return
	refractory_period = REALTIMEOFDAY + 30 SECONDS

	#ifndef TESTING
	if(has_status_effect(/datum/status_effect/climax_cooldown) || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return
	#endif

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

	var/obj/item/organ/genital/testicles/testicles = get_organ_slot(ORGAN_SLOT_TESTICLES)
	testicles?.calculate_cumshot()

	if(climax_choice == CLIMAX_PENIS || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/genital/penis/penis = get_organ_slot(ORGAN_SLOT_PENIS)
		if(!testicles || testicles.reagents.total_volume < MIN_CUM_THRESHOLD) //If we have no god damn balls, we can't cum anywhere... GET BALLS! , OR theres so little in your balls that nothing comes out...
			visible_message(span_userlove("[src] orgasms, but nothing comes out of [self_their] penis!"), \
				span_userlove("You orgasm, it feels great, but nothing comes out of your penis!"))

		else if(is_wearing_condom())
			var/obj/item/clothing/sextoy/condom/condom = src.penis // bruh 💀⚰️💀⚰️💀⚰️💀⚰️💀
			condom.condom_use() // condoms probably should become reagent containers at some point
			visible_message(span_userlove("[src] shoots [self_their] load into the [condom], filling it up!"), \
				span_userlove("You shoot your thick load into the [condom] and it catches it all!"))
			testicles.reagents.remove_all(testicles.cumshot_size)

		else if(!is_bottomless() && penis.visibility_preference != GENITAL_ALWAYS_SHOW)
			visible_message(span_userlove("[src] cums inside [self_their] clothes!"), \
				span_userlove("You shoot your load, but you weren't naked, so you mess up your clothes!"))
			self_orgasm = TRUE
			testicles.reagents.remove_all(testicles.cumshot_size)

		else
			var/list/interactable_inrange_targets = list()
			// monkey see, monkey do
			var/list/interactable_inrange_open_containers = list()

			// Unfortunately prefs can't be checked here, because byond/tgstation moment.
			for(var/mob/living/iterating_living in (view(1, src) - src))
				if(!ishuman(iterating_living) && !iscyborg(iterating_living))
					continue
				interactable_inrange_targets[iterating_living.name] = iterating_living

			// this should be making a list of cups(?)
			for(var/obj/item/reagent_containers/cup/iterating_open_container in (view(1, src) - src))
				interactable_inrange_open_containers[iterating_open_container.name] = iterating_open_container

			var/list/buttons = list(CLIMAX_ON_FLOOR)
			if(interactable_inrange_targets.len)
				buttons += CLIMAX_IN_OR_ON

			if(interactable_inrange_open_containers.len)
				buttons += CLIMAX_OPEN_CONTAINER

			// If your using a LustWish portal lets you cum through it
			var/obj/structure/lewd_portal/portal = src.buckled
			if(istype(portal, /obj/structure/lewd_portal))
				buttons += CLIMAX_PORTAL

			var/penis_climax_choice = tgui_alert(src, "Choose where to shoot your load.", "Load preference!", buttons)

			var/create_cum_decal = FALSE

			if(!penis_climax_choice || penis_climax_choice == CLIMAX_ON_FLOOR)
				create_cum_decal = TRUE
				if(last_lewd_partner && (last_lewd_partner in view(1, src)))
					visible_message(span_userlove("[src] pulls out and shoots [self_their] sticky load onto the floor instead of finishing on [last_lewd_partner]!"), \
						span_userlove("You pull out and shoot string after string of hot cum onto the floor instead of finishing on [last_lewd_partner]!"))
					to_chat(last_lewd_partner, span_userlove("[src] pulls out and shoots their sticky load onto the floor instead of you!"))
				else
					visible_message(span_userlove("[src] shoots [self_their] sticky load onto the floor!"), \
						span_userlove("You shoot string after string of hot cum, hitting the floor!"))
				testicles.reagents.remove_all(testicles.cumshot_size)

			else if(penis_climax_choice == CLIMAX_OPEN_CONTAINER)
				var/target_choice = tgui_input_list(src, "Choose a container to cum into.", "Choose target!", interactable_inrange_open_containers)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src] shoots [self_their] sticky load onto the floor!"), \
						span_userlove("You shoot string after string of hot cum, hitting the floor!"))
					testicles.reagents.remove_all(testicles.cumshot_size)
				else
					var/obj/item/reagent_containers/cup/target_open_container = interactable_inrange_open_containers[target_choice]
					if(target_open_container.is_refillable() && target_open_container.is_drainable())
						// here's where we actually do the cumming(?)
						var/cum_volume = testicles.cumshot_size
						var/total_volume_w_cum = cum_volume + target_open_container.reagents.total_volume
						conditional_pref_sound(get_turf(src), SFX_DESECRATION, 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)
						if(target_open_container.reagents.holder_full())
							// its full already
							add_cum_splatter_floor(get_turf(target_open_container))
							visible_message(span_userlove("[src] tries to cum into the [target_open_container], but it's already full, spilling their hot load onto the floor!"), \
								span_userlove("You try to cum into the [target_open_container], but it's already full, so it all hits the floor instead!"))
						else
							testicles.reagents.trans_to(target_open_container, testicles.cumshot_size, transferred_by = src)
							if(total_volume_w_cum > target_open_container.volume)
								// overflow, make the decal
								add_cum_splatter_floor(get_turf(target_open_container))
								visible_message(span_userlove("[src] shoots [self_their] sticky load into the [target_open_container], it's so full that it overflows!"), \
									span_userlove("You shoot string after string of hot cum into the [target_open_container], making it overflow!"))
							else
								visible_message(span_userlove("[src] shoots [self_their] sticky load into the [target_open_container]!"), \
									span_userlove("You shoot string after string of hot cum into the [target_open_container]!"))
					else
						// cum fail
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] shoots [self_their] sticky load onto the floor!"), \
							span_userlove("You shoot string after string of hot cum, hitting the floor!"))
						testicles.reagents.remove_all(testicles.cumshot_size)

			else if(penis_climax_choice == CLIMAX_PORTAL)
				to_chat(src, "You shoot string after string of hot cum, hitting whatever is on the other side!")
				portal.relayed_body.visible_message("[portal.relayed_body] shoots its sticky load onto the floor!")
				add_cum_splatter_floor(get_turf(portal.relayed_body))

			else
				var/target_choice = tgui_input_list(src, "Choose a person to cum in or on.", "Choose target!", interactable_inrange_targets)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src] shoots [self_their] sticky load onto the floor!"), \
						span_userlove("You shoot string after string of hot cum, hitting the floor!"))
				else
					var/mob/living/target_living = interactable_inrange_targets[target_choice]
					var/target_living_them = target_living.p_them()

					var/list/target_buttons = list()

					if(ishuman(target_living))
						var/mob/living/carbon/human/target_human = target_living
						if(!target_human.wear_mask)
							target_buttons += "mouth"
					if(target_living.has_vagina(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_VAGINA
					if(target_living.has_anus(REQUIRE_GENITAL_EXPOSED))
						target_buttons += "asshole"
					if(ishuman(target_living))
						var/mob/living/carbon/human/target_human_penis = target_living
						if(target_human_penis.has_penis(REQUIRE_GENITAL_EXPOSED))
							var/obj/item/organ/genital/penis/other_penis = target_human_penis.get_organ_slot(ORGAN_SLOT_PENIS)
							if(other_penis?.sheath != "None")
								target_buttons += "sheath"
					else if(iscyborg(target_living))
						var/mob/living/silicon/robot/target_robot = target_living
						if(target_robot.synthetic_penis && target_robot.synthetic_penis_sheathed)
							target_buttons += "sheath"
						if(target_robot.synthetic_penis && target_robot.synthetic_penis_slit)
							target_buttons += "slit"
					target_buttons += "On [target_living_them]"

					var/climax_into_choice = tgui_input_list(src, "Where on or in [target_living] do you wish to cum?", "Final frontier!", target_buttons)

					if(!climax_into_choice)
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] shoots their sticky load onto the floor!"), \
							span_userlove("You shoot string after string of hot cum, hitting the floor!"))
					else if(climax_into_choice == "On [target_living_them]")
						create_cum_decal = TRUE
						if(target_living == last_lewd_partner)
							visible_message(span_userlove("[src] pulls out and unloads all over [target_living], painting the person who just got them off!"), \
								span_userlove("You pull out and unload all over [target_living], rewarding them for getting you off!"))
							to_chat(target_living, span_userlove("[src] pulls out and covers you in their load as thanks for getting them off!"))
						else
							visible_message(span_userlove("[src] shoots their sticky load onto [target_living]!"), \
								span_userlove("You shoot string after string of hot cum onto [target_living]!"))
							to_chat(target_living, span_userlove("[src] shoots their sticky load all over you!"))
					else
						visible_message(
							span_userlove("[src] hilts [self_their] cock into [target_living]'s [climax_into_choice], shooting cum into [target_living_them]!"),
							span_userlove("You hilt your cock into [target_living]'s [climax_into_choice], shooting cum into [target_living_them]!"))
						to_chat(target_living, span_userlove("Your [climax_into_choice] fills with warm cum as [src] shoots [self_their] load into it."))

						if(climax_into_choice == "mouth")
							testicles.reagents.trans_to(target_living, testicles.cumshot_size, transferred_by = src, methods = INGEST)
						else if(climax_into_choice == ORGAN_SLOT_VAGINA)
							var/obj/item/organ/genital/vagina/vagina = target_living.get_organ_slot(ORGAN_SLOT_VAGINA)
							if(vagina)
								testicles.reagents.trans_to(vagina, testicles.cumshot_size, transferred_by = src, methods = INGEST)
						else if(climax_into_choice == "asshole")
							var/obj/item/organ/genital/anus/anus = target_living.get_organ_slot(ORGAN_SLOT_ANUS)
							if(anus)
								testicles.reagents.trans_to(anus, testicles.cumshot_size, transferred_by = src, methods = INGEST)

					// if someone wanted to, they could add code for actually putting cum inside of a vagina since it's a reagent container now...
					// would need to change up the fluid_generation.dm and tweak the organ itself for it to make sense though
					// same for other organs

			if(create_cum_decal)
				add_cum_splatter_floor(get_turf(src))

		try_lewd_autoemote("moan")
		if(climax_choice == CLIMAX_PENIS)
			apply_status_effect(/datum/status_effect/climax)
			apply_status_effect(/datum/status_effect/climax_cooldown)
			if(self_orgasm)
				add_mood_event("orgasm", /datum/mood_event/climaxself)
			return TRUE

	if(climax_choice == CLIMAX_VAGINA || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/genital/vagina/vagina = get_organ_slot(ORGAN_SLOT_VAGINA)
		if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
			visible_message(
				span_userlove("[src] twitches and moans as [p_they()] climax from their vagina!"),
				span_userlove("You twitch and moan as you climax from your vagina!"))
			if(vagina.reagents.total_volume >= MIN_VAGINA_WETNESS_THRESHOLD)
				var/mob/living/squirt_target = null
				if(last_lewd_partner && (last_lewd_partner in view(1, src)))
					var/squirt_choice = tgui_alert(src, "Choose where to squirt.", "Squirt preference!", list(CLIMAX_ON_FLOOR, "On [last_lewd_partner]"))
					if(squirt_choice == "On [last_lewd_partner]")
						squirt_target = last_lewd_partner
				if(squirt_target)
					add_cum_splatter_floor(get_turf(squirt_target), female = TRUE)
					visible_message(span_userlove("[src] sprays their fem-cum all over [squirt_target], coating the person who just got them off!"), \
						span_userlove("You spray your fem-cum all over [squirt_target], rewarding them for getting you off!"))
					to_chat(squirt_target, span_userlove("[src] sprays their fem-cum all over you as thanks for getting them off!"))
				else
					add_cum_splatter_floor(get_turf(src), female = TRUE)
		else
			if(vagina.reagents.total_volume >= MIN_VAGINA_WETNESS_THRESHOLD)
				visible_message(
					span_userlove("[src] cums in [self_their] underwear from [self_their] vagina!"),
					span_userlove("You cum in your underwear from your vagina! Eww."))
				self_orgasm = TRUE
			else
				visible_message(
					span_userlove("[src] cums in [self_their] underwear from [self_their] vagina!"),
					span_userlove("You cum in your underwear from your vagina, but you aren't wet enough to mess it up."))

	apply_status_effect(/datum/status_effect/climax)
	apply_status_effect(/datum/status_effect/climax_cooldown)
	if(self_orgasm)
		add_mood_event("orgasm", /datum/mood_event/climaxself)
	return TRUE

#undef CLIMAX_VAGINA
#undef CLIMAX_PENIS
#undef CLIMAX_BOTH
#undef CLIMAX_ON_FLOOR
#undef CLIMAX_IN_OR_ON
#undef CLIMAX_OPEN_CONTAINER

#undef MIN_CUM_THRESHOLD
#undef MIN_VAGINA_WETNESS_THRESHOLD
#undef CLIMAX_PORTAL
