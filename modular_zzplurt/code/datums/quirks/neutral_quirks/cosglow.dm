#define COSGLOW_OPACITY_MIN 32
#define COSGLOW_OPACITY_MAX 128
#define COSGLOW_OPACITY_DEFAULT 30
#define COSGLOW_THICKNESS_MIN 1
#define COSGLOW_THICKNESS_MAX 3
#define COSGLOW_THICKNESS_DEFAULT 2
#define COSGLOW_LAMP_RANGE_MIN 0
#define COSGLOW_LAMP_RANGE_MAX 2
#define COSGLOW_LAMP_RANGE_DEFAULT 1.5
#define COSGLOW_LAMP_POWER_MIN 0.5
#define COSGLOW_LAMP_POWER_MAX 1.5
#define COSGLOW_LAMP_POWER_DEFAULT 1
#define COSGLOW_LAMP_COLOR COLOR_WHITE

// You might be an undercover agent.
/datum/quirk/cosglow
	name = "Illuminated"
	desc = "You emit a customizable soft glow! This isn't bright enough to replace your flashlight."
	value = 0
	gain_text = span_notice("You feel empowered by a three-letter agency!")
	lose_text = span_notice("You realize that working for the space agency sucks!")
	medical_record_text = "Patient emits a subtle emissive aura."
	mob_trait = TRAIT_COSGLOW
	icon = FA_ICON_MAGIC_WAND_SPARKLES
	mail_goodies = list (
		/obj/item/flashlight/glowstick = 1
	)
/datum/quirk/cosglow/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add glow control action
	var/datum/action/cosglow/update_glow/quirk_action = new
	quirk_action.Grant(quirk_mob)

/datum/quirk/cosglow/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove glow control action
	var/datum/action/cosglow/update_glow/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

	// Remove glow effect
	quirk_mob.remove_filter("rad_fiend_glow")

// Light emitting status effect
/datum/status_effect/quirk_examine/cosglow
	id = QUIRK_EXAMINE_COSGLOW
	status_type = STATUS_EFFECT_REPLACE

	// Light effect object
	var/obj/effect/dummy/lighting_obj/moblight/cosglow_light_obj

/datum/status_effect/quirk_examine/cosglow/on_apply()
	// Dynamic color is disabled
	/*
	// Get glow action
	var/datum/action/cosglow/update_glow/quirk_action = locate() in owner.actions

	// Check if glow action exists
	if(!quirk_action)
		return FALSE
	*/

	// Set light values
	// Ignores range settings to prevent crew becoming lanterns
	cosglow_light_obj = owner.mob_light(range = COSGLOW_LAMP_RANGE_DEFAULT, power = COSGLOW_LAMP_POWER_DEFAULT, color = COSGLOW_LAMP_COLOR)

	return TRUE

/datum/status_effect/quirk_examine/cosglow/on_remove()
	// Remove light
	QDEL_NULL(cosglow_light_obj)

/datum/status_effect/quirk_examine/cosglow/get_examine_text()
	return span_notice("[owner.p_They()] emit[owner.p_s()] a harmless glowing aura.")

// Glow actions
/datum/action/cosglow
	name = "Broken Glow Action"
	desc = "Report this to a coder."
	button_icon = 'icons/obj/lighting.dmi'
	button_icon_state = "slime-on"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/cosglow/update_glow
	name = "Modify Glow"
	desc = "Adjust your glow aura color and thickness."

	// Default glow color to use
	// Analogous to radiation color
	var/glow_color = "#14FF67"

	// Default thickness of glow outline
	var/glow_thickness = COSGLOW_THICKNESS_DEFAULT

	// Default alpha of the glow outline
	var/glow_opacity = COSGLOW_OPACITY_DEFAULT

	// Light range of the attached object
	var/light_obj_power = COSGLOW_LAMP_POWER_DEFAULT

/datum/action/cosglow/update_glow/Grant(mob/grant_to)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = grant_to

	// Add outline effect
	action_mob.add_filter("rad_fiend_glow", 1, outline_filter("color" = glow_color + "[glow_opacity]", "size" = glow_thickness))

	// Define filter
	var/filter = action_mob.get_filter("rad_fiend_glow")

	// Animate glow
	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

	// Apply status effect
	action_mob.apply_status_effect(/datum/status_effect/quirk_examine/cosglow, TRAIT_COSGLOW)

