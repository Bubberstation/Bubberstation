/datum/quirk/genetic_mutation
	name = "Genetic Mutation"
	desc = "After a tragic encounter with the Supermatter, you've gained a genetic mutation."
	icon = FA_ICON_DNA
	value = 6
	gain_text = "You feel like you're ready for the next superhero franchise."
	lose_text = "You feel like you're ready to quit starring in blockbusters."
	medical_record_text = "Patient has an genetic mutation from a supermatter accident."
	var/applied_mutation

/datum/quirk_constant_data/genetic_mutation
	associated_typepath = /datum/quirk/genetic_mutation
	customization_options = list(/datum/preference/choiced/genetic_mutation)

/datum/quirk/genetic_mutation/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/mutation_path = GLOB.genetic_mutation_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/genetic_mutation)]
	applied_mutation = mutation_path
	human_holder.dna.add_mutation(applied_mutation, MUT_OTHER, 0)

/datum/quirk/genetic_mutation/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.remove_mutation(applied_mutation)

/datum/preference/choiced/genetic_mutation
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "genetic_mutation"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/genetic_mutation/init_possible_values()
	return GLOB.genetic_mutation_choice

/datum/preference/choiced/genetic_mutation/create_default_value()
	return "Strength"

/datum/preference/choiced/genetic_mutation/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Genetic Mutation" in preferences.all_quirks

/datum/preference/choiced/genetic_mutation/apply_to_human(mob/living/carbon/human/target, value)
	return
