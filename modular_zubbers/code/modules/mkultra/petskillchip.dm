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
	var/mob/living/enchanter
	var/title

/obj/item/skillchip/mkiiultra/attack_self(mob/user, modifiers)
	. = ..()
	var/mob/living/dna_holder = user
	if(!istype(dna_holder))
		return
	if(!dna_holder.client.prefs.read_preference(/datum/preference/toggle/erp/hypnosis))
		to_chat(dna_holder, span_warning("Preference check failed! You must enable hypnosis in your game preferences (ERP preferences) to use [src]."))
		return
	if(!isnull(enchanter))
		var/response = tgui_alert(dna_holder, "The display reads that [enchanter] is already imprinted. Would you like to re-imprint?", "DNA Imprint", list("Re-Imprint", "Cancel"))
		if(response != "Re-Imprint" || isnull(response))
			return
		enchanter = null
		visible_message(span_notice("The light on [src] begins to blink slowly."))
		return
	to_chat(dna_holder, span_notice("You press the programming button on [src]."))
	var/selected_title = tgui_input_list(dna_holder, "What title would you like to use?", "Title Selection", list("Master", "Mistress", "Owner", "Cancel Imprinting"))
	if(selected_title == "Cancel Imprinting" || isnull(selected_title))
		return
	title = LOWER_TEXT(selected_title)
	enchanter = dna_holder
	to_chat(dna_holder, span_purple("[src] imprinted with DNA identifier: [selected_title] [dna_holder]."))
	visible_message(span_notice("The light on [src] remains steadily lit."))

/obj/item/skillchip/mkiiultra/examine(mob/user)
	. = ..()
	if(!enchanter)
		. += span_notice("The status light is blinking, indiciating that the skillchip is ready for DNA imprinting.")
	else
		. += span_notice("The status light is on, indicating that it is ready for use.")
		. += span_purple("The status display reads [enchanter]")

/obj/item/skillchip/mkiiultra/has_mob_incompatibility(mob/living/carbon/target)
	. = ..()
	if(isnull(enchanter))
		return "Unable to locate DNA imprint."
	if(enchanter == target)
		return "Unable to enthrall yourself!"
	if(!enchanter.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "[enchanter] has hypnosis preference disabled."
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "You must enable the hypnosis preference."
	return FALSE

/obj/item/skillchip/mkiiultra/on_activate(mob/living/carbon/user, silent)
	. = ..()
	/// No brainwashing.
	RegisterSignal(user, COMSIG_OOC_ESCAPE, PROC_REF(on_ooc_escape))
	user.apply_status_effect(/datum/status_effect/mkultra, enchanter, TRUE, 400, TRUE, list(/datum/mkultra_command/mind_control), title)

/obj/item/skillchip/mkiiultra/on_deactivate(mob/living/carbon/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_OOC_ESCAPE)
	enchanter = null
	user.remove_status_effect(/datum/status_effect/mkultra)

/obj/item/skillchip/mkiiultra/proc/on_ooc_escape()
	SIGNAL_HANDLER

	holding_brain.remove_skillchip(src)
	forceMove(holding_brain.drop_location())
