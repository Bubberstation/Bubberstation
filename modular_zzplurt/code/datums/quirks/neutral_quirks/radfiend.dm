#define TRAIT_RAD_FIEND "rad_fiend"

GLOBAL_LIST_INIT(traits_by_type_radfiend, list(
	/obj/item/toy/plush/skyrat = list(
		"TRAIT_RAD_FIEND" = TRAIT_RAD_FIEND, //SPLURT addition - for sodium sensetivity quirk
	),
))

/datum/quirk/rad_fiend
	name = "Rad Fiend"
	desc = "You've been blessed by Cherenkov's warming light, causing you to emit a subtle glow at all times. Only -very- intense radiation is capable of penetrating your protective barrier"
	icon = FA_ICON_RADIATION
	value = 2
	mob_trait = TRAIT_RAD_FIEND
	gain_text = span_notice("You feel empowered by Cherenkov's glow.")
	lose_text = span_notice("You realize that rads aren't so rad.")
	medical_record_text = "Patient is slightly radioactive."

/datum/quirk/rad_fiend/add()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	// Add glow control action
	var/datum/action/rad_fiend/update_glow/quirk_action = new
	quirk_action.Grant(quirk_mob)

/datum/quirk/rad_fiend/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove glow control action
	var/datum/action/rad_fiend/update_glow/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

	// Remove glow effect
	quirk_mob.remove_filter("rad_fiend_glow")

/datum/action/rad_fiend
	name = "Broken Rad Action"
	desc = "Report this to a coder."
	button_icon_state = "static"

/datum/action/rad_fiend/update_glow
	name = "Modify Glow"
	desc = "Change your radioactive glow color."
	button_icon_state = "blank"

	// Glow color to use
	var/glow_color = "#39ff14" // Neon green

	// Thickness of glow outline
	var/glow_range = 2


/datum/action/rad_fiend/update_glow/Grant()
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = owner

	// Add outline effect
	action_mob.add_filter("rad_fiend_glow", 1, list("type" = "outline", "color" = glow_color+"30", "size" = glow_range))

/datum/action/rad_fiend/update_glow/Remove()
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = owner

	// Remove glow
	action_mob.remove_filter("rad_fiend_glow")

/datum/action/rad_fiend/update_glow/Trigger(trigger_flags)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = owner

	// Ask user for color input
	var/input_color = input(action_mob, "Select a color to use for your glow outline.", "Select Glow Color", glow_color) as color|null

	// Check if color input was given
	// Reset to stored color when not given input
	glow_color = (input_color ? input_color : glow_color)

	// Ask user for range input
	var/input_range = input(action_mob, "How much do you glow? Value may range between 1 to 2.", "Select Glow Range", glow_range) as num|null

	// Check if range input was given
	// Reset to stored color when not given input
	// Input is clamped in the 1-4 range
	glow_range = (input_range ? clamp(input_range, 1, 4) : glow_range)

	// Update outline effect
	action_mob.remove_filter("rad_fiend_glow")
	action_mob.add_filter("rad_fiend_glow", 1, list("type" = "outline", "color" = glow_color+"30", "size" = glow_range))
