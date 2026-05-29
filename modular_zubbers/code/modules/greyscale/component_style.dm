/datum/greyscale_component_style
	/// Marker used when loadout storage needs to preserve an intentionally empty accessory selection.
	var/static/no_accessories_marker = "__component_style_no_accessories"

/datum/greyscale_component_style
	/// Icon state inserted into generated icon files.
	var/output_icon_state
	/// Fallback component state to use if every selected component is missing.
	var/fallback_icon_state
	/// Suffix checked first for digitigrade component states.
	var/digi_suffix = "_digi"
	/// Ordered list of core component definitions.
	var/list/core_components = list()
	/// Optional component definitions, keyed by display name.
	var/list/accessories = list()
	/// Component state to color group index.
	var/list/component_color_ids = list()
	/// Color group labels, keyed by color group index.
	var/list/color_labels = list()
	/// Optional accessory component states enabled by default.
	var/list/default_accessories = list()
	/// Suffix checked first for adjusted/casual component states.
	var/adjusted_suffix = "_d"

/datum/greyscale_component_style/proc/default_core_selection() as /list
	var/list/selection = list()
	for(var/list/core_component as anything in core_components)
		selection[core_component["key"]] = core_component["default"]
	return selection

/datum/greyscale_component_style/proc/sanitize_core_selection(list/selected_cores) as /list
	var/list/sanitized = list()
	for(var/list/core_component as anything in core_components)
		var/core_key = core_component["key"]
		var/selected_state = selected_cores?[core_key] || core_component["default"]
		if(!core_option_exists(core_component, selected_state))
			selected_state = core_component["default"]
		sanitized[core_key] = selected_state
	return sanitized

/datum/greyscale_component_style/proc/sanitize_accessories(list/selected_accessories, list/selected_cores) as /list
	var/list/sanitized = list()
	if(!islist(selected_accessories) || (no_accessories_marker in selected_accessories))
		return sanitized
	for(var/accessory in selected_accessories)
		if(!accessory_allowed(accessory, selected_cores))
			continue
		sanitized += accessory
	return sanitized

/datum/greyscale_component_style/proc/core_option_exists(list/core_component, option_state)
	var/list/options = core_component["options"]
	for(var/option_name in options)
		if(options[option_name] == option_state)
			return TRUE
	return FALSE

/datum/greyscale_component_style/proc/core_ui_data(list/selected_cores) as /list
	var/list/core_data = list()
	for(var/list/core_component as anything in core_components)
		var/core_key = core_component["key"]
		core_data += list(list(
			"name" = core_component["name"],
			"key" = core_key,
			"options" = option_ui_data(core_component["options"], selected_cores[core_key]),
		))
	return core_data

/datum/greyscale_component_style/proc/option_ui_data(list/options, selected_value) as /list
	var/list/style_options = list()
	for(var/option_name in options)
		style_options += list(list(
			"name" = option_name,
			"value" = options[option_name],
			"selected" = (options[option_name] == selected_value),
		))
	return style_options

/datum/greyscale_component_style/proc/accessory_ui_data(list/selected_accessories, list/selected_cores) as /list
	var/list/style_options = list()
	for(var/accessory_name in accessories)
		var/list/accessory_rules = accessories[accessory_name]
		var/accessory_state = accessory_rules["state"]
		if(!accessory_allowed(accessory_state, selected_cores))
			continue
		style_options += list(list(
			"name" = accessory_name,
			"value" = accessory_state,
			"selected" = (accessory_state in selected_accessories),
		))
	return style_options

/datum/greyscale_component_style/proc/accessory_allowed(accessory_state, list/selected_cores)
	var/list/accessory_rules = accessory_rules_for_state(accessory_state)
	if(isnull(accessory_rules))
		return FALSE

	var/list/allowed_cores = accessory_rules["cores"]
	if(!length(allowed_cores))
		return TRUE

	for(var/core_key in allowed_cores)
		var/list/allowed_states = allowed_cores[core_key]
		if(length(allowed_states) && !(selected_cores?[core_key] in allowed_states))
			return FALSE
	return TRUE

/datum/greyscale_component_style/proc/accessory_rules_for_state(accessory_state) as /list
	for(var/accessory_name in accessories)
		var/list/accessory_rules = accessories[accessory_name]
		if(accessory_rules["state"] == accessory_state)
			return accessory_rules
	return null