/datum/action/cosglow/update_glow/Remove(mob/remove_from)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = remove_from

	// Remove glow
	action_mob.remove_filter("rad_fiend_glow")

	// Remove status effect
	action_mob.remove_status_effect(/datum/status_effect/quirk_examine/cosglow, TRAIT_COSGLOW)

/datum/action/cosglow/update_glow/Trigger(trigger_flags)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Define user mob
	var/mob/living/carbon/human/action_mob = owner

	// Ask user for color input
	var/input_color = input(action_mob, "Select a color to use for your glow outline.", "Select Glow Color", glow_color) as color|null

	// Check if color input was given
	// Reset to stored color when not given input
	glow_color = (input_color ? input_color : glow_color)

	// Replaced by alert type input
	/*
	// Ask user for thickness input
	var/input_thickness_tgui = tgui_input_number(action_mob, "How thick is your glow outline?", "Select Glow Thickness", default = COSGLOW_THICKNESS_DEFAULT, max_value = COSGLOW_THICKNESS_MAX, min_value = COSGLOW_THICKNESS_MIN)

	// Check if thickness input was given
	// Reset to stored thickness when input is null
	glow_thickness = isnull(input_thickness_tgui) ? glow_thickness : input_thickness_tgui
	*/

	// Ask user for thickness input
	switch(tgui_alert(action_mob, message = "How thick is your glow outline?", buttons = list("Light", "Regular", "Bold")))
		// Set based on input
		if ("Light")
			glow_thickness = COSGLOW_THICKNESS_MIN
			light_obj_power = COSGLOW_LAMP_POWER_MIN

		if ("Regular")
			glow_thickness = COSGLOW_THICKNESS_DEFAULT
			light_obj_power = COSGLOW_LAMP_POWER_DEFAULT

		if ("Bold")
			glow_thickness = COSGLOW_THICKNESS_MAX
			light_obj_power = COSGLOW_LAMP_POWER_MAX

	// Opacity input interferes with the animation
	/*
	// Ask user for opacity input
	// Limit maximum to prevent crew turning into stickers
	var/input_opacity_tgui = tgui_input_number(action_mob, "How opaque is your glow outline?", "Select Glow Opacity", default = COSGLOW_OPACITY_DEFAULT, max_value = COSGLOW_OPACITY_MAX, min_value = COSGLOW_OPACITY_MIN)

	// Check if opacity input was given
	// If no input is given, reset to stored opacity
	var/opacity_clamped = isnull(input_opacity_tgui) ? hex2num(glow_opacity) : input_opacity_tgui

	// Update glow opacity
	glow_opacity = num2hex(opacity_clamped, 2)
	*/

	// Update outline effect
	action_mob.add_filter("rad_fiend_glow", 1, outline_filter("color" = glow_color + "[glow_opacity]", "size" = glow_thickness))

	// Define filter
	var/filter = action_mob.get_filter("rad_fiend_glow")

	// Animate filter
	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

	// Find status effect
	var/datum/status_effect/quirk_examine/cosglow/glow_effect = locate() in action_mob.status_effects

	// Update status effect light color
	//glow_effect?.cosglow_light_obj?.set_light_color(glow_color) // Unused

	// Update status effect light range
	glow_effect?.cosglow_light_obj?.set_light_power(light_obj_power)

#undef COSGLOW_OPACITY_MIN
#undef COSGLOW_OPACITY_MAX
#undef COSGLOW_OPACITY_DEFAULT
#undef COSGLOW_THICKNESS_MIN
#undef COSGLOW_THICKNESS_MAX
#undef COSGLOW_THICKNESS_DEFAULT
#undef COSGLOW_LAMP_RANGE_MIN
#undef COSGLOW_LAMP_RANGE_MAX
#undef COSGLOW_LAMP_RANGE_DEFAULT
#undef COSGLOW_LAMP_POWER_MIN
#undef COSGLOW_LAMP_POWER_MAX
#undef COSGLOW_LAMP_POWER_DEFAULT
#undef COSGLOW_LAMP_COLOR
