/datum/quirk/prosthetic_organ
	name = "Prosthetic Organ"
	desc = "An accident caused you to lose one of your organs. Because of this, you now have a surplus prosthetic!"
	icon = FA_ICON_LUNGS
	value = -3
	medical_record_text = "During physical examination, patient was found to have a low-budget prosthetic organ. \
		<b>Removal of these organs is known to be dangerous to the patient as well as the practitioner.</b>"
	hardcore_value = 3
	mail_goodies = list(/obj/item/storage/organbox)
	/// The slot to replace, in string form
	var/slot_string = "organ"
	/// The original organ from before the prosthetic was applied
	var/obj/item/organ/old_organ

/datum/quirk_constant_data/prosthetic_organ
	associated_typepath = /datum/quirk/prosthetic_organ
	customization_options = list(/datum/preference/choiced/prosthetic_organ)

/datum/quirk/prosthetic_organ/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/static/list/organ_slots = list(
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_BRAIN,
	)
	var/preferred_organ = GLOB.organ_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/prosthetic_organ)]
	if(isnull(preferred_organ))  //Client is gone or they chose a random prosthetic
		preferred_organ = GLOB.organ_choice[pick(GLOB.organ_choice)]

	var/list/possible_organ_slots = organ_slots.Copy()
	if(!CAN_HAVE_BLOOD(human_holder))
		possible_organ_slots -= ORGAN_SLOT_HEART
	if(HAS_TRAIT(human_holder, TRAIT_NOBREATH))
		possible_organ_slots -= ORGAN_SLOT_LUNGS
	if(HAS_TRAIT(human_holder, TRAIT_LIVERLESS_METABOLISM))
		possible_organ_slots -= ORGAN_SLOT_LIVER
	if(HAS_TRAIT(human_holder, TRAIT_NOHUNGER))
		possible_organ_slots -= ORGAN_SLOT_STOMACH
	if(HAS_TRAIT(human_holder, TRAIT_BRAINLESS_CARBON))
		possible_organ_slots -= ORGAN_SLOT_BRAIN
	if(!length(organ_slots)) //what the hell
		return

	var/organ_slot = pick(possible_organ_slots)
	if(preferred_organ in possible_organ_slots)
		organ_slot = preferred_organ
	var/obj/item/organ/prosthetic
	switch(organ_slot)
		if(ORGAN_SLOT_HEART)
			prosthetic = new /obj/item/organ/heart/cybernetic/surplus
			slot_string = "heart"
		if(ORGAN_SLOT_LUNGS)
			prosthetic = new /obj/item/organ/lungs/cybernetic/surplus
			slot_string = "lungs"
		if(ORGAN_SLOT_LIVER)
			prosthetic = new /obj/item/organ/liver/cybernetic/surplus
			slot_string = "liver"
		if(ORGAN_SLOT_STOMACH)
			prosthetic = new /obj/item/organ/stomach/cybernetic/surplus
			slot_string = "stomach"
		if(ORGAN_SLOT_BRAIN)
			prosthetic = new /obj/item/organ/brain/cybernetic/surplus
			slot_string = "brain"
	medical_record_text = "During physical examination, patient was found to have a low-budget prosthetic [slot_string]. \
		Removal of these organs is known to be dangerous to the patient as well as the practitioner."
	old_organ = human_holder.get_organ_slot(organ_slot)
	prosthetic.Insert(human_holder, special = TRUE)
	old_organ.moveToNullspace()
	STOP_PROCESSING(SSobj, old_organ)

/datum/quirk/prosthetic_organ/post_add()
	to_chat(quirk_holder, span_bolddanger("Your [slot_string] has been replaced with a surplus organ. It is weak and highly unstable. \
	Additionally, any EMP will make it cease full functions for a time."))

/datum/quirk/prosthetic_organ/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(old_organ)
		if(old_organ.slot == AUGMENT_SLOT_BRAIN) //there's no way this works again

			var/obj/item/organ/brain/current_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
			var/obj/item/organ/brain/insert_brain = old_organ //less confusing name

			var/datum/mind/holder_mind = human_holder.mind

			insert_brain.modular_persistence = current_brain.modular_persistence
			insert_brain.modular_persistence?.owner = insert_brain
			current_brain.modular_persistence = null

			insert_brain.copy_traits_from(current_brain)
			insert_brain.Insert(human_holder, special = TRUE)
			current_brain.moveToNullspace()  // Maybe this works also lmao
			STOP_PROCESSING(SSobj, current_brain)

			if(!holder_mind)
				return

			holder_mind.transfer_to(human_holder, TRUE)
	else
		old_organ.Insert(quirk_holder, special = TRUE)
		old_organ = null
