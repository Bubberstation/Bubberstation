/obj/item/organ/brain/werewolf
	name = "lupine brain"
	desc = "A larger than average, albeit slightly smoother brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	COOLDOWN_DECLARE(beast_form_cooldown)
	actions_types = list(/datum/action/item_action/organ_action/beast_form)

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
	owner.set_species(/datum/species/werewolf, TRUE, TRUE, FALSE)
	owner.add_traits(list(TRAIT_BEAST_FORM))
	owner.add_quirk(/datum/quirk/oversized)
	owner.drop_everything(FALSE, TRUE, FALSE)

/obj/item/organ/brain/werewolf/proc/leave_beast_form()
	var/datum/species/werewolf/current_wolf = owner.dna?.species
	if(!istype(current_wolf))
		return
	owner.visible_message(span_warning("[owner] shrinks down, their fur receding!"))
	owner.set_species(/datum/species/human/werewolf, TRUE, TRUE, FALSE)
	owner.remove_traits(list(TRAIT_BEAST_FORM))
	owner.remove_quirk(/datum/quirk/oversized)
	owner.dna.update_body_size()
	COOLDOWN_START(src, beast_form_cooldown, 10 MINUTES)

/obj/item/organ/brain/werewolf/proc/beast_form(mob/user)
	set name = "Enter/Leave Werewolf Form"
	set desc = "Succumb to the rage and turn into a werewolf."
	set category = "Werewolf"
	if(user && !HAS_TRAIT(user, TRAIT_BEAST_FORM))
		enter_beast_form()
	else
		leave_beast_form()
