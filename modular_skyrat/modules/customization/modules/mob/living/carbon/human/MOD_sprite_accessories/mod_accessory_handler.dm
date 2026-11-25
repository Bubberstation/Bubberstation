#define HARDLIGHT_DMI 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi'
// luminance weights and the stretch that turns the standard blue texture into a near-white pattern for tinting
#define HARDLIGHT_LUMA_RED 0.3
#define HARDLIGHT_LUMA_GREEN 0.59
#define HARDLIGHT_LUMA_BLUE 0.11
#define HARDLIGHT_PATTERN_GAIN 1.44
#define HARDLIGHT_PATTERN_OFFSET -0.06

/datum/sprite_accessory/tails
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/tail_spines
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/ears
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/wings
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/wings_open
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/moth_antennae
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/antenna
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/horns
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/taur
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/spines
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/xenodorsal
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/genital
	use_custom_mod_icon = TRUE

/obj/item/mod/control
	/// Player chosen hardlight color, null means the theme default
	var/hardlight_color_override

/obj/item/mod/control/proc/get_hardlight_color()
	return hardlight_color_override || theme?.hardlight_color || STANDARD_BLUE

/// Returns the hardlight texture for a color, hand drawn for presets and tinted for everything else
/datum/sprite_accessory/proc/get_hardlight_theme_texture(hardlight_color)
	var/static/list/preset_states = list(
		STANDARD_BLUE = "standard_blue",
		ALERT_AMBER = "alert_amber",
		CONTRACTOR_RED = "contractor_red",
		EXTRASHIELD_GREEN = "extrashield_green",
		EVIL_GREEN = "evil_green",
		ROYAL_PURPLE = "royal_purple",
		HAZARD_ORANGE = "hazard_orange",
		COSMIC_BLUE = "cosmic_blue",
	)
	var/preset_state = preset_states[uppertext(hardlight_color)]
	if(preset_state)
		return icon(HARDLIGHT_DMI, preset_state)

	var/static/icon/base_pattern
	if(!base_pattern)
		base_pattern = icon(HARDLIGHT_DMI, "standard_blue")
		var/red = HARDLIGHT_LUMA_RED * HARDLIGHT_PATTERN_GAIN
		var/green = HARDLIGHT_LUMA_GREEN * HARDLIGHT_PATTERN_GAIN
		var/blue = HARDLIGHT_LUMA_BLUE * HARDLIGHT_PATTERN_GAIN
		base_pattern.MapColors(red, red, red, green, green, green, blue, blue, blue, HARDLIGHT_PATTERN_OFFSET, HARDLIGHT_PATTERN_OFFSET, HARDLIGHT_PATTERN_OFFSET)
	var/icon/tinted = icon(base_pattern)
	tinted.Blend(hardlight_color, ICON_MULTIPLY)
	return tinted

/// Creates a masked icon for sprite accessories which have 'use_custom_mod_icon' set to TRUE
/datum/sprite_accessory/proc/get_custom_mod_icon(mob/living/carbon/human/owner, mutable_appearance/appearance_to_use = null)
	if(!use_custom_mod_icon)
		return null
	if(!mod_overlay_active(owner))
		return null
	if(isnull(appearance_to_use))
		return null // no source image, nothing to blend. callers composite per pass
	var/obj/item/mod/control/modsuit_control = owner.back
	var/hardlight_color = modsuit_control.get_hardlight_color()

	var/index = "[appearance_to_use.icon]-[appearance_to_use.icon_state]-[hardlight_color]"
	var/static/list/mod_icon_cache = list()
	var/icon/special_icon = mod_icon_cache[index]
	if(!special_icon)
		special_icon = icon(appearance_to_use.icon, appearance_to_use.icon_state)
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(get_hardlight_theme_texture(hardlight_color), ICON_MULTIPLY)
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

/// The hardlight color, for use in the render cache key so we don't get any color collisions
/datum/sprite_accessory/proc/get_hardlight_theme_key(mob/living/carbon/human/wearer)
	if(!istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))
		return ""
	var/obj/item/mod/control/modsuit_control = wearer.back
	if(!istype(modsuit_control))
		return ""
	return "[modsuit_control.get_hardlight_color()]"

/obj/item/mod/control/ui_data(mob/user)
	var/list/data = ..()
	var/list/suit_status = data["suit_status"]
	suit_status["hardlight_color"] = theme?.hardlight ? get_hardlight_color() : null
	suit_status["hardlight_custom"] = !isnull(hardlight_color_override)
	return data

/obj/item/mod/control/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(action != "hardlight_color" && action != "hardlight_reset")
		return
	if(!. || !theme?.hardlight)
		return
	if(action == "hardlight_reset")
		set_hardlight_color(null)
		return
	INVOKE_ASYNC(src, PROC_REF(pick_hardlight_color), ui.user)

/obj/item/mod/control/proc/pick_hardlight_color(mob/user)
	var/new_color = tgui_color_picker(user, "Choose a hardlight color", "Hardlight Color", get_hardlight_color())
	if(!new_color || QDELETED(src) || ui_status(user, ui_state(user)) < UI_INTERACTIVE)
		return
	set_hardlight_color(new_color)

/obj/item/mod/control/proc/set_hardlight_color(new_color)
	hardlight_color_override = new_color
	wearer?.update_body_parts()
	SStgui.update_uis(src)

#undef HARDLIGHT_DMI
#undef HARDLIGHT_LUMA_RED
#undef HARDLIGHT_LUMA_GREEN
#undef HARDLIGHT_LUMA_BLUE
#undef HARDLIGHT_PATTERN_GAIN
#undef HARDLIGHT_PATTERN_OFFSET
