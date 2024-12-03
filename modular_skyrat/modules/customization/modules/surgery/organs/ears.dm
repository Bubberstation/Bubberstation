/obj/item/organ/internal/ears/mutant
	name = "fluffy ears"
	desc = "Wait, there's two pairs of these?"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/obj/item/organ/internal/ears/cat

/obj/item/organ/internal/ears/fox

/datum/bodypart_overlay/mutant/ears
	feature_key = "ears"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/ears/set_appearance_from_name(accessory_name)
	if(!accessory_name)
		accessory_name = "None" // Just to deal with the edge cases where there's some that wouldn't have an actual base appearance, since ears don't always need a visual component, but we have to proceed like this due to the unfortunate nature of this system.

	return ..()

/datum/bodypart_overlay/mutant/ears/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/ears/get_global_feature_list()
	return SSaccessories.sprite_accessories["ears"]
