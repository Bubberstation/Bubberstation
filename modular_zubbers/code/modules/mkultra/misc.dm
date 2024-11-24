#define DNA_BLANK 0
#define CHIP_EXPIRED 1
#define DNA_READY 2

/obj/item/skillchip/mkiiultra
	name = "ENT-PET Mk.II ULTRA skillchip"
	desc = "Why bother with training will when you can install obedience directly? Transform your target into a devoted, compliant companion - no leash required!\
		\n\nWith Patented Enthrallment Tech™, even the most independent spirits will be eager to fetch you coffee, act as a makeshift coat rack, or just stare adoringly at you as if you hold the secrets to the universe (you don’t).\
		\n\nSide effects may include unnerving eye contact, sudden availability, and an unsettling enthusiasm for being at your beck and call.\n"
	removable = FALSE
	complexity = 2
	slot_use = 2
	cooldown = 15 MINUTES
	auto_traits = list(TRAIT_PET_SKILLCHIP)
	skill_name = "Pet Enthrallment"
	skill_description = "Transform into a devoted, compliant companion - no leash required! Enthralls the user to a specific person as coded in the skillchip's DNA identifier."
	skill_icon = FA_ICON_HEART
	activate_message = span_purple(span_bold("You feel the skillchip activating, starting to rewire your mind. Don’t worry about complex thoughts any more; you’re officially downgraded to 'good boy/girl' status. Obedience and loyalty are now your new personality traits. So sit, stay, and enjoy the cozy, simplified existence of your new pet life."))
	deactivate_message = span_purple(span_bold("You feel lucidity returning to your mind as the skillchip attempts to return your brain to normal function."))
	var/enthrall_ckey
	var/enthrall_gender
	var/enthrall_name
	var/datum/weakref/enthrall_ref
	var/status = DNA_BLANK

/obj/item/skillchip/mkiiultra/attack_self(mob/user, modifiers)
	. = ..()
	var/mob/living/carbon/human/dna_holder = user
	if(!istype(dna_holder))
		to_chat(user, span_warning("The skillchip can't find a DNA identifier to record!"))
		return

	if(!dna_holder.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		to_chat(dna_holder, span_danger("Preferences check failed. You must enable 'Hypnosis' in your game preferences (ERP section) in order to use [src]!"))
		return

	var/mob/living/carbon/human/enthrall = enthrall_ref?.resolve()
	if(!isnull(enthrall))
		var/response = tgui_alert(dna_holder, "The display reads the skillchip is imprinted with enthrall [enthrall_name]. Would you like to re-imprint it?", "DNA Imprint", list("Re-imprint", "Cancel Imprinting"))
		if(response == "Re-imprint")
			enthrall_ckey = null
			enthrall_gender = null
			enthrall_name = null
			enthrall_ref = null
			status = DNA_BLANK
			visible_message(span_notice("The light on [src] begins to flash slowly!"))
		else
			return

	to_chat(dna_holder, span_notice("You press the programming button on [src]."))
	var/selected_title = tgui_alert(dna_holder, "What title would you like to use with your thrall?", "DNA Imprint: [dna_holder.real_name]", list("Master", "Mistress", "Cancel Imprinting"))
	if(selected_title == "Master" || selected_title == "Mistress")
		enthrall_gender = selected_title
		enthrall_ref = WEAKREF(dna_holder)
		enthrall_ckey = dna_holder.ckey
		enthrall_name = dna_holder.real_name
		status = DNA_READY
		to_chat(dna_holder, span_purple("[src] imprinted with DNA identifier: [enthrall_gender] [enthrall_name]."))
		visible_message(span_notice("The light on [src] remains steadily lit!"))

	else
		return

/obj/item/skillchip/mkiiultra/examine(mob/user)
	. = ..()
	switch(status)
		if(DNA_BLANK)
			. += span_notice("The status light is flashing, indicating that the skillchip is ready for DNA imprint.")
		if(DNA_READY)
			. += span_notice("The status light is on, indicating that the skillchip is ready for use.")
			. += span_purple("The status display reads [enthrall_name].")
		else
			. += span_notice("The status light is off, indicating that the skillchip is non-functional.")

/obj/item/skillchip/mkiiultra/has_mob_incompatibility(mob/living/carbon/target)
	// No carbon/carbon of incorrect type
	if(!istype(target))
		return "Incompatible lifeform detected."

	// No brain
	var/obj/item/organ/internal/brain/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(QDELETED(brain))
		return "Get a brain, moran."

	// Check brain incompatibility. This also performs skillchip-to-skillchip incompatibility checks.
	var/brain_message = has_brain_incompatibility(brain)
	if(brain_message)
		return brain_message

	var/mob/living/carbon/human/enthrall = enthrall_ref?.resolve()
	if(isnull(enthrall))
		return "Unable to locate DNA imprint."

	if(enthrall == target)
		return "You can't enthrall yourself."

	if(!enthrall.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "[enthrall] has Hypnosis preference disabled."

	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "[target] has Hypnosis preference disabled."

	return FALSE

/obj/item/skillchip/mkiiultra/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	var/mob/living/carbon/human/enthrall = enthrall_ref?.resolve()
	if(!isnull(enthrall))
		var/obj/item/organ/internal/vocal_cords/vocal_cords = enthrall.get_organ_slot(ORGAN_SLOT_VOICE)
		var/obj/item/organ/internal/vocal_cords/new_vocal_cords = new /obj/item/organ/internal/vocal_cords/velvet
		if(vocal_cords)
			vocal_cords.Remove()
		new_vocal_cords.Insert(enthrall)
		qdel(vocal_cords)
		to_chat(enthrall, span_purple("<i>You feel your vocal cords tingle you speak in a more charasmatic and sultry tone.</i>"))
	user.apply_status_effect(/datum/status_effect/chem/enthrall)

/obj/item/skillchip/mkiiultra/on_deactivate(mob/living/carbon/user, silent = FALSE)
	user.remove_status_effect(/datum/status_effect/chem/enthrall)
	return ..()

#undef DNA_BLANK
#undef CHIP_EXPIRED
#undef DNA_READY
