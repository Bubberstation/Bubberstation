/datum/quirk/rad_fiend
	name = "Rad Fiend"
	desc = "You've been blessed by Cherenkov's warming light, causing you to emit a subtle glow at all times. Only -very- intense radiation is capable of penetrating your protective barrier"
	icon = FA_ICON_RADIATION
	value = 2
	mob_trait = TRAIT_RAD_FIEND
	gain_text = span_notice("You feel empowered by Cherenkov's glow.")
	lose_text = span_notice("You realize that rads aren't so rad.")
	medical_record_text = "Patient is slightly radioactive."

/datum/quirk/rad_fiend/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	// Add glow control action
	var/datum/action/cosglow/update_glow/quirk_action = new
	quirk_action.Grant(quirk_mob)

/datum/quirk/rad_fiend/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove glow control action
	var/datum/action/cosglow/update_glow/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

	// Remove glow effect
	quirk_mob.remove_filter("rad_fiend_glow")
