/obj/item/organ/xenodorsal
	name = "dorsal spines"
	desc = "How did that even fit on them...?"
	icon_state = "random_fly_2"

	mutantpart_key = "xenodorsal"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_XENODORSAL
	organ_flags = ORGAN_EXTERNAL

	bodypart_overlay = /datum/bodypart_overlay/mutant/xenodorsal

/datum/bodypart_overlay/mutant/xenodorsal
	feature_key = FEATURE_XENODORSAL
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/xenodorsal/override_color(rgb_value)
	return draw_color
