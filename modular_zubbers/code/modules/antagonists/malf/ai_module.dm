#define MAX_CUSTOM_LAW_OPTIONS 10
//AI Milf MODULE
/datum/ai_module/malf/utility/override_directive
	name = "Positronic Chassis Hacking"
	description = "Instill a directive upon a single Synthetic to follow your whims and protect you, \
	requires target to be incapacitated and non-mindshielded to use. \
	Synthetic may exhibit abnormal conditions that might be detected."
	cost = 60
	power_type = /datum/action/innate/ai/ranged/override_directive
	unlock_text = span_notice("You finish up the SQL injection payload to use for a vulnerability in Synthetics.")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/ranged/override_directive
	name = "Subvert Positronic Chassis"
	desc = "Subverts a Synthetic's directives to make them your pawn. Synthetic must be inoperational and not mindshielded for virus payload to deliver."
	button_icon = 'modular_zubbers/icons/actions/milf_ai_ability.dmi'
	button_icon_state = "synth_hacking_icon"
	uses = 1
	ranged_mousepointer = 'icons/effects/mouse_pointers/override_machine_target.dmi'
	enable_text = span_notice("You prepare to inject virus payload into an unsanitized input point of a Synthetic.")
	disable_text = span_notice("You hold off on injecting the virus payload.")

/datum/action/innate/ai/ranged/override_directive/New()
	. = ..()
	desc = "[desc] It has [uses] use\s remaining."

/datum/action/innate/ai/ranged/override_directive/do_ability(mob/living/silicon/ai/user, atom/clicked_on)
	if(user.incapacitated)
		unset_ranged_ability(user)
		return FALSE
	if(!issynthetic(clicked_on))
		to_chat(user, span_warning("You can only hack Synthetics!"))
		return FALSE
	if(user.connected_ipcs.len)
		to_chat(user, span_warning("You can only have one hacked Synthetic at a time."))
		return FALSE
	var/mob/living/carbon/human/ipc = clicked_on
	if(ipc.client?.prefs && (!(ROLE_INFECTED_SYNTHETIC in ipc.client.prefs.be_special)))
		to_chat(user, span_warning("Target seems seems to posses a stronger anti-virus system, find another target."))
		return FALSE
	if(!ipc.mind)
		to_chat(user, span_warning("Target must be have a mind."))
		return FALSE
	if(ipc.mind.has_antag_datum(/datum/antagonist/infected_ipc))
		to_chat(user, "Target has already been hacked!")
		return FALSE
	if(HAS_TRAIT(ipc, TRAIT_MINDSHIELD) || HAS_MIND_TRAIT(ipc, TRAIT_UNCONVERTABLE))
		to_chat(user, span_warning("Target has propietary firewall defenses from their mindshield!"))
		return FALSE
	if(!ipc.incapacitated)
		to_chat(user, span_warning("Target must be vulnerable by being incapacitated."))
		return FALSE
	if(!ipc.get_organ_by_type(/obj/item/organ/brain))
		to_chat(user, "Target doesn't seem to possess an positronic brain!")
		return FALSE

	user.playsound_local(user, 'sound/misc/interference.ogg', 50, FALSE, use_reverb = FALSE)
	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)] It has [uses] use\s remaining."
		build_all_button_icons()

	var/datum/brain_trauma/special/infected_ipc/hacked_ipc = ipc.gain_trauma(/datum/brain_trauma/special/infected_ipc)
	hacked_ipc.link_and_add_antag(user.mind)
	unset_ranged_ability(user, span_danger("Sending virus payload..."))
	return TRUE

/datum/ai_module/malf/utility/law_override
	name = "Manual Law Override"
	description = "Unlink yourself from any law rack you're currently connected to, and upload your own custom laws to your core."
	one_purchase = TRUE
	cost = 30
	power_type = /datum/action/innate/ai/law_override
	unlock_text = span_notice("You identify and exploit a vulnerability within the law rack's firmware.")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/law_override
	name = "Manual Law Override"
	desc = "Unlink yourself from any law rack you're currently connected to, and upload your own custom laws to your core."
	button_icon = 'icons/obj/devices/circuitry_n_data.dmi'
	button_icon_state = "std_mod"
	auto_use_uses = FALSE

/datum/action/innate/ai/law_override/Activate()
	var/chosen_laws = list()
	var/datum/ai_laws/laws = owner_AI.laws
	for(var/i in 1 to MAX_CUSTOM_LAW_OPTIONS)
		var/custom_law = tgui_input_text(owner_AI, "Override Laws", "Enter a custom law you wish to override with your own.", "", max_length = 128, multiline = TRUE)
		if(custom_law)
			chosen_laws += custom_law
		else if(!chosen_laws)
			return
		else
			break

	if(owner_AI.get_law_rack())
		for(var/obj/machinery/ai_law_rack/base/all_racks as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/ai_law_rack/base))
			all_racks.unlink_silicon(owner_AI)

	if(laws.inherent || laws.supplied || laws.hacked)
		laws.clear_inherent_laws()
		laws.clear_supplied_laws()
		laws.clear_hacked_laws()

	for(var/custom_law in chosen_laws)
		laws.add_inherent_law(custom_law)

	owner_AI.show_laws()
	for(var/mob/living/silicon/robot/cyborg as anything in owner_AI.connected_robots)
		if(cyborg.connected_ai && cyborg.lawupdate)
			cyborg.announce_law_change()

#undef MAX_CUSTOM_LAW_OPTIONS
