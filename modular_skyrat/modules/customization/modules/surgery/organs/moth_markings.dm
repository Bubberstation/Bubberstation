/obj/item/organ/moth_markings
	name = "moth markings"
	desc = "How did you even get that off...?"
	icon_state = "random_fly_2"

	mutantpart_key = "moth_markings"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_MOTH_MARKINGS
	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/moth_markings

/datum/bodypart_overlay/mutant/moth_markings
	feature_key = FEATURE_MOTH_MARKINGS
	layers = list(EXTERNAL_FRONT = BODY_FRONT_LAYER, EXTERNAL_ADJACENT = BODY_ADJ_LAYER, EXTERNAL_BEHIND = BODY_BEHIND_LAYER)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = ENTIRE_BODY

/datum/bodypart_overlay/mutant/moth_markings/override_color(rgb_value)
	return draw_color
