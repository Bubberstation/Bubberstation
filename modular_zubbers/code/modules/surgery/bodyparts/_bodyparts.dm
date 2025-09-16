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
