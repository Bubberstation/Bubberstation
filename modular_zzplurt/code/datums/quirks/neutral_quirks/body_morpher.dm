/datum/quirk/body_morpher
	name = "Body Morpher"
	desc = "Somehow you developed an ability allowing your body to morph and shift itself to modify bodyparts, much like a slimeperson can."
	value = 0
	mob_trait = TRAIT_BODY_MORPHER
	gain_text = span_notice("Your body feels more malleable...")
	lose_text = span_notice("Your body is more firm.")
	medical_record_text = "Patient's body seems unusually malleable."
	var/datum/action/innate/alter_form/alter_form_action

/datum/quirk/body_morpher/add(client/client_source)
	. = ..()

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add quirk ability action datum
	alter_form_action = new
	alter_form_action.Grant(quirk_mob)

/datum/quirk/body_morpher/remove()
	. = ..()

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove quirk ability action datum
	alter_form_action.Remove(quirk_mob)
	QDEL_NULL(alter_form_action)
