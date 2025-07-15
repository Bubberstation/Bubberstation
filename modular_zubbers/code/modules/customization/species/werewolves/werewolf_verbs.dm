/mob/living/carbon/proc/beast_form()
	set name = "Enter Werewolf Form"
	set desc = "Succumb to the rage and turn into a werewolf."
	set category = "Werewolf"
	var/obj/item/organ/brain/werewolf/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/datum/species/werewolf/species = dna.species
