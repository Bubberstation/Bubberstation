/obj/item/organ/brain/werewolf
	name = "lupine brain"
	desc = "A larger than average brain. This one seems slightly smoother than a human's brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	COOLDOWN_DECLARE(beast_form_cooldown)

/obj/item/organ/brain/werewolf/on_life()
	if(beast_form_cooldown && COOLDOWN_FINISHED(src, beast_form_cooldown))
		to_chat(owner, span_warning("You feel the hunger returning!"))

/obj/item/organ/brain/werewolf/proc/enter_beast_form()
	var/datum/species/human/werewolf/werewolf = owner.dna?.species
	if(beast_form_cooldown)
		to_chat(owner, span_warning("You feel too exhausted to transform again so soon!"))
		return
	if(!istype(werewolf))
		return
	owner.visible_message(span_warning("[owner] grows massive, their body quickly getting covered in fur!"))
	owner.set_species(datum/species/werewolf, TRUE)
	owner.add_traits(list(TRAIT_OVERSIZED, TRAIT_BEAST_FORM))
/obj/item/organ/brain/werewolf/proc/leave_beast_form()
	var/datum/species/werewolf/werewolf = owner.dna?.species
	if(!istype(werewolf))
		return
	owner.visible_message(span_warning("[owner] shrinks down, their fur receding!"))
	owner.set_species(datum/species/human/werewolf, TRUE)
	owner.remove_traits(TRAIT_OVERSIZED, TRAIT_BEAST_FORM)
	COOLDOWN_START(src, beast_form_cooldown, 15 MINUTES)
