// UNIMPLEMENTED QUIRK!
// Currently disabled due to appearance change issues
/datum/quirk/werewolf
	name = "Werewolf"
	desc = "A beastly affliction allows you to shape-shift into a large anthropomorphic canine at will."
	value = 0
	gain_text = span_notice("You feel the full moon beckon.")
	lose_text = span_notice("The moon's call hushes into silence.")
	medical_record_text = "Patient has been reported howling at the night sky."
	mob_trait = TRAIT_WEREWOLF
	icon = FA_ICON_PAW
	hidden_quirk = TRUE

/datum/quirk/werewolf/add(client/client_source)
	// Define quirk action
	var/datum/action/cooldown/werewolf/transform/quirk_action = new

	// Grant quirk action
	quirk_action.Grant(quirk_holder)

/datum/quirk/werewolf/remove()
	// Define quirk action
	var/datum/action/cooldown/werewolf/transform/quirk_action = locate() in quirk_holder.actions

	// Revoke quirk action
	quirk_action.Remove(quirk_holder)

//
// Quirk Abilities
//

/datum/action/cooldown/werewolf
	name = "Lycanthrope Ability"
	desc = "Do something related to werewolves."
	button_icon = 'modular_zzplurt/icons/mob/actions/misc_actions.dmi'
	button_icon_state = "Transform"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_INCAPACITATED | AB_CHECK_CONSCIOUS
	cooldown_time = 5 SECONDS
	transparent_when_unavailable = TRUE

/datum/action/cooldown/werewolf/transform
	name = "Toggle Lycanthrope Form"
	desc = "Transform in or out of your wolf form."
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_PHASED
	var/transformed = FALSE
	var/species_changed = FALSE
	var/werewolf_gender = "Lycan"
	var/list/old_features
	var/list/old_mutant_bodyparts

/datum/action/cooldown/werewolf/transform/Grant()
	. = ..()

	// Define action owner
	var/mob/living/carbon/human/action_owner = owner

	// Define old mutant parts
	old_mutant_bodyparts = action_owner.dna.mutant_bodyparts

	// Define old features
	old_features = list("species" = SPECIES_HUMANOID, "legs" = "Plantigrade", "size" = 1, "bark")

	// Record features
	old_features["species"] = action_owner.dna.species.type
	old_features["custom_species"] = action_owner.dna.features["custom_species"]
	//old_features["size"] = get_size(action_owner) // Temporarily disabled
	old_features["bark"] = action_owner.blooper_id
	old_features["taur"] = action_owner.dna.features["taur"]

	// Set species gendered name
	switch(action_owner.gender)
		if(MALE)
			werewolf_gender = "Wer"
		if(FEMALE)
			werewolf_gender = "Wīf"
		if(PLURAL)
			werewolf_gender = "Hie"
		if(NEUTER)
			werewolf_gender = "Þing"

