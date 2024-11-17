/datum/quirk/rad_fiend
	name = "Rad Fiend"
	desc = "You've been blessed by Cherenkov's warming light! Radiation is incapable of penetrating your protective barrier."
	value = 6
	gain_text = span_notice("You feel empowered by Cherenkov's glow.")
	lose_text = span_notice("You realize that rads aren't so rad.")
	medical_record_text = "Patient emits a slight radioactive aura. The effect is harmless."
	mob_trait = TRAIT_RAD_FIEND
	hardcore_value = -2
	icon = FA_ICON_RADIATION
	mail_goodies = list (
		/obj/item/geiger_counter = 1
	)

// This quirk does three things:
// - Immunity to radiation
// - A cosmetic glow effect
// - A favorite food mood bonus for drinking Nuka Cola

/datum/quirk/rad_fiend/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add glow control action
	var/datum/action/cosglow/update_glow/quirk_action = new
	quirk_action.Grant(quirk_mob)

	// Add radiation immunity
	ADD_TRAIT(quirk_mob, TRAIT_RADIMMUNE, TRAIT_RAD_FIEND)

	// Register reagent interactions
	RegisterSignal(quirk_holder, COMSIG_REAGENT_METABOLIZE_NUKACOLA, PROC_REF(metabolize_nuka))

/datum/quirk/rad_fiend/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove glow control action
	var/datum/action/cosglow/update_glow/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

	// Remove glow effect
	quirk_mob.remove_filter("rad_fiend_glow")

	// Remove radiation immunity
	REMOVE_TRAIT(quirk_mob, TRAIT_RADIMMUNE, TRAIT_RAD_FIEND)

	// Unregister reagent interactions
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_METABOLIZE_NUKACOLA)

/// Handle effects applied by consuming Nuka Cola
/datum/quirk/rad_fiend/proc/metabolize_nuka()
	SIGNAL_HANDLER

	// Add mood bonus
	quirk_holder.add_mood_event("fav_food", /datum/mood_event/favorite_food)
