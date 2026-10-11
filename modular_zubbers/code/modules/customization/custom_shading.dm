/// DNA feature key holding the shadow color for custom shading. Null means custom shading is off.
#define FEATURE_CUSTOM_SHADING "custom_shading"

/**
 * Builds a gradient map color matrix for a greyscale sprite.
 * White pixels come out as `base`, black pixels come out as `shadow`, and greys blend between the two.
 * With a black shadow this gives the same result as a plain multiply, so it only changes how shadows look.
 */
/proc/custom_shading_matrix(base, shadow)
	var/list/base_rgb = rgb2num(base)
	var/list/shadow_rgb = rgb2num(shadow)
	// Each input channel gets a third of the weight, so a grey pixel of value V gives shadow + (base - shadow) * V.
	var/list/channel_row = list()
	var/list/constant_row = list()
	for(var/i in 1 to 3)
		channel_row += (base_rgb[i] - shadow_rgb[i]) / (255 * 3)
		constant_row += shadow_rgb[i] / 255
	return channel_row + channel_row + channel_row + constant_row

/// Cache of baked custom shading icons, keyed by icon, icon state and matrix.
GLOBAL_LIST_EMPTY(custom_shading_icon_cache)

/// Returns a copy of the given icon state with the custom shading matrix baked into its pixels.
/proc/get_custom_shaded_icon(icon_file, icon_state, list/matrix)
	var/cache_key = "[icon_file]|[icon_state]|[matrix.Join(",")]"
	var/icon/cached = GLOB.custom_shading_icon_cache[cache_key]
	if(cached)
		return cached
	var/icon/baked = icon(icon_file, icon_state)
	baked.MapColors(arglist(matrix))
	GLOB.custom_shading_icon_cache[cache_key] = baked
	return baked

/// Returns the colors that count as this mob's "body" colors for custom shading, in lowercase.
/mob/living/carbon/proc/get_custom_shading_targets()
	var/list/targets = list()
	for(var/feature_key in list(FEATURE_MUTANT_COLOR, FEATURE_MUTANT_COLOR_TWO, FEATURE_MUTANT_COLOR_THREE))
		var/feature_color = dna?.features?[feature_key]
		if(istext(feature_color))
			targets |= LOWER_TEXT(feature_color)
	return targets

/mob/living/carbon/human/get_custom_shading_targets()
	. = ..()
	if(skin_tone)
		. |= LOWER_TEXT(skintone2hex(skin_tone))

/**
 * Takes a color that is about to be put on a greyscale sprite and returns what should be used instead.
 * Only colors that match one of the mob's body colors get shaded, so accents like eyes, markings,
 * nipples or ear tips keep their plain color. Everything else is returned unchanged.
 */
/mob/living/carbon/proc/get_custom_shading(color)
	var/shadow = dna?.features?[FEATURE_CUSTOM_SHADING]
	if(!shadow || !istext(color))
		return color
	if(!(LOWER_TEXT(color) in get_custom_shading_targets()))
		return color
	return custom_shading_matrix(color, shadow)

/// Render key part for custom shading, so cached icons are rebuilt when the shadow color changes.
/mob/living/carbon/proc/get_custom_shading_key()
	var/shadow = dna?.features?[FEATURE_CUSTOM_SHADING]
	return shadow ? "shade_[shadow]" : ""

/datum/preference/toggle/custom_shading
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_shading_toggle"
	default_value = FALSE

/datum/preference/toggle/custom_shading/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return // The color preference reads this toggle and does the work.

/datum/preference/color/custom_shading
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_shading_color"

/datum/preference/color/custom_shading/create_default_value()
	return "#000000"

/datum/preference/color/custom_shading/is_accessible(datum/preferences/preferences)
	if(!..())
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/custom_shading)

/datum/preference/color/custom_shading/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences?.read_preference(/datum/preference/toggle/custom_shading))
		target.dna.features -= FEATURE_CUSTOM_SHADING
		return
	target.dna.features[FEATURE_CUSTOM_SHADING] = value

#undef FEATURE_CUSTOM_SHADING
