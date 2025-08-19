/obj/item/organ/brain/lycan
	name = "lupine brain"
	desc = "A larger than average, albeit slightly smoother brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	actions_types = list(/datum/action/cooldown/spell/beast_form)

/obj/item/organ/brain/lycan/proc/enter_beast_form()
	var/datum/species/human/cursekin/current_wolf = owner.dna.species
	if(!istype(current_wolf) && HAS_TRAIT_FROM(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT))
		return
	owner.visible_message(span_warning("[owner] grows massive, their body quickly getting covered in fur!"))
	owner.set_species(current_wolf.lycanthropy_species, TRUE, TRUE, FALSE)
	ADD_TRAIT(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	owner.dna.features["body_size"] = 2
	owner.maptext_height = 32 * owner.dna.features["body_size"] //Adjust runechat height
	owner.dna.update_body_size()
	owner.mob_size = MOB_SIZE_LARGE
	playsound(owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 100)

/obj/item/organ/brain/lycan/proc/leave_beast_form()
	var/datum/species/current_wolf = owner.dna.species
	if(isnull(current_wolf) && !HAS_TRAIT_FROM(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT))
		return
	owner.visible_message(span_warning("[owner] shrinks down, their fur receding!"))
	owner.set_species(/datum/species/human/cursekin, TRUE, TRUE, FALSE)
	REMOVE_TRAIT(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	owner.dna.features["body_size"] = owner?.client?.prefs ?owner?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) : 1
	owner.maptext_height = 32 * owner.dna.features["body_size"]
	owner.dna.update_body_size()
	owner.mob_size = MOB_SIZE_HUMAN
	playsound(owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 100)

/obj/item/organ/brain/lycan/proc/toggle_beast_form(mob/user)
	set name = "Enter/Leave Lycan Form"
	set desc = "Succumb to the rage and turn into a lycan."
	set category = "Lycan"
	if(user && !HAS_TRAIT(user, TRAIT_BEAST_FORM))
		enter_beast_form()
	else if(user && HAS_TRAIT(user, TRAIT_BEAST_FORM))
		leave_beast_form()
