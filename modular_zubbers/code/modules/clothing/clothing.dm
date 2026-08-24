/// For applying a normalization
/obj/item/clothing/proc/normalize_mob_size(mob/living/carbon/human/resizer)
	if(resizer.normalized)
		to_chat(resizer, span_danger("This accessory buzzes, being overwritten by another."))
		playsound(resizer, 'sound/machines/buzz/buzz-sigh.ogg', 50, 1)
		return
	playsound(resizer, 'sound/effects/magic.ogg', 50, 1)
	flash_lighting_fx(3, 3, LIGHT_COLOR_PURPLE)
	resizer.visible_message(span_warning("A flash of purple light engulfs [resizer], before they change to normal!"), span_notice("You feel warm for a moment, before everything scales to your size..."))
	if(resizer.get_quirk(/datum/quirk/oversized))
		resizer.remove_quirk(/datum/quirk/oversized)
	else
		resizer.update_transform(RESIZE_DEFAULT_SIZE / resizer?.client?.prefs?.read_preference(/datum/preference/numeric/body_size))
	resizer.normalized = TRUE

/// For removing a normalization, and reverting back to normal
/obj/item/clothing/proc/denormalize_mob_size(mob/living/carbon/human/resizer)
	if(resizer.normalized)
		playsound(resizer,'sound/items/weapons/emitter2.ogg', 50, 1)
		flash_lighting_fx(3, 3, LIGHT_COLOR_YELLOW)
		resizer.visible_message(span_warning("Golden light engulfs [resizer], and they shoot back to their default height!"), span_notice("Energy rushes through your body, and you return to normal."))
		for(var/quirk in resizer?.client?.prefs?.all_quirks)
			if(quirk == "Oversized")
				resizer.add_quirk(/datum/quirk/oversized, announce = FALSE)
				break
		if(!resizer.get_quirk(/datum/quirk/oversized))
			resizer.update_transform(resizer?.client?.prefs?.read_preference(/datum/preference/numeric/body_size))
		resizer.normalized = FALSE
