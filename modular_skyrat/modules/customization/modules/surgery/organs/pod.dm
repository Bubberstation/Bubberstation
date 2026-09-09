/obj/item/organ/pod_hair
	name = "podperson hair"
	desc = "Base for many-o-salads."
	mutantpart_key = FEATURE_POD_HAIR
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_POD_HAIR
	bodypart_overlay = /datum/bodypart_overlay/mutant/pod_hair

	mutantpart_key = FEATURE_POD_HAIR
	mutantpart_info = list(MUTANT_INDEX_NAME = /datum/sprite_accessory/pod_hair/ivy::name, MUTANT_INDEX_COLOR_LIST = list("#ffffff", "#ffffff", "#ffffff"))

/datum/bodypart_overlay/mutant/pod_hair
	layers = list(
		EXTERNAL_FRONT = ABOVE_BODY_FRONT_HEAD_LAYER,
		EXTERNAL_ADJACENT = BODY_FRONT_LAYER
	)
	color_swapped_layer = EXTERNAL_FRONT
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = ENTIRE_BODY

/datum/bodypart_overlay/mutant/pod_hair/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/pod_hair/color_images(list/image/overlays, obj/item/bodypart/limb, layer_index)
	if(layer_index != color_swapped_layer)
		return ..()
	if(limb?.is_husked) // Husked? Skip the color inversion and let the base proc apply the standard gray husk colors.
		return ..()
	alpha = limb?.alpha || 255
	for(var/index_to_color in overlay_indexes_to_color)
		if(index_to_color > length(overlays))
			break
		var/image/overlay = overlays[index_to_color]
		var/list/rgb_list
		if(istext(draw_color) || length(draw_color) == 1) // legacy single-color mode, we just invert it
			rgb_list = list()
			for(var/col in rgb2num(islist(draw_color) ? draw_color[1] : draw_color))
				rgb_list += (color_inverse_base - col) //inversa da color
		else if(length(draw_color) >= 2)
			rgb_list = rgb2num(draw_color[2])
		if(rgb_list)
			overlay.color = rgb(rgb_list[1], rgb_list[2], rgb_list[3])
		else
			overlay.color = null
		overlay.alpha = alpha

/datum/bodypart_overlay/mutant/pod_hair/randomize_appearance()
	. = ..()
	draw_color = list("#[random_color()]", "#[random_color()]", "#FFFFFF") // currently only two colors are used
