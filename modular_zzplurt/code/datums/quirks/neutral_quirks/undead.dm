#define QUIRK_HUNGER_UNDEAD 1.1

/datum/quirk/undead
    name = "Undeath"
    desc = "You stand on the border between life and death, causing you to function similar to a zombie."
    value = 0
    gain_text = span_notice("The life has left your body, but you haven't stopped moving yet.")
    lose_text = span_notice("By some miracle, you've been brought back to life!")
    medical_record_text = "Patient is listed as deceased in medical records."
    mob_trait = TRAIT_UNDEAD
    icon = FA_ICON_HEAD_SIDE_VIRUS

/datum/quirk/undead/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check if holder is inorganic
	if(!(quirk_mob.mob_biotypes & MOB_ORGANIC))
		// Warn holder
		to_chat(quirk_mob, span_warning("You have failed to become undead due to incompatible biology!"))

		// Do nothing
		return FALSE

	// Replace biotypes
	quirk_mob.mob_biotypes -= MOB_ORGANIC
	quirk_mob.mob_biotypes += MOB_UNDEAD

	// Add undead traits
	// Based on the High-Functioning Zombie species
	// Powergamer traits are in separate quirks
	quirk_mob.add_traits(list(
		// SHARED WITH ALL ZOMBIES
		TRAIT_EASILY_WOUNDED,
		TRAIT_EASYDISMEMBER,
		TRAIT_FAKEDEATH,
		TRAIT_LIMBATTACHMENT,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_ZOMBIFY,
		// HIGH FUNCTIONING UNIQUE
		TRAIT_NOBLOOD
	), TRAIT_UNDEAD)

	// Add fake health HUD
	quirk_holder.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, TRAIT_UNDEAD)

	// Increase hunger rate
	//quirk_mob.physiology.hunger_mod *= QUIRK_HUNGER_UNDEAD

/datum/quirk/undead/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Revert biotypes
	quirk_mob.mob_biotypes += MOB_ORGANIC
	quirk_mob.mob_biotypes -= MOB_UNDEAD

	// Remove undead traits
	quirk_mob.remove_traits(list(
		// SHARED WITH ALL ZOMBIES
		TRAIT_EASILY_WOUNDED,
		TRAIT_EASYDISMEMBER,
		TRAIT_FAKEDEATH,
		TRAIT_LIMBATTACHMENT,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_ZOMBIFY,
		// HIGH FUNCTIONING UNIQUE
		TRAIT_NOBLOOD
	), TRAIT_UNDEAD)

	// Remove fake health HUD
	quirk_holder.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, TRAIT_UNDEAD)

	// Decrease hunger rate
	//quirk_mob.physiology.hunger_mod /= QUIRK_HUNGER_UNDEAD

#undef QUIRK_HUNGER_UNDEAD
