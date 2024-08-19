/* Needs editing and also the size system
/datum/quirk/werewolf //adds the werewolf quirk
	name = "Werewolf"
	desc = "A beastly affliction allows you to shape-shift into a large anthropomorphic canine at will."
	value = 0
	mob_trait = TRAIT_WEREWOLF
	gain_text = span_notice("You feel the full moon beckon.")
	lose_text = span_notice("The moon's call hushes into silence.")
	medical_record_text = "Patient has been reported howling at the night sky."
	var/list/old_features

/datum/quirk/werewolf/add_chemical_reaction(datum/chemical_reaction/add)
	. = ..()

	// Define old features
	old_features = list("species" = SPECIES_HUMAN, "legs" = "Plantigrade", "size" = 1, "bark")

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Record features
	old_features = quirk_mob.dna.features.Copy()
	old_features["species"] = quirk_mob.dna.species.type
	old_features["custom_species"] = quirk_mob.custom_species
	old_features["size"] = get_size(quirk_mob)
	old_features["bark"] = quirk_mob.vocal_bark_id
	old_features["taur"] = quirk_mob.dna.features["taur"]
	old_features["eye_type"] = quirk_mob.dna.species.eye_type

/datum/quirk/werewolf/post_add()
	// Define quirk action
	var/datum/action/cooldown/werewolf/transform/quirk_action = new

	// Grant quirk action
	quirk_action.Grant(quirk_holder)

/datum/quirk/werewolf/remove()
	// Define quirk action
	var/datum/action/cooldown/werewolf/transform/quirk_action = locate() in quirk_holder.actions

	// Revoke quirk action
	quirk_action.Remove(quirk_holder)
*/
