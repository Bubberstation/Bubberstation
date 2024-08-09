/datum/species/abductor/lesser
	id = SPECIES_ABDUCTOR_STATION
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
	)

/datum/species/abductor/lesser/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	var/tongue = C.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(istype(/obj/item/organ/internal/tongue/abductor))
		tongue.mothership = "SpaceStation13"
	else
		return

/datum/species/abductor/lesser/get_physical_attributes()
	return "Abductors do not need to breathe, eat, do not have blood, a heart, stomach, or lungs and cannot be infected by human viruses. \
		Their chunky tridactyl hands make it hard to operate human equipment."

/datum/species/abductor/get_species_description()
	return list("Abductors, colloquially known as \"Greys\" (or \"Grays\"), \
		are, three fingered, pale skinned inquisitive aliens who can't communicate well to the average crew-member.",)

/datum/outfit/deathmatch_loadout/abductor/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	var/tongue = user.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(istype(/obj/item/organ/internal/tongue/abductor))
		tongue.mothership = "deathmatch"
	else
		return
