/datum/species/human/cursekin
	name = "\improper Cursekin"
	id = SPECIES_CURSEKIN
	inherent_traits = list(
		TRAIT_LYCAN,
		TRAIT_MUTANT_COLORS, // More customization options.
	)
	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/lycan

/datum/species/human/cursekin/get_species_description()
	return list(placeholder_description)

/datum/species/human/cursekin/get_species_lore()
	return list(placeholder_lore)

/datum/species/human/cursekin/create_pref_unique_perks()

/datum/species/human/cursekin/prepare_human_for_preview(mob/living/carbon/human/cursekin)
	var/main_color = "#362d23"
	var/secondary_color = "#9c5852"
	var/tertiary_color = "#CCF6E2"
	cursekin.set_species(/datum/species/lycan)
	cursekin.dna.features["mcolor"] = main_color
	cursekin.dna.features["mcolor2"] = secondary_color
	cursekin.dna.features["mcolor3"] = tertiary_color
	cursekin.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	cursekin.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	cursekin.dna.features["legs"] = "Digitigrade Legs"
	regenerate_organs(cursekin, src, visual_only = TRUE)
	cursekin.update_body(TRUE)

/mob/living/carbon/human/species/cursekin
	race = /datum/species/human/cursekin

/datum/species/human/cursekin/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	RegisterSignal(gainer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))

/datum/species/human/cursekin/proc/organ_reject(mob/living/source, obj/item/organ/inserted)
	SIGNAL_HANDLER

	if(isnull(source))
		return
	var/obj/item/organ/insert_organ = inserted
	if(insert_organ.organ_flags & (ORGAN_ORGANIC | ORGAN_UNREMOVABLE))
		return
	addtimer(CALLBACK(src, PROC_REF(reject_now), source, inserted), 1 SECONDS)

/datum/species/human/cursekin/proc/reject_now(mob/living/source, obj/item/organ/organ)

	organ.Remove(source)
	organ.forceMove(get_turf(source))
	to_chat(source, span_danger("Your body rejected [organ]!"))
	organ.balloon_alert_to_viewers("rejected!", vision_distance = 1)

/datum/species/human/cursekin/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	if(gainer)
		UnregisterSignal(gainer, COMSIG_CARBON_GAIN_ORGAN)
