// Moved from modular skyrat so I can find these more easily.
// Also, these function somewhat differently from the SR ones.

/// The required list size for crop parameters in generate_icon.
#define REQUIRED_CROP_LIST_SIZE 4

/datum/preference/choiced/mutant
	abstract_type = /datum/preference/choiced/mutant
	category = PREFERENCE_CATEGORY_BUBBER_MUTANT_FEATURE
	savefile_identifier = PREFERENCE_CHARACTER
	should_generate_icons = TRUE

	var/default_accessory_name = SPRITE_ACCESSORY_NONE
	/// The global list containing the sprite accessories to use.
	var/list/sprite_accessory
	/// Direction to render the preview on. Can take NORTH, SOUTH, EAST, WEST.
	var/sprite_direction = SOUTH
	/// A list of types to exclude, including their subtypes.
	var/list/accessories_to_ignore

	/// A color to apply to the icon if it's greyscale, and `generate_icons` is enabled.
	var/greyscale_color

	var/type_to_check

/datum/preference/choiced/mutant/New()
	. = ..()

	var/key = replacetext(savefile_key, "feature_", "")
	// Lazy coder's joy
	if (!islist(supplemental_features))
		supplemental_features = list(
			"[key]_color",
			"[key]_emissive",
		)

	sprite_accessory = SSaccessories.sprite_accessories[relevant_mutant_bodypart]

/datum/preference/choiced/mutant/create_default_value()
	return default_accessory_name

/datum/preference/choiced/mutant/is_accessible(datum/preferences/preferences, check_page = TRUE)
	var/species_allows_part = ..() // The parent check checks if the species has the part, and if the player's looking on the right page.

	if(!species_allows_part && !preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts))
		return FALSE

	return !type_to_check || preferences.read_preference(type_to_check)

/datum/preference/choiced/mutant/init_possible_values()
	return generate_mutant_valid_values(sprite_accessory, accessories_to_ignore)

/// Apply this preference onto the given human.
/// May be overriden by subtypes.
/// Called when the savefile_identifier == PREFERENCE_CHARACTER.
///
/// Returns whether the bodypart is actually visible.
/datum/preference/choiced/mutant/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	// body part is not the default/none value.
	var/bodypart_is_visible = preferences && is_accessible(preferences, FALSE)

	if(!bodypart_is_visible)
		value = create_default_value()

	if(value == "None")
		return bodypart_is_visible

	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = value, MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
		return bodypart_is_visible

	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value
	return bodypart_is_visible

/// Automatically handles generating icon states and values for mutant parts.
/datum/preference/choiced/mutant/proc/generate_mutant_valid_values(list/accessories, accessories_to_ignore = null)
	var/list/data = list()

	for(var/datum/sprite_accessory/accessory as anything in accessories)
		accessory = accessories[accessory]
		if(!accessory || !accessory.name || accessory.locked)
			continue

		if(islist(accessories_to_ignore))
			for(var/path in accessories_to_ignore)
				if(istype(accessory, path))
					continue

		data += initial(accessory.name)

	return data

