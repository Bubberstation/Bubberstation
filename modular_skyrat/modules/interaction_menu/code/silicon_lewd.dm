// Synthetic lewd support for cyborgs. Cyborgs use simplified synthetic anatomy rather
// than the organ-holder based system humans use, and their genitals can be configured
// from the Silicon section of character preferences and toggled live in-game.

// Generic defaults so the lewd code can call these on any living mob. Humans and
// cyborgs override them with their own anatomy checks.
/mob/living/proc/get_cock_flavor()
	return pick("cock", "throbbing cock", "stiff cock")

/mob/living/carbon/human/get_cock_flavor()
	var/obj/item/organ/genital/penis/penis = get_organ_slot(ORGAN_SLOT_PENIS)
	if(!penis)
		return pick("cock", "throbbing cock", "stiff cock")
	switch(penis.genital_type)
		if("canine")
			return pick("canine cock", "knotted canine cock", "thick canine shaft")
		if("equine")
			return pick("horsecock", "long equine cock", "heavy horse shaft")
		if("avian")
			return pick("tapered cock", "slick avian cock", "preening shaft")
		if("tentacle")
			return pick("tentacle cock", "writhing tentacle", "twisting tendril")
		if("dragon")
			return pick("dragon cock", "ridged dragon cock", "scaled shaft")
	return pick("cock", "throbbing cock", "stiff cock")

/mob/living/silicon/robot/get_cock_flavor()
	if(synthetic_penis_slit)
		return pick("hidden slit-length", "slit-slick length", "emerging length")
	switch(synthetic_penis_type)
		if("canine")
			return pick("canine cock", "knotted canine cock", "thick canine shaft")
		if("equine")
			return pick("horsecock", "long equine cock", "heavy horse shaft")
		if("avian")
			return pick("tapered cock", "slick avian cock", "preening shaft")
		if("tentacle")
			return pick("tentacle cock", "writhing tentacle", "twisting tendril")
		if("dragon")
			return pick("dragon cock", "ridged dragon cock", "scaled shaft")
	return pick("cock", "throbbing cock", "stiff cock")

