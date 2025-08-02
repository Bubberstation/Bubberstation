/datum/quirk/pseudo_respiration
	name = "Pseudo-Respiration"
	desc = "(Hemophage only) Despite your condition you for whatever reason still require to breathe."
	icon = FA_ICON_MASK_VENTILATOR
	value = -2
	quirk_flags = QUIRK_HUMAN_ONLY
	gain_text = span_danger("You feel the urge to take a breath...")
	lose_text = span_notice("You no longer feel the need to breathe.")
	medical_record_text = "Patient reports the need to breathe despite their hemophagic virus."
	hardcore_value = 2
	species_whitelist = list(SPECIES_HEMOPHAGE)

/datum/quirk/pseudo_respiration/add()
	var/mob/living/carbon/human/breather = quirk_holder
	if(!istype(breather))
		return
	REMOVE_TRAIT(breather, TRAIT_NOBREATH, SPECIES_TRAIT)
	var/obj/item/organ/lungs/lungs_added = new()
	lungs_added.Insert(breather, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	breather.dna.species.mutantlungs = lungs_added.type

/datum/quirk/pseudo_respiration/remove()
	var/mob/living/carbon/human/no_breather = quirk_holder
	if(!istype(no_breather))
		return
	ADD_TRAIT(no_breather, TRAIT_NOBREATH, SPECIES_TRAIT)
	var/obj/item/organ/lungs/lungs_added = new()
	lungs_added.Remove(no_breather, special = TRUE, movement_flags = DELETE_IF_REPLACED)

