/obj/item/organ/brain/werewolf
	name = "lupine brain"
	desc = "A larger than average brain. This one seems slightly smoother than a human's brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	COOLDOWN_DECLARE(beast_form_cooldown)

/obj/item/organ/brain/werewolf/on_life()
	if(beast_form_cooldown && COOLDOWN_FINISHED(src, beast_form_cooldown))
		to_chat(owner, span_warning("You feel the hunger returning!"))

/obj/item/organ/brain/werewolf/proc/enter_beast_form()
	var/datum/species/human/werewolf/werehuman = owner.dna?.species
	if(beast_form_cooldown)
		to_chat(owner, span_warning("You feel too exhausted to transform again so soon!"))
		return
	if(!istype(werehuman))
		return
	owner.visible_message(span_warning("[owner] grows massive, their body quickly getting covered in fur!"))
	owner.set_species(SPECIES_WEREWOLF, TRUE, TRUE, FALSE)
	owner.dna.features["body_size"] = 1.24 // Should be big without looking wonky.
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_LARGE
	owner.add_traits(list(TRAIT_BEAST_FORM))

/obj/item/organ/brain/werewolf/proc/leave_beast_form()
	var/datum/species/werewolf/current_wolf = owner.dna?.species
	if(!istype(current_wolf))
		return
	owner.visible_message(span_warning("[owner] shrinks down, their fur receding!"))
	owner.set_species(SPECIES_WEREHUMAN, TRUE, TRUE, FALSE)
	owner.dna.features["body_size"] = 1 // Reset to normal size.
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_HUMAN
	owner.remove_traits(list(TRAIT_BEAST_FORM))
	COOLDOWN_START(src, beast_form_cooldown, 15 MINUTES)

/obj/item/organ/brain/werewolf/proc/beast_form(mob/user)
	set name = "Enter/Leave Werewolf Form"
	set desc = "Succumb to the rage and turn into a werewolf."
	set category = "Werewolf"
	var/beast_form = TRAIT_BEAST_FORM
	if(!HAS_TRAIT(user, beast_form))
		enter_beast_form()
	else
		leave_beast_form()
