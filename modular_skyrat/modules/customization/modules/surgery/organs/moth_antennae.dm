/obj/item/organ/antennae
	mutantpart_key = "moth_antennae"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	organ_flags = ORGAN_UNREMOVABLE

/// BUBBER ADDITION
/datum/bodypart_overlay/mutant/antennae
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/antennae/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/antennae/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!human)
		return TRUE
	return !sprite_datum.is_hidden(human)
/// BUBBER ADDITION END
