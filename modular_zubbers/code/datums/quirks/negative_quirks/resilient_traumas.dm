/datum/quirk/resilient_traumas
	name = "Unrobust Brain"
	desc = "Your nervous system is particularly weak, making you more susceptible to neurological traumas. All of the brain traumas you get will be more resilient and could be permanent."
	icon = FA_ICON_HOUSE_CRACK //replace with something more fitting, i can't find anything nice looking for this
	value = -4
	mob_trait = TRAIT_RESILIENT_TRAUMAS
	gain_text = span_danger("Your brain becomes more soft!")
	lose_text = span_notice("Your brain hardens again...")
	medical_record_text = "Patient's brain is particularly sensitive to brain traumas."
	hardcore_value = 4
	var/hardcore_mode = FALSE
	var/permanent_traumas = FALSE

/datum/quirk_constant_data/resilient_traumas
	associated_typepath = /datum/quirk/resilient_traumas
	customization_options = list(
		/datum/preference/toggle/hardcore_mode,
		/datum/preference/toggle/permanent_traumas
	)

/datum/preference/toggle/hardcore_mode
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "resilient_traumas_hardcore"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/hardcore_mode/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/hardcore_mode/create_default_value()
	return FALSE

/datum/preference/toggle/permanent_traumas
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "resilient_traumas_permanent_traumas"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/permanent_traumas/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/permanent_traumas/create_default_value()
	return FALSE

/datum/quirk/resilient_traumas/post_add()
	hardcore_mode = quirk_holder.client.prefs.read_preference(/datum/preference/toggle/hardcore_mode)
	permanent_traumas = quirk_holder.client.prefs.read_preference(/datum/preference/toggle/permanent_traumas)
	return ..()

/datum/brain_trauma/on_gain()
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_RESILIENT_TRAUMAS))
		if(resilience == TRAUMA_RESILIENCE_WOUND || resilience >= TRAUMA_RESILIENCE_ABSOLUTE)
			return

		var/datum/quirk/resilient_traumas/quirk = owner.get_quirk(/datum/quirk/resilient_traumas)
		if(resilience == TRAUMA_RESILIENCE_LOBOTOMY || (quirk.hardcore_mode && resilience > TRAUMA_RESILIENCE_BASIC))
			resilience = quirk.permanent_traumas ? TRAUMA_RESILIENCE_ABSOLUTE : TRAUMA_RESILIENCE_MAGIC
			return

		resilience = quirk.hardcore_mode ? TRAUMA_RESILIENCE_LOBOTOMY : resilience + 1
