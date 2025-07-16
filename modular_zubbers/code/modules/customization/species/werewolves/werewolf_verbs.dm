/mob/living/carbon/proc/beast_form()
	set name = "Enter Werewolf Form"
	set desc = "Succumb to the rage and turn into a werewolf."
	set category = "Werewolf"
	var/obj/item/organ/brain/werewolf/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/beast_form = TRAIT_BEAST_FORM
	if(!has_trait(beast_form))
		enter_beast_form()
	else
		leave_beast_form()
