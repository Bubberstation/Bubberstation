/obj/item/organ/frills
	mutantpart_key = "frills"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Divinity", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	organ_flags = ORGAN_EXTERNAL

/datum/bodypart_overlay/mutant/frills
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/frills/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/frills/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!human)
		return TRUE
	return !sprite_datum.is_hidden(human)
