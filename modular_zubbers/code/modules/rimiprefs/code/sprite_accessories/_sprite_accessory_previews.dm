/datum/sprite_accessory
	var/list/crop_area

/// Please use static vars to cache your icons.
/datum/sprite_accessory/proc/get_base_preview_icon()
	var/static/icon/human_icon
	if (!human_icon)
		human_icon = icon('icons/mob/human/human.dmi', "human_basic")
		human_icon.Blend(skintone2hex("caucasian1"), ICON_MULTIPLY)
	return human_icon
