/mob/living/carbon/proc/suit_transformation()
	set name = "Toggle Suit Transformation"
	set desc = "Either leave or enter your suit."
	set category = "Protean"
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/datum/species/protean/species = dna.species
	if(loc == species.species_modsuit)
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit()
		else
			balloon_alert(src, "incapacitated!")
