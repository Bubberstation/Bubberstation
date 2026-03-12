/obj/item/bodypart/proc/update_draw_color()
	draw_color = null
	if(LAZYLEN(color_overrides))
		var/priority
		for (var/override_priority in color_overrides)
			if (text2num(override_priority) > priority)
				priority = text2num(override_priority)
				draw_color = color_overrides[override_priority]
		return
	if(should_draw_greyscale)
		if(owner && !HAS_TRAIT(owner, TRAIT_FIXED_MUTANT_COLORS) && !HAS_TRAIT(owner, TRAIT_USES_SKINTONES))
			if(HAS_TRAIT(owner, TRAIT_MUTANT_COLORS))
				draw_color = owner?.dna?.features?["mcolor"] || species_color || (skin_tone ? skintone2hex(skin_tone) : null)
			else if(HAS_TRAIT(owner, TRAIT_MUTANT_COLORS_2))
				draw_color = owner?.dna?.features?["mcolor2"] || species_color || (skin_tone ? skintone2hex(skin_tone) : null)
			else if(HAS_TRAIT(owner, TRAIT_MUTANT_COLORS_3))
				draw_color = owner?.dna?.features?["mcolor3"] || species_color || (skin_tone ? skintone2hex(skin_tone) : null)
		else
			draw_color = species_color || (skin_tone ? skintone2hex(skin_tone) : null)


/**
 * # This should only be ran by augments, if you don't know what you're doing, you shouldn't be touching this.
 * A setter for the `icon_static` variable of the bodypart. Runs through `icon_exists()` for sanity, and it won't
 * change anything in the event that the check fails.
 *
 * Arguments:
 * * new_icon - The new icon filepath that you want to replace `icon_static` with.
 */
/obj/item/bodypart/proc/set_icon_static(new_icon)
	var/state_to_verify = "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"
	if(icon_exists_or_scream(new_icon, state_to_verify))
		icon_static = new_icon

/**
 * # This should only be ran by augments, if you don't know what you're doing, you shouldn't be touching this.
 * A setter for the `icon_greyscale` variable of the bodypart. Runs through `icon_exists()` for sanity, and it won't
 * change anything in the event that the check fails.
 *
 * Arguments:
 * * new_icon - The new icon filepath that you want to replace `icon_greyscale` with.
 */
/obj/item/bodypart/proc/set_icon_greyscale(new_icon)
	var/state_to_verify = "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"
	if(icon_exists_or_scream(new_icon, state_to_verify))
		icon_greyscale = new_icon