/datum/greyscale_component_style/proc/active_components(list/selected_cores, list/selected_accessories) as /list
	var/list/components = list()
	for(var/list/core_component as anything in core_components)
		var/component_state = selected_cores?[core_component["key"]]
		if(component_state)
			components += component_state
	if(islist(selected_accessories))
		for(var/accessory_state in selected_accessories)
			if(!accessory_state)
				continue
			components += accessory_state
	return components

/datum/greyscale_component_style/proc/color_id_for_component(component_state)
	return component_color_ids[component_state]

/datum/greyscale_component_style/proc/active_color_ids(list/selected_cores, list/selected_accessories) as /list
	var/list/active_color_ids = list()
	for(var/component in active_components(selected_cores, selected_accessories))
		var/color_id = color_id_for_component(component)
		if(!color_id || (color_id in active_color_ids))
			continue
		active_color_ids += color_id
	return active_color_ids

/datum/greyscale_component_style/proc/active_color_labels(list/selected_cores, list/selected_accessories) as /list
	var/list/labels = list()
	var/list/active_color_ids = active_color_ids(selected_cores, selected_accessories)
	for(var/color_id in active_color_ids)
		var/color_label = color_labels["[color_id]"]
		if(!color_label && length(color_labels) >= color_id)
			color_label = color_labels[color_id]
		if(!color_label)
			continue
		labels["[color_id]"] = color_label
	return labels

/datum/greyscale_component_style/proc/build_icon(icon_file, list/colors, list/selected_cores, list/selected_accessories, use_digi = FALSE, digi_fallback_icon_file = null, only_dir = null, list/state_overrides = null, use_adjusted = FALSE)
	var/icon/final_icon = icon('icons/effects/effects.dmi', "nothing")
	final_icon.Scale(32, 32)
	if(!icon_file)
		return final_icon

	var/icon/built_icon
	for(var/component in active_components(selected_cores, selected_accessories))
		if(!component)
			continue
		var/layer_file = icon_file
		var/state_to_use = component
		if(islist(state_overrides))
			state_to_use = state_overrides[component] || component

		var/list/candidate_states = list()
		if(use_digi && use_adjusted)
			candidate_states += "[state_to_use][digi_suffix][adjusted_suffix]"
		if(use_adjusted)
			candidate_states += "[state_to_use][adjusted_suffix]"
		if(use_digi)
			candidate_states += "[state_to_use][digi_suffix]"
		candidate_states += state_to_use

		var/list/candidate_files = list(layer_file)
		if(use_digi && digi_fallback_icon_file)
			candidate_files += digi_fallback_icon_file

		var/found_component_state = FALSE
		for(var/candidate_state in candidate_states)
			for(var/candidate_file in candidate_files)
				if(!icon_exists(candidate_file, candidate_state))
					continue
				layer_file = candidate_file
				state_to_use = candidate_state
				found_component_state = TRUE
				break
			if(found_component_state)
				break

		if(!found_component_state)
			continue

		var/icon/component_icon = isnull(only_dir) ? icon(layer_file, state_to_use) : icon(layer_file, state_to_use, only_dir)
		var/color_id = color_id_for_component(component)
		if(color_id && length(colors) >= color_id && colors[color_id])
			component_icon.Blend(colors[color_id], ICON_MULTIPLY)

		if(isnull(built_icon))
			built_icon = component_icon
		else
			built_icon.Blend(component_icon, ICON_OVERLAY)

	if(isnull(built_icon) && fallback_icon_state)
		built_icon = isnull(only_dir) ? icon(icon_file, fallback_icon_state) : icon(icon_file, fallback_icon_state, only_dir)

	if(!isnull(built_icon))
		var/generated_icon_state = use_adjusted ? "[output_icon_state][adjusted_suffix]" : output_icon_state
		final_icon.Insert(built_icon, generated_icon_state)
	return final_icon

