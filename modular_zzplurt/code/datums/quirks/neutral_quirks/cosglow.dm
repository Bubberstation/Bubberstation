//You are a CIA agent.
/datum/quirk/cosglow
	name = "Cosmetic Glow"
	desc = "You glow! Be it an obscure radiation emission, or simple Bioluminescent properties.."
	value = 0
	mob_trait = TRAIT_COSGLOW
	gain_text = span_notice("You feel empowered by a three-letter agency!")
	lose_text = span_notice("You realize that working for the space CIA sucks!")

/datum/quirk/cosglow/add()
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

/datum/action/cosglow
	name = "Broken Glow Action"
	desc = "Report this to a coder."
	button_icon_state = "static"

/datum/action/cosglow/update_glow
	name = "Modify Glow"
	desc = "Change your glow color."
	button_icon_state = "blank"

	// Glow color to use
	var/glow_color

	// Thickness of glow outline
	var/glow_range

	// Alpha of the glow outline
	var/glow_intensity

/datum/action/cosglow/update_glow/Grant(mob/grant_to)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = grant_to

	// Default glow intensity to 48 (in decimal)
	glow_intensity = "30"

	// Add outline effect
	if(glow_color && glow_range)
		action_mob.add_filter("rad_fiend_glow", 1, list("type" = "outline", "color" = glow_color + glow_intensity, "size" = glow_range))

/datum/action/cosglow/update_glow/Remove(mob/remove_from)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = remove_from

	// Remove glow
	action_mob.remove_filter("rad_fiend_glow")

/datum/action/cosglow/update_glow/Trigger(trigger_flags)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = owner

	// Ask user for color input
	var/input_color = input(action_mob, "Select a color to use for your glow outline.", "Select Glow Color", glow_color) as color|null

	// Check if color input was given
	// Reset to stored color when not given input
	glow_color = (input_color ? input_color : glow_color)

	// Ask user for range input
	var/input_range = input(action_mob, "How much do you glow? Value may range between 0 to 4. 0 disables glow.", "Select Glow Range", glow_range) as num|null

	// Check if range input was given
	// Disable glow if input is 0.
	// Reset to stored range when input is null.
	// Input is clamped in the 0-4 range
	glow_range = isnull(input_range) ? glow_range : clamp(input_range, 0, 4) //More customisable, so you know when you're looking at someone with Radfiend (doom) or a normal player.

	// Ask user for intensity input
	var/input_intensity = input(action_mob, "How intense is your glow? Value may range between 0 to 255. 0 disables glow.", "Select Glow Intensity", hex2num(glow_intensity)) as num|null

	// Check if intensity input was given and clamp it
	// If no input is given, reset to stored intensity
	var/intensity_clamped = isnull(input_intensity) ? hex2num(glow_intensity) : clamp(input_intensity, 0, 255)

	// Update glow intensity
	glow_intensity = num2hex(intensity_clamped, 2)

	// Update outline effect
	if(glow_range && glow_color)
		action_mob.add_filter("rad_fiend_glow", 1, list("type" = "outline", "color" = glow_color + glow_intensity, "size" = glow_range))
	else
		action_mob.remove_filter("rad_fiend_glow")
