/// Creates a masked icon for sprite accessories which have 'use_custom_mod_icon' set to TRUE
/datum/sprite_accessory/proc/get_custom_mod_icon(mob/living/carbon/human/owner, mutable_appearance/appearance_to_use = null)
	if(!use_custom_mod_icon)
		return null

	if(!mod_overlay_active(owner))
		return null
	if(isnull(appearance_to_use))
		return null // No source image -> nothing to blend. Callers composite per-pass.
	var/obj/item/mod/control/modsuit_control = owner.back
	var/datum/mod_theme/mod_theme = modsuit_control.theme

	var/index = "[appearance_to_use.icon]-[appearance_to_use.icon_state]-[mod_theme.hardlight_theme]"
	var/static/list/mod_icon_cache = list()
	var/icon/special_icon = mod_icon_cache[index]
	if(!special_icon)
		special_icon = icon(appearance_to_use.icon, appearance_to_use.icon_state)
		var/icon/MOD_texture = icon('modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi', "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		special_icon = fcopy_rsc(special_icon)
		mod_icon_cache[index] = special_icon

	return icon(special_icon)

/// Is this accessory currently under an active hardlight MOD overlay? Used for determining if we should apply a mod overlay to a bodypart
/datum/sprite_accessory/proc/mod_overlay_active(mob/living/carbon/human/wearer)
	if(!istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))
		return FALSE
	var/obj/item/mod/control/modsuit_control = wearer.back
	if(!istype(modsuit_control))
		return FALSE
	return (modsuit_control.active || modsuit_control.activating) && modsuit_control.theme?.hardlight

/// The hardlight theme string, for use in the render cache key - so we don't get any color collisions
/datum/sprite_accessory/proc/get_hardlight_theme_key(mob/living/carbon/human/wearer)
	if(!istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))
		return ""
	var/obj/item/mod/control/modsuit_control = wearer.back
	if(!istype(modsuit_control))
		return ""
	return "[modsuit_control.theme?.hardlight_theme]"