/obj/item
	/// Optional component-style GAGS definition used for layered, selectable components.
	var/greyscale_component_style_type
	/// Selected core component states, keyed by core component id.
	var/list/greyscale_component_cores
	/// Selected optional component states.
	var/list/greyscale_component_accessories
	/// Object icon file used for component-style GAGS composition.
	var/greyscale_component_icon_file
	/// Worn icon file used for component-style GAGS composition.
	var/greyscale_component_worn_icon_file
	/// Digitigrade worn icon file used for component-style GAGS composition.
	var/greyscale_component_worn_digi_icon_file
	/// Optional non-digi worn icon fallback for missing digitigrade component states.
	var/greyscale_component_digi_fallback_icon_file
	/// Whether component-style worn icons should use adjusted/casual component states.
	var/greyscale_component_use_adjusted = FALSE
	/// Optional logical component state to worn icon state mapping.
	var/list/greyscale_component_worn_state_overrides
	/// Optional logical component state to digitigrade worn icon state mapping.
	var/list/greyscale_component_worn_digi_state_overrides

/obj/item/proc/get_greyscale_component_style() as /datum/greyscale_component_style
	if(!greyscale_component_style_type)
		return null
	return new greyscale_component_style_type

/obj/item/proc/initialize_greyscale_component_style()
	var/datum/greyscale_component_style/component_style = get_greyscale_component_style()
	if(!component_style)
		return
	greyscale_component_cores = component_style.sanitize_core_selection(greyscale_component_cores)
	var/list/accessories_to_apply = isnull(greyscale_component_accessories) ? component_style.default_accessories : greyscale_component_accessories
	greyscale_component_accessories = component_style.sanitize_accessories(accessories_to_apply, greyscale_component_cores)
	qdel(component_style)

/obj/item/proc/apply_greyscale_component_style(list/item_details)
	var/datum/greyscale_component_style/component_style = get_greyscale_component_style()
	if(!component_style)
		return
	greyscale_component_cores = component_style.sanitize_core_selection(item_details?[INFO_GREYSCALE_COMPONENT_CORES] || greyscale_component_cores)
	var/list/accessories_to_apply = item_details?[INFO_GREYSCALE_COMPONENT_ACCESSORIES]
	if(isnull(accessories_to_apply))
		accessories_to_apply = isnull(greyscale_component_accessories) ? component_style.default_accessories : greyscale_component_accessories
	greyscale_component_accessories = component_style.sanitize_accessories(accessories_to_apply, greyscale_component_cores)
	qdel(component_style)
	update_greyscale()

/obj/item/proc/update_greyscale_component_icons()
	var/datum/greyscale_component_style/component_style = get_greyscale_component_style()
	if(!component_style || !greyscale_colors)
		qdel(component_style)
		return

	var/list/colors = SSgreyscale.ParseColorString(greyscale_colors)
	icon_state = component_style.output_icon_state
	worn_icon_state = greyscale_component_use_adjusted ? "[component_style.output_icon_state][component_style.adjusted_suffix]" : component_style.output_icon_state
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	if(greyscale_component_icon_file)
		icon = component_style.build_icon(greyscale_component_icon_file, colors, greyscale_component_cores, greyscale_component_accessories)
	if(greyscale_component_worn_icon_file)
		worn_icon = component_style.build_icon(greyscale_component_worn_icon_file, colors, greyscale_component_cores, greyscale_component_accessories, state_overrides = greyscale_component_worn_state_overrides, use_adjusted = greyscale_component_use_adjusted)
	if(greyscale_component_worn_digi_icon_file)
		worn_icon_digi = component_style.build_icon(greyscale_component_worn_digi_icon_file, colors, greyscale_component_cores, greyscale_component_accessories, use_digi = TRUE, digi_fallback_icon_file = greyscale_component_digi_fallback_icon_file, state_overrides = greyscale_component_worn_digi_state_overrides || greyscale_component_worn_state_overrides, use_adjusted = greyscale_component_use_adjusted)
	qdel(component_style)

	var/obj/item/clothing/worn_clothing = src
	if(!istype(worn_clothing))
		return

	var/mob/living/carbon/human/wearer = worn_clothing.loc
	if(!istype(wearer))
		return
	wearer.update_clothing(worn_clothing.slot_flags)

/obj/item/clothing/under/adjust_to_normal()
	. = ..()
	if(!greyscale_component_style_type)
		return
	greyscale_component_use_adjusted = FALSE
	update_greyscale_component_icons()

/obj/item/clothing/under/adjust_to_alt()
	. = ..()
	if(!greyscale_component_style_type)
		return
	greyscale_component_use_adjusted = TRUE
	update_greyscale_component_icons()

