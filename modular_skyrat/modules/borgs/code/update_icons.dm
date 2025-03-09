/mob/living/silicon/robot/update_icons()
	icon = (model.cyborg_icon_override ? model.cyborg_icon_override : initial(icon))
	. = ..()
	/// Let's give custom borgs the ability to have flavor panels for their model
	if(opened && (TRAIT_R_UNIQUEPANEL in model.model_features))
		if(wiresexposed)
			add_overlay("[model.cyborg_base_icon]_w")
		else if(cell)
			add_overlay("[model.cyborg_base_icon]_c")
		else
			add_overlay("[model.cyborg_base_icon]_cl")
	update_altborg_icons()

	if(combat_indicator)
		add_overlay(GLOB.combat_indicator_overlay)

	if(temporary_flavor_text)
		add_overlay(GLOB.temporary_flavor_text_indicator)

/mob/living/silicon/robot/proc/update_altborg_icons()
	var/mutable_appearance/item_overlay
	var/list/items_with_sprites = list(
		/obj/item/melee/baton/security/loaded = list("dragon-sec", "baton"),
		/obj/item/borg/projectile_dampen = list("dragon-pk", "shield"),
		/obj/item/katana/ninja_blade = list("dragon-ninja", "katana"),
		/obj/item/kinetic_crusher = list("dragon-mining", "hammer"),
		/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg = list("dragon-mining", "pka"),
		/obj/item/melee/energy/sword/cyborg = list("dragon-syndi", "esword"),
		/obj/item/gun/energy/laser/cyborg = list("all-sec", "laser"),
		/obj/item/gun/energy/disabler/cyborg = list("all-sec", "disabler"),
		/obj/item/gun/energy/e_gun/advtaser/cyborg = list("all-sec", "disabler"),
	)
	for(var/obj/item/held_item as anything in held_items)
		if(isnull(held_item))
			continue
		var/list/item_icon_data = items_with_sprites[held_item.type]
		if(item_icon_data && (model.cyborg_base_icon == item_icon_data[1] || item_icon_data[1] == "all-sec"))
			item_overlay = mutable_appearance(model.cyborg_icon_override, item_icon_data[2], FLOAT_LAYER)
			break

	if(item_overlay)
		if(lamp_enabled || lamp_doom)
			SET_PLANE_EXPLICIT(item_overlay, ABOVE_LIGHTING_PLANE, src)
		else
			SET_PLANE_EXPLICIT(item_overlay, ABOVE_GAME_PLANE, src)
		add_overlay(item_overlay)


	//if(sleeper_g && model.sleeper_overlay)
	//	add_overlay("[model.sleeper_overlay]_g[sleeper_nv ? "_nv" : ""]")
	//if(sleeper_r && model.sleeper_overlay)
	//	add_overlay("[model.sleeper_overlay]_r[sleeper_nv ? "_nv" : ""]")
	if(robot_resting)
		if(stat != DEAD && can_rest())
			switch(robot_resting)
				if(ROBOT_REST_NORMAL)
					icon_state = "[model.cyborg_base_icon]-rest"
				if(ROBOT_REST_SITTING)
					icon_state = "[model.cyborg_base_icon]-sit"
				if(ROBOT_REST_BELLY_UP)
					icon_state = "[model.cyborg_base_icon]-bellyup"
				else
					icon_state = "[model.cyborg_base_icon]"
			cut_overlays()

			if(hat_overlay)  // Don't forget your hat
				add_overlay(hat_overlay)

			if(TRAIT_R_HAS_UNIQUE_RESTING_LIGHTS in model.model_features)
				add_overlay("[icon_state]_e")

	else
		icon_state = "[model.cyborg_base_icon]"

	if((TRAIT_R_UNIQUETIP in model.model_features) && (TRAIT_IMMOBILIZED in _status_traits))
		icon_state = "[model.cyborg_base_icon]-tipped"
		if(particles)
			dissipate()
		cut_overlays()

	if(stat == DEAD && (TRAIT_R_UNIQUEWRECK in model.model_features))
		icon_state = "[model.cyborg_base_icon]-wreck"


	update_appearance(UPDATE_OVERLAYS)
