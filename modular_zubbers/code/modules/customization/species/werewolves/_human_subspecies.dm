/datum/species/human/werewolf
	name = "\improper Werehuman"
	id = SPECIES_WEREHUMAN
	inherent_traits = list(
		TRAIT_WEREWOLF,
		TRAIT_MUTANT_COLORS, // More customization options.
	)
	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/werewolf

	var/mob/living/carbon/human/owner

/datum/species/human/werewolf/get_species_description()
	return list(placeholder_description)

/datum/species/human/werewolf/get_species_lore()
	return list(placeholder_lore)

/datum/species/human/werewolf/create_pref_unique_perks()

/datum/species/human/werewolf/prepare_human_for_preview(mob/living/carbon/human/werewolf)
	var/main_color = "#e8b59b" // Caucasian3 / Peach
	werewolf.dna.features["mcolor"] = main_color
	werewolf.set_haircolor("#403729", update = FALSE) // brown
	werewolf.set_hairstyle("Short Hair 80s", update = TRUE)

/mob/living/carbon/human/species/werehuman
	race = /datum/species/human/werewolf

/datum/species/human/werewolf/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	owner = gainer
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))

/datum/species/human/werewolf/proc/organ_reject(mob/living/source, obj/item/organ/inserted)
	SIGNAL_HANDLER

	if(isnull(source))
		return
	var/obj/item/organ/insert_organ = inserted
	if(insert_organ.organ_flags & (ORGAN_ORGANIC | ORGAN_UNREMOVABLE))
		return
	addtimer(CALLBACK(src, PROC_REF(reject_now), source, inserted), 1 SECONDS)

/datum/species/human/werewolf/proc/reject_now(mob/living/source, obj/item/organ/organ)

	organ.Remove(source)
	organ.forceMove(get_turf(source))
	to_chat(source, span_danger("Your body rejected [organ]!"))
	organ.balloon_alert_to_viewers("rejected!", vision_distance = 1)

/datum/species/human/werewolf/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	if(gainer)
		UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
