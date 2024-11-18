/datum/quirk/arachnid
	name = "Silkspinner"
	desc = "Your bodily anatomy allows you to spin webs and cocoons, even though you aren't an arachnid! This quirk does nothing for members of the arachnid species."
	value = 2
	medical_record_text = "Patient has attempted to cover the room in webs, claiming to be \"making a nest\"."
	mob_trait = TRAIT_ARACHNID
	gain_text = span_notice("You feel a strange sensation near your anus...")
	lose_text = span_notice("You feel like you can't spin webs anymore...")
	icon = FA_ICON_SPIDER

/datum/quirk/arachnid/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check if already an arachnid
	if(is_species(quirk_mob,/datum/species/arachnid))
		// Warn user and return
		to_chat(quirk_mob, span_warning("As an arachnid, the Arachnid quirk does nothing for you! These abilities are innate to your species."))
		return

	// Define arachnid abilities
	var/datum/action/innate/arachnid/spin_web/ability_web = new
	var/datum/action/innate/arachnid/spin_cocoon/ability_cocoon = new

	// Grant abilities
	ability_web.Grant(quirk_mob)
	ability_cocoon.Grant(quirk_mob)

	// Grant arachnid traits
	quirk_mob.add_traits(list(
		TRAIT_WEB_SURFER,
		TRAIT_WEB_WEAVER,
	), TRAIT_ARACHNID)

	// Check if mob was already a bug
	if(!(quirk_mob.mob_biotypes & MOB_BUG))
		// Add bug biotype
		quirk_mob.mob_biotypes += MOB_BUG

/datum/quirk/arachnid/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check if already an arachnid
	if(is_species(quirk_mob,/datum/species/arachnid))
		return

	// Define arachnid abilities
	var/datum/action/innate/arachnid/spin_web/ability_web = locate(/datum/action/innate/arachnid/spin_web) in quirk_mob.actions
	var/datum/action/innate/arachnid/spin_cocoon/ability_cocoon = locate(/datum/action/innate/arachnid/spin_cocoon) in quirk_mob.actions

	// Revoke abilities
	ability_web?.Remove(quirk_mob)
	ability_cocoon?.Remove(quirk_mob)

	// Revoke arachnid traits
	quirk_mob.remove_traits(list(
		TRAIT_WEB_SURFER,
		TRAIT_WEB_WEAVER,
	), TRAIT_ARACHNID)

	// Check if species should still be a bug
	if(!(quirk_mob.dna?.species?.inherent_biotypes & MOB_BUG))
		// Remove bug biotype
		quirk_mob.mob_biotypes -= MOB_BUG