/datum/loadout_item/proc/uses_greyscale_component_style()
	return !!initial(item_path.greyscale_component_style_type)

/// Opens a component-style GAGS editing menu when the loadout item supports it.
/datum/loadout_item/proc/set_component_style_item_color(datum/preference_middleware/loadout/manager, mob/user)
	if(manager.menu)
		return FALSE

	var/list/loadout = manager.get_current_loadout()
	var/list/allowed_configs = list()
	if(initial(item_path.greyscale_config_worn))
		allowed_configs += "[initial(item_path.greyscale_config_worn)]"
	else if(initial(item_path.greyscale_config))
		allowed_configs += "[initial(item_path.greyscale_config)]"

	var/list/selected_cores = loadout?[item_path]?[INFO_GREYSCALE_COMPONENT_CORES]
	if(isnull(selected_cores))
		selected_cores = initial(item_path.greyscale_component_cores)

	var/list/selected_accessories = loadout?[item_path]?[INFO_GREYSCALE_COMPONENT_ACCESSORIES]
	if(islist(selected_accessories) && (/datum/greyscale_component_style::no_accessories_marker in selected_accessories))
		selected_accessories = list()

	var/starting_config = initial(item_path.greyscale_config_worn) || initial(item_path.greyscale_config)
	var/starting_colors = loadout?[item_path]?[INFO_GREYSCALE] || initial(item_path.greyscale_colors)
	var/datum/greyscale_config/selected_config = SSgreyscale.configurations["[starting_config]"]
	if(selected_config && length(SSgreyscale.ParseColorString(starting_colors)) != selected_config.expected_colors)
		starting_colors = initial(item_path.greyscale_colors)

	var/datum/greyscale_modify_menu/component_style/menu = new(
		manager,
		user,
		allowed_configs,
		CALLBACK(src, PROC_REF(set_slot_greyscale), manager),
		starting_icon_state = initial(item_path.icon_state),
		starting_config = starting_config,
		starting_colors = starting_colors,
		component_style_type = initial(item_path.greyscale_component_style_type),
		selected_cores = selected_cores,
		selected_accessories = selected_accessories,
		preview_icon_file = initial(item_path.greyscale_component_worn_icon_file) || initial(item_path.greyscale_component_icon_file),
		preview_digi_fallback_icon_file = initial(item_path.greyscale_component_digi_fallback_icon_file),
		preview_state_overrides = initial(item_path.greyscale_component_worn_icon_file) ? initial(item_path.greyscale_component_worn_state_overrides) : null,
		default_colors = initial(item_path.greyscale_colors),
		default_cores = initial(item_path.greyscale_component_cores),
		default_accessories = null,
	)

	manager.register_greyscale_menu(menu)
	menu.ui_interact(user)
	return TRUE

/// Saves component-style GAGS color and component state.
/datum/loadout_item/proc/set_component_style_slot_greyscale(datum/preference_middleware/loadout/manager, datum/greyscale_modify_menu/open_menu)
	var/datum/greyscale_modify_menu/component_style/component_menu = open_menu
	if(!istype(component_menu))
		return FALSE

	var/list/loadout = manager.get_current_loadout()
	if(!loadout?[item_path])
		return FALSE

	var/list/colors = component_menu.split_colors
	if(!colors)
		return FALSE

	loadout[item_path][INFO_GREYSCALE] = colors.Join("")
	loadout[item_path][INFO_GREYSCALE_COMPONENT_CORES] = component_menu.selected_cores.Copy()
	loadout[item_path][INFO_GREYSCALE_COMPONENT_ACCESSORIES] = length(component_menu.selected_accessories) ? component_menu.selected_accessories.Copy() : list(/datum/greyscale_component_style::no_accessories_marker)
	manager.save_current_loadout(loadout)
	return TRUE

/datum/loadout_item/proc/apply_component_style_to_equipped_item(obj/item/equipped_item, list/item_details)
	if(equipped_item?.greyscale_component_style_type)
		equipped_item.apply_greyscale_component_style(item_details)

