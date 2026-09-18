/obj/item/organ/ears
	mutantpart_key = "ears"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/ears/mutant
	name = "fluffy ears"
	desc = "Wait, there's two pairs of these?"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears
	organ_flags = ORGAN_ORGANIC | ORGAN_EXTERNAL | ORGAN_VIRGIN

/obj/item/organ/ears/cat

/obj/item/organ/ears/fox

/datum/bodypart_overlay/mutant/ears
	feature_key = FEATURE_EARS
	layers = list(EXTERNAL_FRONT = BODY_FRONT_LAYER, EXTERNAL_ADJACENT = BODY_ADJ_LAYER, EXTERNAL_BEHIND = BODY_BEHIND_LAYER)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = UPPER_BODY

/datum/bodypart_overlay/mutant/ears/set_appearance_from_name(accessory_name)
	if(isnull(accessory_name))
		accessory_name = "None" // Just to deal with the edge cases where there's some that wouldn't have an actual base appearance, since ears don't always need a visual component, but we have to proceed like this due to the unfortunate nature of this system.

	return ..()

/datum/bodypart_overlay/mutant/ears/override_color(rgb_value)
	return draw_color
