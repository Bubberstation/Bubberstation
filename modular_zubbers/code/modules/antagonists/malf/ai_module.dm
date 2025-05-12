//AI Milf MODULE
/datum/ai_module/malf/utility/override_directive
	name = "Positronic Chassis Hacking"
	description = "Instill a directive upon a single Synthetic to follow your whims and protect you, \
	Requires target to be incapacitated and non-mindshielded to use. \
	Synthetic may exhibit abnormal conditions that might be detected."
	cost = 60
	power_type = /datum/action/innate/ai/ranged/override_directive
	unlock_text = span_notice("You finish up the SQL injection payload to use on a vulnerability in Synthetics")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/ranged/override_directive
	name = "Subvert Positronic Chassis"
	desc = "Subverts a Synthetic's directives to make them your pawn. Synthetic must be inoperational and not mindshielded for virus payload to deliver."
	button_icon = 'modular_zubbers/icons/action/milf_ai_ability.dmi'
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
		to_chat(user, span_warning("You can only have one hacked Synthetic at a time"))
		return FALSE
	var/mob/living/carbon/human/ipc = clicked_on
	if(is_special_character(ipc, allow_fake_antags = FALSE))
		to_chat(user, span_warning("Target seems unwilling to be hacked, find another target."))
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