/datum/loadout_item/proc/get_component_style_preview_image()
	var/component_style_type = initial(item_path.greyscale_component_style_type)
	if(!component_style_type)
		return null
	var/datum/greyscale_component_style/component_style = new component_style_type
	var/list/default_cores = component_style.sanitize_core_selection(initial(item_path.greyscale_component_cores))
	var/list/default_accessories = component_style.default_accessories
	default_accessories = component_style.sanitize_accessories(default_accessories, default_cores)
	var/list/default_colors = SSgreyscale.ParseColorString(initial(item_path.greyscale_colors))
	var/preview_icon_file = initial(item_path.greyscale_component_worn_icon_file) || initial(item_path.greyscale_component_icon_file)
	var/list/preview_state_overrides = initial(item_path.greyscale_component_worn_icon_file) ? initial(item_path.greyscale_component_worn_state_overrides) : null
	var/icon/south_preview_icon = component_style.build_icon(preview_icon_file, default_colors, default_cores, default_accessories, only_dir = SOUTH, state_overrides = preview_state_overrides)
	var/icon/single_frame_preview = icon(south_preview_icon, component_style.output_icon_state, SOUTH, 1)
	qdel(component_style)
	return icon2base64(single_frame_preview)

/datum/loadout_item/proc/add_component_style_preview_to_ui_data(list/formatted_item)
	if(!uses_greyscale_component_style())
		return
	formatted_item["image"] = get_component_style_preview_image()

/datum/greyscale_modify_menu/component_style
	var/datum/greyscale_component_style/component_style
	var/component_style_type
	var/list/selected_cores
	var/list/selected_accessories
	var/preview_icon_file
	var/preview_use_digi = FALSE
	var/preview_digi_fallback_icon_file
	var/list/preview_state_overrides
	var/list/default_colors
	var/list/default_cores
	var/list/default_accessories

/datum/greyscale_modify_menu/component_style/New(datum/target, client/user, list/allowed_configs, datum/callback/apply_callback, starting_icon_state = "", starting_config, starting_colors, unlocked = FALSE, component_style_type = null, list/selected_cores = null, list/selected_accessories = null, preview_icon_file = null, preview_use_digi = FALSE, preview_digi_fallback_icon_file = null, list/preview_state_overrides = null, default_colors = null, list/default_cores = null, list/default_accessories = null)
	src.component_style_type = component_style_type || /datum/greyscale_component_style
	var/style_type = src.component_style_type
	src.component_style = new style_type
	src.selected_cores = component_style.sanitize_core_selection(selected_cores)
	if(isnull(selected_accessories))
		selected_accessories = component_style.default_accessories
	src.selected_accessories = component_style.sanitize_accessories(selected_accessories, src.selected_cores)
	src.preview_icon_file = preview_icon_file
	src.preview_use_digi = preview_use_digi
	src.preview_digi_fallback_icon_file = preview_digi_fallback_icon_file
	src.preview_state_overrides = preview_state_overrides
	src.default_colors = SSgreyscale.ParseColorString(default_colors || starting_colors)
	src.default_cores = component_style.sanitize_core_selection(default_cores)
	if(isnull(default_accessories))
		default_accessories = component_style.default_accessories
	src.default_accessories = component_style.sanitize_accessories(default_accessories, src.default_cores)
	sprite_data = list(
		"icon_states" = list(component_style.output_icon_state),
		"finished" = null,
		"steps" = list(),
		"time_spent" = 0,
	)
	update_component_color_labels()
	return ..()

/datum/greyscale_modify_menu/component_style/Destroy()
	QDEL_NULL(component_style)
	selected_cores = null
	selected_accessories = null
	preview_state_overrides = null
	default_colors = null
	default_cores = null
	default_accessories = null
	return ..()

/datum/greyscale_modify_menu/component_style/ReadColorsFromString(colorString)
	if(..())
		return TRUE
	normalize_split_colors()
	return TRUE

/datum/greyscale_modify_menu/component_style/ui_data(mob/user)
	normalize_split_colors()
	var/list/data = list()
	data["greyscale_config"] = "[config.name]"
	data["full_color_string"] = split_colors.Join("")

	var/list/active_color_ids = component_style.active_color_ids(selected_cores, selected_accessories)
	var/list/active_colors = list()
	for(var/i in 1 to config.expected_colors)
		if(!(i in active_color_ids))
			continue
		active_colors += list(list(
			"index" = i,
			"label" = color_labels?["[i]"],
			"value" = (length(split_colors) >= i) ? split_colors[i] : rgb(100, 100, 100),
		))
	data["colors"] = active_colors

	data["generate_full_preview"] = generate_full_preview
	data["unlocked"] = unlocked
	data["refreshing"] = refreshing
	data["monitoring_files"] = !!(config.datum_flags & DF_ISPROCESSING)
	data["sprites_dir"] = dir2text(sprite_dir)
	data["icon_state"] = icon_state
	data["sprites"] = sprite_data || list(
		"icon_states" = list(component_style.output_icon_state),
		"finished" = null,
		"steps" = list(),
		"time_spent" = 0,
	)
	data["hide_full_color_string"] = FALSE
	data["component_style"] = list(
		"core_components" = component_style.core_ui_data(selected_cores),
		"accessories" = component_style.accessory_ui_data(selected_accessories, selected_cores),
	)
	return data