/// Allows for dynamic assigning of icon states.
/// Can be a list or text.
/datum/preference/choiced/mutant/proc/generate_icon_states(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	return "m_[relevant_mutant_bodypart]_[original_icon_state]_$layer[suffix]"

/// Generates and allows for post-processing on icons, such as greyscaling and cropping.
/datum/preference/choiced/mutant/proc/generate_icon(datum/sprite_accessory/sprite_accessory, dir = SOUTH)
	if(!sprite_accessory.icon_state || sprite_accessory.name == SPRITE_ACCESSORY_NONE)
		return icon('icons/mob/landmarks.dmi', "x")

	var/icon/human_icon = sprite_accessory.get_base_preview_icon()
	if (human_icon)
		human_icon = icon(human_icon, human_icon.IconStates()[1], sprite_direction, 1)

	var/list/icon_state_templates_to_use = list()

	if(sprite_accessory.color_src == USE_MATRIXED_COLORS)
		for(var/index in sprite_accessory.color_layer_names)
			icon_state_templates_to_use += generate_icon_states(sprite_accessory, sprite_accessory.icon_state, "_[sprite_accessory.color_layer_names[index]]")
	else
		icon_state_templates_to_use += generate_icon_states(sprite_accessory, sprite_accessory.icon_state)

	var/list/icon_states_to_use = list()
	var/list/behind_icon_states_to_use = list()

	var/color
	if (BODY_BEHIND_LAYER in sprite_accessory.relevent_layers)
		color = sanitize_hexcolor(greyscale_color)
		for (var/state in icon_state_templates_to_use)
			state = replacetext(state, "$layer", "BEHIND")
			if (icon_exists(sprite_accessory.icon, state))
				behind_icon_states_to_use[state] = color
			color = "#[darken_color(darken_color(copytext(color, 2)))]"

	for (var/layer in (sprite_accessory.relevent_layers - BODY_BEHIND_LAYER))
		color = sanitize_hexcolor(greyscale_color)
		var/explosive = convert_layer_to_text(layer)
		for(var/state in icon_state_templates_to_use)
			state = replacetext(state, "$layer", explosive)
			if (icon_exists(sprite_accessory.icon, state))
				icon_states_to_use[state] = color
			color = "#[darken_color(darken_color(copytext(color, 2)))]"

	var/icon/base = icon('modular_zubbers/icons/customization/template.dmi', "blank_template", SOUTH, 1)
	if (behind_icon_states_to_use.len || icon_states_to_use.len)
		// Hate.
		var/icon/i_need_just_your_size_fuck = icon(sprite_accessory.icon, (behind_icon_states_to_use + icon_states_to_use)[1], sprite_direction, 1)
		base.Scale(i_need_just_your_size_fuck.Width(), i_need_just_your_size_fuck.Height())
	if (!base || base.Width() < 32 || base.Height() < 32) // Fucking sprite accessory bullshit
		base = icon('modular_zubbers/icons/customization/template.dmi', "blank_template", SOUTH, 1)

	var/human_body_offset = round((base.Width()/2) - 15)

	for(var/icon_state in behind_icon_states_to_use)
		var/icon/icon_to_process = icon(sprite_accessory.icon, icon_state, sprite_direction, 1)

		if(greyscale_color && sprite_accessory.color_src)
			icon_to_process.Blend(behind_icon_states_to_use[icon_state], ICON_MULTIPLY)

		// THIS DOESN'T WORK. HI WINGS, YOU SUCK.
		// if (sprite_accessory.center)
		// 	center_blend_icon(base, icon_to_process, sprite_accessory.dimension_x, sprite_accessory.dimension_y)
		// else if (istype(sprite_accessory, /datum/sprite_accessory/wings))
		// 	base.Blend(icon_to_process, ICON_OVERLAY, human_body_offset) // Fucking wings.
		// else
		base.Blend(icon_to_process, ICON_OVERLAY)

	if (human_icon)
		base.Blend(human_icon, ICON_OVERLAY, human_body_offset, 1)

	for(var/icon_state in icon_states_to_use)
		var/icon/icon_to_process = icon(sprite_accessory.icon, icon_state, sprite_direction, 1)

		if(greyscale_color && sprite_accessory.color_src)
			icon_to_process.Blend(icon_states_to_use[icon_state], ICON_MULTIPLY)

		// THIS DOESN'T WORK. HI WINGS, YOU SUCK.
		// if (sprite_accessory.center)
		// 	center_blend_icon(base, icon_to_process, sprite_accessory.dimension_x, sprite_accessory.dimension_y)
		// else if (istype(sprite_accessory, /datum/sprite_accessory/wings))
		// 	base.Blend(icon_to_process, ICON_OVERLAY, human_body_offset) // Fucking wings.
		// else
		base.Blend(icon_to_process, ICON_OVERLAY)

	var/list/crop_area = sprite_accessory.crop_area
	if(islist(crop_area) && crop_area.len == REQUIRED_CROP_LIST_SIZE)
		base.Crop(crop_area[1] + human_body_offset, crop_area[2], crop_area[3], crop_area[4] + human_body_offset)
	else if(crop_area)
		stack_trace("Invalid crop paramater! The provided crop area list for [sprite_accessory.type] is not four entries long, or is not a list!")
	base.Scale(32, 32)

	return base

/datum/preference/choiced/mutant/icon_for(value)
	if (!should_generate_icons)
		CRASH("Tried to generate a mutant icon for [type], even though should_generate_icons = FALSE!")
	return generate_icon(sprite_accessory[value], sprite_direction)

#undef REQUIRED_CROP_LIST_SIZE
