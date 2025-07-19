/datum/quirk/pseudo_respiration
	name = "Pseudo-Respiration"
	desc = "(Hemophage only) Despite your condition you for whatever reason still require to breathe."
	icon = FA_ICON_MASK_VENTILATOR
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY
	gain_text = span_danger("You feel the urge to take a breath...")
	lose_text = span_notice("You no longer feel the need to breathe.")
	medical_record_text = "Patient reports the need to breathe despite their hemophagic virus."
	hardcore_value = 0
	species_whitelist = list(SPECIES_HEMOPHAGE)

/datum/quirk/pseudo_respiration/add(client/client_source)
	var/mob/living/carbon/human/breather = quirk_holder
	if(istype(breather))
		breather.remove_traits(list(TRAIT_NOBREATH))
	if(!istype(breather))
		return
	var/obj/item/organ/lungs/lungs_added = new /obj/item/organ/lungs
	lungs_added.Insert(breather, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	breather.dna.species.mutantlungs = /obj/item/organ/lungs

/datum/quirk/pseudo_respiration/remove()
	var/mob/living/carbon/human/no_breather = quirk_holder
	if(istype(no_breather))
		no_breather.add_traits(list(TRAIT_NOBREATH))
	var/obj/item/organ/lungs/lungs_added = new /obj/item/organ/lungs
	lungs_added.Remove(no_breather, special = TRUE, movement_flags = DELETE_IF_REPLACED)
