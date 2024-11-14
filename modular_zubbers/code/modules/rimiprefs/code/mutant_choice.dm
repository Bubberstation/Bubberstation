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
	/// The global list containing the sprite accessories to use. Can be set to a string to override the key used to get the sprite accessories.
	var/list/sprite_accessory
	/// Direction to render the preview on. Can take NORTH, SOUTH, EAST, WEST.
	var/sprite_direction = SOUTH
	/// A list of types to exclude, including their subtypes.
	var/list/accessories_to_ignore

	/// A list of the four co-ordinates to crop to, if `generate_icons` is enabled. Useful for icons whose main contents are smaller than 32x32. Please keep it square. (x1, y1, x2, y2)
	var/list/crop_area
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

	if (!main_feature_name)
		main_feature_name = full_capitalize(replacetext(key, "_", " "))

	sprite_accessory = SSaccessories.sprite_accessories[sprite_accessory ? sprite_accessory : relevant_mutant_bodypart]

/datum/preference/choiced/mutant/create_default_value()
	return default_accessory_name

/datum/preference/choiced/mutant/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/overriding = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = is_part_enabled(preferences)
	return (passed_initial_check || overriding) && part_enabled

/**
 * Is this part enabled by the player?
 *
 * Arguments:
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant/proc/is_part_enabled(datum/preferences/preferences)
	return preferences.read_preference(type_to_check)

/datum/preference/choiced/mutant/init_possible_values()
	return generate_mutant_valid_values(sprite_accessory, accessories_to_ignore)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns TRUE if feature is visible.
 *
 * Arguments:
 * * target - The character this is being applied to.
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant/proc/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
	if(!is_part_enabled(preferences))
		return FALSE

	if(preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts))
		return TRUE

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	species = new species

	return (savefile_key in species.get_features())

/// Apply this preference onto the given human.
/// May be overriden by subtypes.
/// Called when the savefile_identifier == PREFERENCE_CHARACTER.
///
/// Returns whether the bodypart is actually visible.
/datum/preference/choiced/mutant/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	// body part is not the default/none value.
	var/bodypart_is_visible = preferences && is_visible(target, preferences)

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
/datum/preference/choiced/mutant/proc/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	return "[original_icon_state][suffix]"

/// Generates and allows for post-processing on icons, such as greyscaling and cropping.
/datum/preference/choiced/mutant/proc/generate_icon(datum/sprite_accessory/sprite_accessory, dir = SOUTH)
	if(!sprite_accessory.icon_state || sprite_accessory.name == SPRITE_ACCESSORY_NONE)
		return icon('icons/mob/landmarks.dmi', "x")

	var/list/icon_states_to_use = list()

	if(sprite_accessory.color_src == USE_MATRIXED_COLORS)
		for(var/index in sprite_accessory.color_layer_names)
			icon_states_to_use += generate_icon_state(sprite_accessory, sprite_accessory.icon_state, "_[sprite_accessory.color_layer_names[index]]")
	else
		icon_states_to_use += generate_icon_state(sprite_accessory, sprite_accessory.icon_state)

	var/icon/icon_to_return = icon('modular_zubbers/icons/customization/template.dmi', "blank_template", SOUTH, 1)
	var/color = sanitize_hexcolor(greyscale_color)

	for(var/icon_state in icon_states_to_use)
		var/icon/icon_to_process = icon(sprite_accessory.icon, icon_state, dir, 1)

		if(islist(crop_area) && crop_area.len == REQUIRED_CROP_LIST_SIZE)
			icon_to_process.Crop(crop_area[1], crop_area[2], crop_area[3], crop_area[4])
		else if(crop_area)
			stack_trace("Invalid crop paramater! The provided crop area list is not four entries long, or is not a list!")

		icon_to_process.Scale(32, 32)

		if(greyscale_color && sprite_accessory.color_src) // I intentionally use greyscale_color here.
			// Turns out I ended up making this perfect. Welp.
			icon_to_process.Blend(color, ICON_MULTIPLY)
			color = "#[darken_color(darken_color(copytext(color, 2)))]" // Darken colour for the next layer to be able to tell it apart. YES, I KNOW THIS IS CURSED, BUT I DON'T WANT TO THINK ABOUT CHARACTER CODES - Rimi

		icon_to_return.Blend(icon_to_process, ICON_OVERLAY)

	return icon_to_return

/datum/preference/choiced/mutant/icon_for(value)
	return generate_icon(sprite_accessory[value], sprite_direction)

#undef REQUIRED_CROP_LIST_SIZE
