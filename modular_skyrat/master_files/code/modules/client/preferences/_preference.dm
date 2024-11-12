#define REQUIRED_CROP_LIST_SIZE 4




/**
 * Base class for choices character features, mainly mutant body parts
 */
/datum/preference/choiced/mutant_choice
	abstract_type = /datum/preference/choiced/mutant_choice
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	should_generate_icons = TRUE

	/// Path to the default sprite accessory
	var/datum/sprite_accessory/default_accessory_type = /datum/sprite_accessory/blank
	/// Path to the corresponding /datum/preference/toggle to check if part is enabled.
	var/datum/preference/toggle/type_to_check
	/// Generates icons from the provided mutant bodypart for use in icon-enabled selection boxes in the prefs window.
	var/generate_icons = FALSE
	/// A list of the four co-ordinates to crop to, if `generate_icons` is enabled. Useful for icons whose main contents are smaller than 32x32. Please keep it square.
	var/list/crop_area
	/// A color to apply to the icon if it's greyscale, and `generate_icons` is enabled.
	var/greyscale_color

/datum/preference/choiced/mutant_choice/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/overriding = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = is_part_enabled(preferences)
	return (passed_initial_check || overriding) && part_enabled

// icons are cached
/datum/preference/choiced/mutant_choice/icon_for(value)
	if(!should_generate_icons)
		// because of the way the unit tests are set up, we need this to crash here
		CRASH("`icon_for()` was not implemented for [type], even though should_generate_icons = TRUE!")

	var/list/cached_icons = get_choices()
	return cached_icons[value]

/// Allows for dynamic assigning of icon states.
/datum/preference/choiced/mutant_choice/proc/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state)
	return original_icon_state

/// Generates and allows for post-processing on icons, such as greyscaling and cropping. This is cached.
/datum/preference/choiced/mutant_choice/proc/generate_icon(datum/sprite_accessory/sprite_accessory)
	if(!sprite_accessory.icon_state)
		return icon('icons/mob/landmarks.dmi', "x")

	var/icon/icon_to_process = icon(sprite_accessory.icon, generate_icon_state(sprite_accessory, sprite_accessory.icon_state), SOUTH, 1)

	if(islist(crop_area) && crop_area.len == REQUIRED_CROP_LIST_SIZE)
		icon_to_process.Crop(crop_area[1], crop_area[2], crop_area[3], crop_area[4])
		icon_to_process.Scale(32, 32)
	else if(crop_area)
		stack_trace("Invalid crop paramater! The provided crop area list is not four entries long, or is not a list!")

	var/color = sanitize_hexcolor(greyscale_color)
	if(color && sprite_accessory.color_src)
		// This isn't perfect, but I don't want to add the significant overhead to make it be.
		icon_to_process.ColorTone(color)

	return icon_to_process

/datum/preference/choiced/mutant_choice/init_possible_values()
	if(!initial(generate_icons))
		return assoc_to_keys_features(SSaccessories.sprite_accessories[relevant_mutant_bodypart])

	var/list/list_of_accessories = list()
	for(var/sprite_accessory_name as anything in SSaccessories.sprite_accessories[relevant_mutant_bodypart])
		var/datum/sprite_accessory/sprite_accessory = SSaccessories.sprite_accessories[relevant_mutant_bodypart][sprite_accessory_name]
		list_of_accessories += list("[sprite_accessory.name]" = generate_icon(sprite_accessory))

	return list_of_accessories

/datum/preference/choiced/mutant_choice/create_default_value()
	return initial(default_accessory_type.name)

/**
 * Is this part enabled by the player?
 *
 * Arguments:
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant_choice/proc/is_part_enabled(datum/preferences/preferences)
	return preferences.read_preference(type_to_check)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns TRUE if feature is visible.
 *
 * Arguments:
 * * target - The character this is being applied to.
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant_choice/proc/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
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
/datum/preference/choiced/mutant_choice/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
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

#undef REQUIRED_CROP_LIST_SIZE
