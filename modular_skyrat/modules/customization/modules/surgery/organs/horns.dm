/obj/item/organ/horns
	desc = "Why do some people even have horns? Well, this one obviously doesn't."
	mutantpart_key = "horns"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Simple", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	organ_flags = ORGAN_EXTERNAL

/datum/bodypart_overlay/mutant/horns
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	feature_key = "horns"
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/horns/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/horns/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!human)
		return TRUE
	return !sprite_datum.is_hidden(human)