/datum/greyscale_modify_menu/component_style/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	switch(action)
		if("component_style_set_core")
			var/core_component = params["component"]
			var/new_style = params["value"]
			if(!set_core_component(core_component, new_style))
				return TRUE
			queue_refresh()
			return TRUE

		if("component_style_toggle_accessory")
			var/accessory = params["accessory"]
			if(!component_style.accessory_allowed(accessory, selected_cores))
				return TRUE
			if(accessory in selected_accessories)
				selected_accessories -= accessory
			else
				selected_accessories += accessory
			update_component_color_labels()
			queue_refresh()
			return TRUE

		if("random_all_colors")
			for(var/color_id in component_style.active_color_ids(selected_cores, selected_accessories))
				randomize_color(color_id)
			queue_refresh()
			return TRUE

		if("component_style_reset_color")
			var/color_id = text2num(params["color_index"])
			if(color_id && length(default_colors) >= color_id)
				normalize_split_colors()
				split_colors[color_id] = default_colors[color_id]
				queue_refresh()
			return TRUE

		if("component_style_reset_all")
			selected_cores = default_cores.Copy()
			selected_accessories = default_accessories.Copy()
			split_colors = islist(default_colors) ? default_colors.Copy() : list()
			normalize_split_colors()
			update_component_color_labels()
			queue_refresh()
			return TRUE

	return ..()

/datum/greyscale_modify_menu/component_style/proc/set_core_component(core_key, new_style)
	for(var/list/core_component as anything in component_style.core_components)
		if(core_component["key"] != core_key)
			continue
		if(!component_style.core_option_exists(core_component, new_style))
			return FALSE
		selected_cores[core_key] = new_style
		prune_invalid_accessories()
		update_component_color_labels()
		return TRUE
	return FALSE

/datum/greyscale_modify_menu/component_style/proc/prune_invalid_accessories()
	selected_accessories = component_style.sanitize_accessories(selected_accessories, selected_cores)

/datum/greyscale_modify_menu/component_style/proc/update_component_color_labels()
	color_labels = component_style.active_color_labels(selected_cores, selected_accessories)

/datum/greyscale_modify_menu/component_style/proc/normalize_split_colors()
	if(!config)
		return
	if(!islist(split_colors))
		split_colors = list()
	if(length(split_colors) > config.expected_colors)
		split_colors.Cut(config.expected_colors + 1)
	while(length(split_colors) < config.expected_colors)
		var/next_color_index = length(split_colors) + 1
		split_colors += (islist(default_colors) && length(default_colors) >= next_color_index) ? default_colors[next_color_index] : rgb(100, 100, 100)

/datum/greyscale_modify_menu/component_style/refresh_preview()
	normalize_split_colors()
	var/list/used_colors = split_colors.Copy(1, config.expected_colors + 1)

	sprite_data = list()
	sprite_data["icon_states"] = list(component_style.output_icon_state)
	icon_state = component_style.output_icon_state

	var/time_spent = TICK_USAGE
	var/icon/preview_icon = component_style.build_icon(preview_icon_file, used_colors, selected_cores, selected_accessories, preview_use_digi, preview_digi_fallback_icon_file, only_dir = sprite_dir, state_overrides = preview_state_overrides)
	var/image/finished = image(preview_icon, icon_state = icon_state)
	time_spent = TICK_USAGE - time_spent

	sprite_data["time_spent"] = TICK_DELTA_TO_MS(time_spent)
	sprite_data["finished"] = icon2html(finished, user, dir = sprite_dir, sourceonly = TRUE)
	sprite_data["steps"] = list()
	refreshing = FALSE
