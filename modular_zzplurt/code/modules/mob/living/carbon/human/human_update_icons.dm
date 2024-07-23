#define RESOLVE_ICON_STATE(worn_item) (worn_item.worn_icon_state || worn_item.icon_state)

/mob/living/carbon/human/regenerate_icons()
	. = ..()
	if(.)
		return
	update_worn_shirt()
	update_worn_underwear()
	update_worn_wrists()
	update_worn_ears_extra()
	update_worn_socks()

/mob/living/carbon/human/update_worn_underwear(update_obscured = TRUE)
	remove_overlay(UNDERWEAR_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_UNDERWEAR) + 1]
		inv.update_icon()

	if(istype(w_underwear, /obj/item/clothing/underwear/briefs))
		var/obj/item/clothing/underwear/briefs/undies = w_underwear
		update_hud_underwear(undies)

		if(update_obscured)
			update_obscured_slots(undies.flags_inv)

		if((check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_UNDERWEAR) || underwear_hidden())
			return

		var/target_overlay = undies.icon_state
		var/mutable_appearance/underwear_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/digi
		var/woman
		var/female_sprite_flags = w_underwear.female_sprite_flags
		var/mutant_styles = NONE
		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (undies.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = undies.worn_icon_digi || DIGITIGRADE_UNDERWEAR_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(undies.worn_icon_digi == undies.worn_icon)
				target_overlay += "_d"

		else if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, w_underwear, src)

		//Female sprites have lower priority than digitigrade sprites
		if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			// SKYRAT EDIT ADDITION END

		if(digi)
			mutant_styles |= STYLE_DIGI

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(undies)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE

		underwear_overlay = undies.build_worn_icon(
			default_layer = UNDERWEAR_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		if(undies.flags_1 & IS_PLAYER_COLORABLE_1)
			underwear_overlay.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(underwear_overlay)
		overlays_standing[UNDERWEAR_LAYER] = underwear_overlay
		apply_overlay(UNDERWEAR_LAYER)

	update_mutant_bodyparts()

/mob/living/carbon/human/update_worn_shirt(update_obscured = TRUE)
	remove_overlay(SHIRT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_SHIRT) + 1]
		inv.update_icon()

	if(istype(w_shirt, /obj/item/clothing/underwear/shirt))
		var/obj/item/clothing/underwear/shirt/undershirt = w_shirt
		update_hud_shirt(undershirt)

		if(update_obscured)
			update_obscured_slots(undershirt.flags_inv)

		if((check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_SHIRT) || undershirt_hidden())
			return

		var/target_overlay = undershirt.icon_state
		var/mutable_appearance/shirt_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/digi
		var/woman
		var/female_sprite_flags = w_shirt.female_sprite_flags
		var/mutant_styles = NONE
		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (undershirt.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = undershirt.worn_icon_digi || DIGITIGRADE_SHIRT_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(undershirt.worn_icon_digi == undershirt.worn_icon)
				target_overlay += "_d"

		else if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_SHIRT, w_shirt, src)

		//Female sprites have lower priority than digitigrade sprites
		if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			// SKYRAT EDIT ADDITION END

		if(digi)
			mutant_styles |= STYLE_DIGI

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(undershirt)))
			icon_file = DEFAULT_SHIRT_FILE
			handled_by_bodyshape = FALSE

		shirt_overlay = undershirt.build_worn_icon(
			default_layer = SHIRT_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		if(undershirt.flags_1 & IS_PLAYER_COLORABLE_1)
			shirt_overlay.color = undershirt_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_shirt_offset?.apply_offset(shirt_overlay)
		overlays_standing[SHIRT_LAYER] = shirt_overlay
		apply_overlay(SHIRT_LAYER)

	update_mutant_bodyparts()

/mob/living/carbon/human/update_worn_wrists(update_obscured = TRUE)
	remove_overlay(WRISTS_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_WRISTS) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_WRISTS) + 1]
		inv.update_icon()

	if(wrists)
		var/obj/item/worn_item = wrists
		update_hud_wrists(worn_item)

		if(update_obscured)
			update_obscured_slots(worn_item.flags_inv)

		if(check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_GLOVES)
			return

		var/icon_file = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'

		// SKYRAT EDIT ADDITION
		var/mutant_override = FALSE
		if(bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_WRISTS, wrists, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE
		// SKYRAT EDIT END

		var/mutable_appearance/wrists_overlay = wrists.build_worn_icon(default_layer = WRISTS_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null) // SKYRAT EDIT CHANGE

		overlays_standing[WRISTS_LAYER] = wrists_overlay
	apply_overlay(WRISTS_LAYER)

/mob/living/carbon/human/update_worn_ears_extra(update_obscured = TRUE)
	remove_overlay(EARS_EXTRA_LAYER)

	var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
	if(isnull(my_head)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EARS_RIGHT) + 1]
		inv.update_icon()

	if(ears)
		var/obj/item/worn_item = ears
		update_hud_ears(worn_item)

		if(update_obscured)
			update_obscured_slots(worn_item.flags_inv)

		if(check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_EARS_RIGHT)
			return

		var/icon_file = 'icons/mob/clothing/ears.dmi'

		// SKYRAT EDIT ADDITION
		var/mutant_override = FALSE
		if(bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_EARS, ears, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE
		// SKYRAT EDIT END

		var/mutable_appearance/ears_overlay = ears.build_worn_icon(default_layer = EARS_EXTRA_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null) // SKYRAT EDIT CHANGE

		// SKYRAT EDIT ADDITION
		if(!mutant_override)
			my_head.worn_ears_offset?.apply_offset(ears_overlay)
		// SKYRAT EDIT END
		overlays_standing[EARS_EXTRA_LAYER] = ears_overlay
	apply_overlay(EARS_EXTRA_LAYER)

/mob/living/carbon/human/update_worn_socks(update_obscured = TRUE)
	remove_overlay(SOCKS_LAYER)

	if(num_legs < 2)
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_SOCKS) + 1]
		inv.update_icon()

	if(istype(w_socks, /obj/item/clothing/underwear/socks))
		var/obj/item/clothing/underwear/socks/worn_item = w_socks
		update_hud_socks(worn_item)

		if(update_obscured)
			update_obscured_slots(worn_item.flags_inv)

		if((check_obscured_slots(transparent_protection = TRUE) & ITEM_SLOT_SOCKS) || socks_hidden())
			return

		var/target_overlay = worn_item.icon_state
		var/icon_file = DEFAULT_SOCKS_FILE

		// SKYRAT EDIT ADDITION START
		var/mutant_override = FALSE

		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (worn_item.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			var/obj/item/bodypart/leg = src.get_bodypart(BODY_ZONE_L_LEG)
			if(leg.limb_id == "digitigrade" || leg.bodyshape & BODYSHAPE_DIGITIGRADE)//Snowflakey and bad. But it makes it look consistent.
				icon_file = worn_item.worn_icon_digi || DIGITIGRADE_SOCKS_FILE // SKYRAT EDIT CHANGE
				mutant_override = TRUE // SKYRAT EDIT ADDITION

				// Edit for legacy sprites
				if(worn_item.worn_icon_digi == worn_item.worn_icon)
					target_overlay += "_d"
		if(!mutant_override && bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_SOCKS, w_socks, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE
		if(bodyshape & BODYSHAPE_HIDE_SHOES)
			return // We just don't want socks that float if we're not displaying legs (useful for taurs, for now)
		// SKYRAT EDIT END

		var/mutable_appearance/socks_overlay = w_socks.build_worn_icon(default_layer = SOCKS_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null) // SKYRAT EDIT CHANGE

		if(!socks_overlay)
			return

		var/feature_y_offset = 0
		for (var/body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
			var/obj/item/bodypart/leg/my_leg = get_bodypart(body_zone)
			if(isnull(my_leg))
				continue
			var/list/foot_offset = my_leg.worn_foot_offset?.get_offset()
			if (foot_offset && foot_offset["y"] > feature_y_offset)
				feature_y_offset = foot_offset["y"]

		if(worn_item.flags_1 & IS_PLAYER_COLORABLE_1)
			socks_overlay.color = socks_color

		socks_overlay.pixel_y += feature_y_offset
		overlays_standing[SOCKS_LAYER] = socks_overlay

	apply_overlay(SOCKS_LAYER)

	update_body_parts()

/mob/living/carbon/human/proc/update_hud_shirt(obj/item/worn_item)
	worn_item.screen_loc = ui_shirt
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_underwear(obj/item/worn_item)
	worn_item.screen_loc = ui_boxers
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_wrists(obj/item/worn_item)
	worn_item.screen_loc = ui_wrists
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_ears_extra(obj/item/worn_item)
	worn_item.screen_loc = ui_ears_extra
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_socks(obj/item/worn_item)
	worn_item.screen_loc = ui_socks
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

#undef RESOLVE_ICON_STATE
