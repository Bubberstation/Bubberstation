/proc/generate_mutant_accessory_icons(list/sprite_accessories, key, direction = EAST, layer = EXTERNAL_FRONT)
	var/list/values = list()

	for (var/name in sprite_accessories)
		var/datum/sprite_accessory/sprite_accessory = sprite_accessories[name]

		var/icon/final_icon

		if(sprite_accessory.icon_state != "none")
			if(!(layer in sprite_accessory.relevent_layers))
				layer = pick(sprite_accessory.relevent_layers)
			final_icon = icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_[layer]", direction)
		else
			final_icon = icon('icons/mob/human/bodyparts_greyscale.dmi', "lizard_chest_m", direction)

		final_icon.Blend(COLOR_VIBRANT_LIME)

		values[name] = final_icon

	return values