/datum/action/cooldown/werewolf/transform/Activate()
	// Define action owner
	var/mob/living/carbon/human/action_owner = owner

	// Define genital organs
	// Temporarily disabled
	/*
	var/obj/item/organ/external/genital/penis/organ_penis = action_owner.get_organ_slot(ORGAN_SLOT_PENIS)
	// Add testicles here
	var/obj/item/organ/external/genital/breasts/organ_breasts = action_owner.get_organ_slot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/external/genital/vagina/organ_vagina = action_owner.get_organ_slot(ORGAN_SLOT_VAGINA)
	*/

	// Play shake animation
	action_owner.Shake(pixelshiftx = 0.2, pixelshifty = 0.2, duration = 1 SECONDS)

	// Transform into wolf form
	if(!transformed)
		// Species changing disabled due to issues
		// This is heavily exploitable for bypassing species limitations
		/*
		// Define current species type
		var/datum/species/owner_current_species = action_owner.dna.species.type

		// Check if species has changed
		if(old_features["species"] != owner_current_species)
			// Set old species
			old_features["species"] = owner_current_species

		// Define species prefix
		var/custom_species_prefix

		// Check if species is a template
		if(ismammal(action_owner) || ishumanoid(action_owner))
			// Do nothing!

		// Check if species is already furry
		else if(isvulpkanin(action_owner))
			// Do nothing

		// Check if species is a jelly subtype
		else if(ispath(owner_current_species, /datum/species/jelly))
			// Set species prefix
			custom_species_prefix = "Slime "

		// Species is not valid
		else
			// Change species
			action_owner.set_species(/datum/species/mammal, 1)

			// Set species changed
			species_changed = TRUE // TEMPORARILY DISABLED!
		*/

		// Set species features
		action_owner.dna.features["custom_species"] = "[werewolf_gender]wulf"
		action_owner.dna.features["ears"] = "Wolf" // No "Jackal" ears
		action_owner.dna.features["tail"] = "Otusian"
		action_owner.dna.features["snout"] = "Sergal"
		//action_owner.dna.features["legs"] = "Digitigrade" // Temporarily disabled
		//action_owner.dna.features["fluff"] = "Plain" // No "Hyena" fluff
		//action_owner.update_size(clamp(get_size(action_owner) + 0.5, RESIZE_MICRO, RESIZE_MACRO)) // Temporarily disabled
		action_owner.set_blooper("Pugg") // No "bark" blooper
		/* Temporarily disabled
		if(old_features["taur"] != "None")
			action_owner.dna.features["taur"] = "Canine"
		if(!(action_owner.dna.species.species_traits.Find(DIGITIGRADE)))
			action_owner.dna.species.species_traits += DIGITIGRADE
		*/

		// Apply Appearance
		//action_owner.regenerate_organs() // This causes ALL organs to be healed. Do not use it.
		action_owner.update_body(TRUE)
		action_owner.update_mutant_bodyparts(TRUE)

		// Update possible genital organs
		/* Temporarily disabled
		if(organ_breasts)
			organ_breasts.color = "#[action_owner.dna.features["mcolor"]]"
			organ_breasts.update()
		if(organ_penis)
			organ_penis.shape = "Knotted"
			organ_penis.color = "#ff7c80"
			organ_penis.update()
			organ_penis.set_size(6)
			// Add sheath
			// Unimplemented
			//alterer.dna.features["penis_sheath"] = new_sheath
			//organ_penis.sheath = new_sheath
		// Add testicles here
		if(organ_vagina)
			organ_vagina.shape = "Furred"
			organ_vagina.color = "#[action_owner.dna.features["mcolor"]]"
			organ_vagina.update()
		*/

	// Un-transform from wolf form
	else
		// Check if species was changed
		if(species_changed)
			// Revert species
			action_owner.set_species(old_features["species"], TRUE)

			// Clear species changed flag
			species_changed = FALSE

		// Revert species trait
		action_owner.set_blooper(old_features["bark"])
		action_owner.dna.features["custom_species"] = old_features["custom_species"]
		action_owner.dna.features["ears"] = old_features["ears"]
		action_owner.dna.features["snout"] = old_features["snout"]
		action_owner.dna.features["tail"] = old_features["tail"]
		action_owner.dna.features["legs"] = old_features["legs"]
		//action_owner.dna.features["fluff"] = old_features["fluff"] // Temporarily disabled
		/* Temporarily disabled
		if(old_features["taur"] != "None")
			action_owner.dna.features["taur"] = old_features["taur"]
		if(old_features["legs"] == "Plantigrade")
			action_owner.dna.species.species_traits -= DIGITIGRADE
			action_owner.Digitigrade_Leg_Swap(TRUE)
			action_owner.dna.species.mutant_bodyparts["legs"] = old_features["legs"]
		*/

		// Apply Appearance
		//action_owner.regenerate_organs() // This causes ALL organs to be healed. Do not use it.
		action_owner.update_body(TRUE)
		action_owner.update_mutant_bodyparts(TRUE)
		//action_owner.update_size(clamp(get_size(action_owner) - 0.5, RESIZE_MICRO, RESIZE_MACRO)) // Temporarily disabled

		// Revert genital organs
		/* Temporarily disabled
		if(organ_breasts)
			organ_breasts.color = "#[old_features["breasts_color"]]"
			organ_breasts.update()
		if(action_owner.has_penis())
			organ_penis.shape = old_features["cock_shape"]
			organ_penis.color = "#[old_features["cock_color"]]"
			organ_penis.update()
			//organ_penis.modify_size(-6) // Temporarily disabled
		if(action_owner.has_vagina())
			organ_vagina.shape = old_features["vag_shape"]
			organ_vagina.color = "#[old_features["vag_color"]]"
			organ_vagina.update()
			organ_vagina.update_size()
		*/

	// Set transformation message
	var/owner_p_their = action_owner.p_their()
	var/toggle_message = (!transformed ? "[action_owner] shivers, [owner_p_their] flesh bursting with a sudden growth of thick fur as [owner_p_their] features contort to that of a beast, fully transforming [action_owner.p_them()] into a [werewolf_gender]wulf!" : "[action_owner] shrinks, [owner_p_their] wolfish features quickly receding.")

	// Alert in local chat
	action_owner.visible_message(span_danger(toggle_message))

	// Toggle transformation state
	transformed = !transformed

	// Start cooldown
	StartCooldown()

	// Return success
	return TRUE
