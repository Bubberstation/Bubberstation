/obj/item/organ/brain/werewolf
	name = "lupine brain"
	desc = "A larger than average, albeit slightly smoother brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	actions_types = list(/datum/action/cooldown/spell/beast_form)

/obj/item/organ/brain/werewolf/proc/enter_beast_form()
	var/datum/species/human/werewolf/werehuman = owner.dna?.species
	if(!istype(werehuman))
		return
	owner.visible_message(span_warning("[owner] grows massive, their body quickly getting covered in fur!"))
	owner.set_species(/datum/species/werewolf, TRUE, TRUE, FALSE)
	ADD_TRAIT(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	owner.add_quirk(/datum/quirk/oversized)

/obj/item/organ/brain/werewolf/proc/leave_beast_form()
	var/datum/species/werewolf/current_wolf = owner.dna?.species
	if(!istype(current_wolf))
		return
	owner.visible_message(span_warning("[owner] shrinks down, their fur receding!"))
	owner.set_species(/datum/species/human/werewolf, TRUE, TRUE, FALSE)
	REMOVE_TRAIT(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	owner.remove_quirk(/datum/quirk/oversized)
	owner.dna.update_body_size()

/obj/item/organ/brain/werewolf/proc/toggle_beast_form(mob/user)
	set name = "Enter/Leave Werewolf Form"
	set desc = "Succumb to the rage and turn into a werewolf."
	set category = "Werewolf"
	if(user && !HAS_TRAIT(user, TRAIT_BEAST_FORM))
		src.enter_beast_form()
	else if(user && HAS_TRAIT(user, TRAIT_BEAST_FORM))
		src.leave_beast_form()
