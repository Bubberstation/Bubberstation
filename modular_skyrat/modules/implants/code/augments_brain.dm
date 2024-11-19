#define LANGUAGE_IMPLANT "implant"

/obj/item/organ/internal/cyberimp/brain/empathic_sensor
	name = "empathic sensor implant"
	desc = "This won't fix your social issues, but it may help you repress them better." //not final
	icon_state = "brain_implant_antidrop"
	var/active = FALSE
	var/list/stored_items = list()
	slot = ORGAN_SLOT_BRAIN_AUG
	var/modifies_speech = TRUE
	
// This should appropriately grant and remove empathy from the implant - important if you are a shadekin for some reason to not remove native languages, and allow the procs to work

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/on_mob_remove(mob/living/carbon/implant_owner)
	. = ..()
	UnregisterSignal(implant_owner, COMSIG_MOB_SAY)
	implant_owner.remove_language(/datum/language/marish/empathy/, source = LANGUAGE_IMPLANT)
	to_chat(implant_owner, span_abductor("Your mind closes from others. It's quiet, now."))

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	RegisterSignal(receiver, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	receiver.grant_language(/datum/language/marish/empathy/, source = LANGUAGE_IMPLANT)
	to_chat(receiver, span_abductor("Your mind opens to others. You can hear the thoughts of those around you, but only faintly."))

//code mostly lifted from shadekins

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] == /datum/language/marish/empathy )
		return modify_speech(source, speech_args)
	
/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/modify_speech(datum/source, list/speech_args)
	ASYNC
		actually_modify_speech(source, speech_args)
	speech_args[SPEECH_MESSAGE] = "" // Makes it not send to chat verbally.

//cumbersomely copied from the empathy language....
/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/actually_modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	user.balloon_alert_to_viewers("ears vibrate", "projecting thoughts...")

	if(!do_after(source, 2 SECONDS, source))
		message = full_capitalize(rot13(message))
	var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")

	user.log_talk(message, LOG_SAY, tag="shadekin")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
	//turn this into a trait maybe?
		var/obj/item/organ/internal/ears/shadekin/ears = living_mob.get_organ_slot(ORGAN_SLOT_EARS)
		var/obj/item/organ/internal/cyberimp/brain/empathic_sensor = living_mob.get_organ_slot(ORGAN_SLOT_BRAIN_AUG)

		if(!istype(ears) && !istype(empathic_sensor))
			continue
			
		to_chat(living_mob, rendered)
		if(living_mob != user)
			living_mob.balloon_alert_to_viewers("ears vibrate", "transmission heard...")
		

	if(length(GLOB.dead_mob_list))
		for(var/mob/dead_mob in GLOB.dead_mob_list)
			if(dead_mob.client)
				var/link = FOLLOW_LINK(dead_mob, user)
				to_chat(dead_mob, "[link] [rendered]")


/obj/item/organ/internal/cyberimp/brain/minesweeper
	name = "minesweeper implant"
	desc = "A research intern had misinterpreted a request for a bomb-seeking implant, and came out with this. It's a better use of your neural functions, really." //no this isnt final
	icon_state = "brain_implant_antidrop"
	var/active = FALSE
	var/list/stored_items = list()
	slot = ORGAN_SLOT_BRAIN_AUG
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	
	var/datum/minesweeper/board

/obj/item/organ/internal/cyberimp/brain/minesweeper/proc/implant_ready()
	if(owner)
		to_chat(owner, span_purple("Your rebooter implant is ready."))

/obj/item/organ/internal/cyberimp/brain/minesweeper/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
	implant_ready()

/obj/item/organ/internal/cyberimp/brain/minesweeper/emp_act(severity)
	. = ..()
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	addtimer(CALLBACK(src, PROC_REF(reboot)), 10 / severity)
	
//the rest of the minesweeper implant's code is in minesweeper.dm
	

/obj/item/organ/internal/cyberimp/brain/remote
	name = "remote access implant"
	desc = "An implant to allow one to control wireless devices with your mind."
	icon_state = "brain_implant_antidrop"
	var/active = FALSE
	var/list/stored_items = list()
	slot = ORGAN_SLOT_BRAIN_AUG
	actions_types = list(/datum/action/item_action/organ_action/toggle)