/mob/living/proc/has_penis(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_vagina(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_breasts(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_anus(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_balls(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/has_arms(required_state = REQUIRE_GENITAL_ANY)
	return FALSE

/mob/living/proc/is_topless()
	return FALSE

/mob/living/proc/is_bottomless()
	return FALSE

/mob/living/proc/update_inv_lewd()
	return

/mob/living/proc/adjust_arousal(arous = 0)
	return FALSE

/mob/living/proc/climax(manual = TRUE)
	return FALSE

/mob/living/proc/has_required_part(slot)
	return FALSE

/// Adds lewd dirt to this mob. `location` is "body", "vagina", or "anus". `fluid` is a LEWD_FLUID_* bitflag.
/mob/living/proc/add_cum(location = "body", fluid = LEWD_FLUID_CUM, amount = 1)
	switch(location)
		if("vagina")
			cum_in_vagina = min(cum_in_vagina + amount, LEWD_DIRT_MAX_TIER)
			cum_in_vagina_type |= fluid
			notify_internal_cum("vagina", fluid)
		if("anus")
			cum_in_anus = min(cum_in_anus + amount, LEWD_DIRT_MAX_TIER)
			cum_in_anus_type |= fluid
			notify_internal_cum("anus", fluid)
		else
			cum_on_body = min(cum_on_body + amount, LEWD_DIRT_MAX_TIER)
			cum_on_body_type |= fluid
	update_inv_lewd()

/// Returns a human-readable description of the lewd fluids present in a bitmask.
/mob/living/proc/get_lewd_fluid_string(bitmask)
	var/list/fluids = list()
	if(bitmask & LEWD_FLUID_CUM)
		fluids += "cum"
	if(bitmask & LEWD_FLUID_FEMCUM)
		fluids += "fem-cum"
	if(bitmask & LEWD_FLUID_SYNTH_CUM)
		fluids += "synthetic cum"
	if(bitmask & LEWD_FLUID_SYNTH_FEMCUM)
		fluids += "synthetic fem-cum"
	return english_list(fluids)

/mob/living/proc/get_lewd_coverage_string(amount)
	amount = clamp(amount, 0, LEWD_DIRT_MAX_TIER)
	switch(amount)
		if(0)
			return null
		if(1 to 3)
			return "lightly splattered with"
		if(4 to 6)
			return "splattered with"
		if(7 to 9)
			return "heavily coated in"
		else
			return "absolutely drenched in"

/mob/living/proc/get_lewd_drip_text(fluid_bitmask, amount)
	var/fluid = get_lewd_fluid_string(fluid_bitmask)
	switch(clamp(amount, 1, LEWD_DIRT_MAX_TIER))
		if(1 to 3)
			return "a little [fluid] drips"
		if(4 to 6)
			return "[fluid] drips"
		if(7 to 9)
			return "[fluid] leaks"
		else
			return "[fluid] gushes"

/// Lets the owner feel internal cum they can't see (it is hidden under clothes when dressed).
/mob/living/proc/notify_internal_cum(where, fluid = LEWD_FLUID_CUM)
	var/drip_where = (where == "anus") ? "legs" : "thighs"
	var/fluid_name = get_lewd_fluid_string(fluid)
	if(ishuman(src))
		var/mob/living/carbon/human/human = src
		if(human.is_bottomless())
			to_chat(src, span_userlove("You feel [fluid_name] dripping down your [drip_where]."))
		else
			to_chat(src, span_userlove("You feel [fluid_name] soaking into your underwear, warm against your [where]."))
	else if(iscyborg(src))
		to_chat(src, span_userlove("You feel [fluid_name] pooling inside your [where]."))

/// Clears external cum. Used by showers, soap, spray bottles, etc.
/mob/living/proc/clean_lewd_external()
	if(!cum_on_body)
		return FALSE
	cum_on_body = 0
	cum_on_body_type = 0
	update_inv_lewd()
	return TRUE

/// Clears internal cum (vagina/anus). Only callable via the douche self-interaction.
/mob/living/proc/douche_lewd()
	if(!cum_in_vagina && !cum_in_anus)
		return FALSE
	cum_in_vagina = 0
	cum_in_vagina_type = 0
	cum_in_anus = 0
	cum_in_anus_type = 0
	return TRUE

/// Are we standing under a running shower?
/mob/living/proc/is_in_shower()
	for(var/obj/machinery/shower/shower in loc)
		if(shower.actually_on)
			return TRUE
	return FALSE

/// Are we holding a spray bottle that contains water?
/mob/living/proc/holds_water_spray()
	var/obj/item/held = get_active_held_item()
	if(!istype(held, /obj/item/reagent_containers/spray))
		return FALSE
	return held.reagents?.has_reagent(/datum/reagent/water, 1)

/// Hooks into the existing washing system so external cum is cleaned like blood.
/mob/living/wash(clean_types)
	. = ..()
	if((clean_types & CLEAN_TYPE_BLOOD) && !(clean_types & CLEAN_TYPE_FIBERS))
		if(clean_lewd_external())
			. |= COMPONENT_CLEANED

/mob/living/carbon/human/has_required_part(slot)
	var/obj/item/organ/genital/required_part = get_organ_slot(slot)
	if(isnull(required_part))
		return FALSE
	return required_part.is_exposed()

/mob/living/silicon/robot/has_required_part(slot)
	switch(slot)
		if(ORGAN_SLOT_VAGINA)
			return has_vagina(REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_PENIS)
			return has_penis(REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_BREASTS)
			return has_breasts(REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_ANUS)
			return has_anus(REQUIRE_GENITAL_EXPOSED)
	return FALSE

/mob/living/silicon/robot
	/// Synthetic genital configuration. These mirror the silicon genital prefs and can be toggled in-game.
	var/synthetic_vagina = FALSE
	var/synthetic_penis = FALSE
	var/synthetic_breasts = FALSE
	var/synthetic_anus = FALSE
	/// When TRUE, synthetic genitals are hidden (like underwear) and cannot be non-consensually touched.
	var/synthetic_genitals_hidden = TRUE
	/// Synthetic penis customization.
	var/synthetic_penis_type = "human"
	var/synthetic_penis_size = 1
	var/synthetic_penis_girth = 1
	var/synthetic_penis_sheathed = FALSE
	var/synthetic_penis_slit = FALSE
	var/synthetic_balls = FALSE
	/// Synthetic breast customization.
	var/synthetic_breast_type = "pair"
	var/synthetic_breast_size = 1
	var/synthetic_breast_reagent = /datum/reagent/consumable/milk
	/// Synthetic breast fluid reservoir.
	var/synthetic_breast_fluid = 0
	var/synthetic_breast_max_fluid = 0

/mob/living/silicon/robot/proc/apply_synthetic_genital_prefs(client/player_client)
	var/datum/preferences/preferences = player_client?.prefs
	if(!preferences)
		return

	synthetic_vagina = preferences.read_preference(/datum/preference/toggle/silicon_vagina)
	synthetic_penis = preferences.read_preference(/datum/preference/toggle/silicon_penis)
	synthetic_breasts = preferences.read_preference(/datum/preference/toggle/silicon_breasts)
	synthetic_anus = preferences.read_preference(/datum/preference/toggle/silicon_anus)
	update_synthetic_breast_fluid()
	update_inv_lewd()

/// Cyborgs have no organ holder. Return null so any generic organ-slot lookups safely no-op.
/mob/living/silicon/robot/get_organ_slot(slot)
	return null

/mob/living/silicon/robot/has_penis(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_penis)
		return FALSE
	switch(required_state)
		if(REQUIRE_GENITAL_EXPOSED)
			return !synthetic_genitals_hidden
		if(REQUIRE_GENITAL_UNEXPOSED)
			return synthetic_genitals_hidden
		else
			return TRUE

/mob/living/silicon/robot/has_vagina(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_vagina)
		return FALSE
	switch(required_state)
		if(REQUIRE_GENITAL_EXPOSED)
			return !synthetic_genitals_hidden
		if(REQUIRE_GENITAL_UNEXPOSED)
			return synthetic_genitals_hidden
		else
			return TRUE

/mob/living/silicon/robot/has_breasts(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_breasts)
		return FALSE
	switch(required_state)
		if(REQUIRE_GENITAL_EXPOSED)
			return !synthetic_genitals_hidden
		if(REQUIRE_GENITAL_UNEXPOSED)
			return synthetic_genitals_hidden
		else
			return TRUE

/mob/living/silicon/robot/has_anus(required_state = REQUIRE_GENITAL_ANY)
	if(!synthetic_anus)
		return FALSE
	switch(required_state)
		if(REQUIRE_GENITAL_EXPOSED)
			return !synthetic_genitals_hidden
		if(REQUIRE_GENITAL_UNEXPOSED)
			return synthetic_genitals_hidden
		else
			return TRUE

/mob/living/silicon/robot/has_balls(required_state = REQUIRE_GENITAL_ANY)
	return synthetic_balls

/// Cyborgs have manipulators, so treat their "hands" as always available for lewd interactions.
/mob/living/silicon/robot/has_arms(required_state = REQUIRE_GENITAL_ANY)
	return TRUE

/// Synthetic bodies are treated as exposed for lewd-slot purposes.
/mob/living/silicon/robot/is_topless()
	return TRUE

/mob/living/silicon/robot/is_bottomless()
	return !synthetic_genitals_hidden

/// Cyborgs don't use the human overlay system; keeping this as a no-op is fine for now.
/mob/living/silicon/robot/update_inv_lewd()
	return

/mob/living/silicon/robot/adjust_arousal(arous = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE

	arousal = clamp(arousal + arous, AROUSAL_MINIMUM, AROUSAL_LIMIT)

	if(!has_status_effect(/datum/status_effect/aroused) && arousal)
		apply_status_effect(/datum/status_effect/aroused)

	if(arousal < AROUSAL_LOW)
		if(!arousal)
			remove_status_effect(/datum/status_effect/aroused)

	return TRUE

/mob/living/silicon/robot/adjust_pain(change_amount = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	pain = clamp(pain + change_amount, AROUSAL_MINIMUM, AROUSAL_LIMIT)

/mob/living/silicon/robot/climax(manual = TRUE)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE

	if(has_status_effect(/datum/status_effect/climax_cooldown))
		return FALSE

	if(!has_penis() && !has_vagina())
		visible_message(span_purple("[src] twitches, but nothing happens."))
		return TRUE

	var/list/inrange_targets = list()
	for(var/mob/living/iterating_living in (view(1, src) - src))
		if(!ishuman(iterating_living) && !iscyborg(iterating_living))
			continue
		inrange_targets[iterating_living.name] = iterating_living

	var/mob/living/finish_target = null
	var/finish_inside = null

	if(manual && inrange_targets.len)
		var/finish_choice = tgui_alert(src, "Choose where to finish.", "Finish preference!", list("On the floor", "Climax in or on someone"))
		if(finish_choice == "Climax in or on someone")
			var/target_choice = tgui_input_list(src, "Choose a person to finish on.", "Choose target!", inrange_targets)
			if(target_choice)
				finish_target = inrange_targets[target_choice]
				var/target_them = finish_target.p_them()
				var/list/target_buttons = list("On [target_them]")
				if(finish_target.has_vagina(REQUIRE_GENITAL_EXPOSED))
					target_buttons += ORGAN_SLOT_VAGINA
				if(finish_target.has_anus(REQUIRE_GENITAL_EXPOSED))
					target_buttons += "asshole"
				if(ishuman(finish_target))
					var/mob/living/carbon/human/target_human = finish_target
					if(!target_human.wear_mask)
						target_buttons += "mouth"
				else if(iscyborg(finish_target))
					var/mob/living/silicon/robot/target_robot = finish_target
					if(target_robot.synthetic_penis && target_robot.synthetic_penis_sheathed)
						target_buttons += "sheath"
					if(target_robot.synthetic_penis && target_robot.synthetic_penis_slit)
						target_buttons += "slit"
				finish_inside = tgui_input_list(src, "Where on or in [finish_target] do you wish to finish?", "Final frontier!", target_buttons)
	else if(!manual)
		finish_target = (last_lewd_partner && (last_lewd_partner in view(1, src))) ? last_lewd_partner : null

	var/finish_target_them = finish_target ? finish_target.p_them() : null

	if(has_penis())
		if(finish_target)
			if(finish_inside && finish_inside != "On [finish_target_them]")
				visible_message(span_userlove("[src]'s synthetic phallus hilts into [finish_target]'s [finish_inside], filling it with synthetic cum!"))
				to_chat(finish_target, span_userlove("Your [finish_inside] fills with synthetic cum as [src] finishes!"))
				finish_target.add_cum(finish_inside == ORGAN_SLOT_VAGINA ? "vagina" : (finish_inside == "asshole" ? "anus" : "body"), LEWD_FLUID_SYNTH_CUM)
			else
				visible_message(span_userlove("[src]'s synthetic phallus twitches and sprays synthetic cum all over [finish_target]!"))
				to_chat(finish_target, span_userlove("[src] sprays you with a warm load of synthetic cum!"))
				finish_target.add_cum("body", LEWD_FLUID_SYNTH_CUM)
			new /obj/effect/decal/cleanable/cum/synthetic(get_turf(finish_target))
		else
			visible_message(span_userlove("[src]'s synthetic phallus twitches and spills a load of synthetic cum onto the floor!"))
			new /obj/effect/decal/cleanable/cum/synthetic(get_turf(src))

	if(has_vagina())
		if(finish_target)
			if(finish_inside && finish_inside != "On [finish_target_them]")
				visible_message(span_userlove("[src] sprays synthetic fem-cum into [finish_target]'s [finish_inside]!"))
				to_chat(finish_target, span_userlove("[src] fills your [finish_inside] with synthetic fem-cum!"))
				finish_target.add_cum(finish_inside == ORGAN_SLOT_VAGINA ? "vagina" : (finish_inside == "asshole" ? "anus" : "body"), LEWD_FLUID_SYNTH_FEMCUM)
			else
				visible_message(span_userlove("[src] shudders and sprays synthetic fem-cum all over [finish_target]!"))
				to_chat(finish_target, span_userlove("[src] sprays you with slick synthetic fem-cum!"))
				finish_target.add_cum("body", LEWD_FLUID_SYNTH_FEMCUM)
			new /obj/effect/decal/cleanable/cum/femcum/synthetic(get_turf(finish_target))
		else
			visible_message(span_userlove("[src] shudders as synthetic fem-cum drips out of [p_them()] onto the floor!"))
			new /obj/effect/decal/cleanable/cum/femcum/synthetic(get_turf(src))

	apply_status_effect(/datum/status_effect/climax)
	apply_status_effect(/datum/status_effect/climax_cooldown)
	// Drop arousal/pleasure immediately so auto-climax does not re-trigger and spray again.
	arousal = max(AROUSAL_MINIMUM, arousal - 12)
	pleasure = max(AROUSAL_MINIMUM, pleasure - 12)
	try_lewd_autoemote("beep")
	return TRUE

/mob/living/silicon/robot/proc/update_synthetic_breast_fluid()
	if(!synthetic_breasts)
		synthetic_breast_fluid = 0
		synthetic_breast_max_fluid = 0
		remove_status_effect(/datum/status_effect/body_fluid_regen/synthetic_breasts)
		return

	synthetic_breast_max_fluid = max(0, round((synthetic_breast_size - 1) * 15))
	synthetic_breast_fluid = clamp(synthetic_breast_fluid, 0, synthetic_breast_max_fluid)
	if(!has_status_effect(/datum/status_effect/body_fluid_regen/synthetic_breasts))
		apply_status_effect(/datum/status_effect/body_fluid_regen/synthetic_breasts)

/mob/living/silicon/robot/proc/get_genital_accessory_radial(slot)
	var/list/choices = list()
	var/list/accessories = SSaccessories.sprite_accessories[slot]
	if(!length(accessories))
		return choices
	for(var/accessory_name in assoc_to_keys_features(accessories))
		var/datum/sprite_accessory/accessory = accessories[accessory_name]
		choices[accessory_name] = image(accessory.icon, accessory.icon_state)
	return choices

/mob/living/silicon/robot/proc/get_synthetic_breast_fluid_name()
	var/static/list/fluid_names = list(
		/datum/reagent/consumable/milk = "milk",
		/datum/reagent/consumable/cream = "cream",
		/datum/reagent/consumable/soymilk = "soy milk",
		/datum/reagent/consumable/orangejuice = "orange juice",
	)
	return fluid_names[synthetic_breast_reagent] || "milk"

GAME_VERB_DESC(/mob/living/silicon/robot, configure_synthetic_anatomy, "Configure Synthetic Anatomy", "Toggle and customize your cyborg's synthetic genitals.", "Robot Commands")

	if(stat == DEAD)
		return

	if(!client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences))
		to_chat(src, span_warning("ERP preferences are disabled for you."))
		return

	var/list/options = list(
		"synthetic vagina: [synthetic_vagina ? "ON" : "OFF"]",
		"synthetic penis: [synthetic_penis ? "ON" : "OFF"]",
		"synthetic breasts: [synthetic_breasts ? "ON" : "OFF"]",
		"synthetic anus: [synthetic_anus ? "ON" : "OFF"]",
		"synthetic genitals hidden: [synthetic_genitals_hidden ? "ON" : "OFF"]",
		"synthetic testicles: [synthetic_balls ? "ON" : "OFF"]",
		"synthetic sheath: [synthetic_penis_sheathed ? "ON" : "OFF"]",
		"synthetic slit: [synthetic_penis_slit ? "ON" : "OFF"]",
		"synthetic penis type: [synthetic_penis_type]",
		"synthetic penis size: [synthetic_penis_size]",
		"synthetic penis girth: [synthetic_penis_girth]",
		"synthetic breast type: [synthetic_breast_type]",
		"synthetic breast size: [synthetic_breast_size]",
		"synthetic breast fluid: [get_synthetic_breast_fluid_name()]",
	)

	var/choice = tgui_input_list(src, "Toggle or customize a synthetic body part. Toggles persist to your preferences.", "Configure Synthetic Anatomy", options)
	if(!choice)
		return

	if(findtext(choice, "synthetic vagina"))
		synthetic_vagina = !synthetic_vagina
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_vagina], synthetic_vagina)
	else if(findtext(choice, "synthetic penis:"))
		synthetic_penis = !synthetic_penis
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_penis], synthetic_penis)
	else if(findtext(choice, "synthetic breasts:"))
		synthetic_breasts = !synthetic_breasts
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_breasts], synthetic_breasts)
		update_synthetic_breast_fluid()
	else if(findtext(choice, "synthetic anus"))
		synthetic_anus = !synthetic_anus
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/silicon_anus], synthetic_anus)
	else if(findtext(choice, "synthetic genitals hidden"))
		synthetic_genitals_hidden = !synthetic_genitals_hidden
	else if(findtext(choice, "synthetic testicles"))
		synthetic_balls = !synthetic_balls
	else if(findtext(choice, "synthetic sheath"))
		synthetic_penis_sheathed = !synthetic_penis_sheathed
		if(synthetic_penis_sheathed)
			synthetic_penis_slit = FALSE
	else if(findtext(choice, "synthetic slit"))
		synthetic_penis_slit = !synthetic_penis_slit
		if(synthetic_penis_slit)
			synthetic_penis_sheathed = FALSE
	else if(findtext(choice, "synthetic penis type"))
		var/list/penis_choices = get_genital_accessory_radial(ORGAN_SLOT_PENIS)
		if(!length(penis_choices))
			penis_choices = list(
				"human" = image('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi', "dildo_human"),
				"canine" = image('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi', "dildo_canine"),
				"equine" = image('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi', "dildo_equine"),
				"avian" = image('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi', "dildo_avian"),
				"tentacle" = image('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi', "dildo_tentacle"),
			)
		var/penis_type_choice = show_radial_menu(src, src, penis_choices, require_near = TRUE)
		if(penis_type_choice)
			synthetic_penis_type = penis_type_choice
	else if(findtext(choice, "synthetic penis size"))
		var/new_size = tgui_input_number(src, "Choose synthetic penis size (1-10).", "Synthetic Penis Size", synthetic_penis_size, 10, 1)
		if(!isnull(new_size))
			synthetic_penis_size = new_size
	else if(findtext(choice, "synthetic penis girth"))
		var/new_girth = tgui_input_number(src, "Choose synthetic penis girth (1-10).", "Synthetic Penis Girth", synthetic_penis_girth, 10, 1)
		if(!isnull(new_girth))
			synthetic_penis_girth = new_girth
	else if(findtext(choice, "synthetic breast type"))
		var/list/breast_choices = get_genital_accessory_radial(ORGAN_SLOT_BREASTS)
		if(!length(breast_choices))
			breast_choices = list(
				"pair" = image('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi', "breasts_pair"),
			)
		var/breast_type_choice = show_radial_menu(src, src, breast_choices, require_near = TRUE)
		if(breast_type_choice)
			synthetic_breast_type = breast_type_choice
	else if(findtext(choice, "synthetic breast size"))
		var/new_breast_size = tgui_input_number(src, "Choose synthetic breast size (1-10).", "Synthetic Breast Size", synthetic_breast_size, 10, 1)
		if(!isnull(new_breast_size))
			synthetic_breast_size = new_breast_size
			update_synthetic_breast_fluid()
	else if(findtext(choice, "synthetic breast fluid"))
		var/list/breast_fluids = list(
			"milk" = /datum/reagent/consumable/milk,
			"cream" = /datum/reagent/consumable/cream,
			"soy milk" = /datum/reagent/consumable/soymilk,
			"orange juice" = /datum/reagent/consumable/orangejuice,
		)
		var/fluid_choice = tgui_input_list(src, "Choose your synthetic breast fluid.", "Breast Fluid", breast_fluids)
		if(fluid_choice)
			synthetic_breast_reagent = breast_fluids[fluid_choice]

	update_inv_lewd()
	to_chat(src, span_notice("Synthetic anatomy updated."))

/datum/status_effect/body_fluid_regen/synthetic_breasts
	id = "synthetic breast fluid regen"

/datum/status_effect/body_fluid_regen/synthetic_breasts/tick(seconds_between_ticks)
	var/mob/living/silicon/robot/robot = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp) || !istype(robot))
		return FALSE

	if(!robot.synthetic_breasts)
		robot.remove_status_effect(/datum/status_effect/body_fluid_regen/synthetic_breasts)
		return FALSE

	robot.update_synthetic_breast_fluid()
	if(robot.synthetic_breast_fluid < robot.synthetic_breast_max_fluid)
		var/free_space = robot.synthetic_breast_max_fluid - robot.synthetic_breast_fluid
		robot.synthetic_breast_fluid += min(free_space, max(0.5, robot.synthetic_breast_max_fluid / 10))

