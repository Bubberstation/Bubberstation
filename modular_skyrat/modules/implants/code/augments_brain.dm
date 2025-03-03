#define LANGUAGE_IMPLANT "implant"

/obj/item/organ/cyberimp/brain/empathic_sensor
	name = "empathic sensor implant"
	desc = "This won't fix your social issues, but it may help you repress them better." //not final
	icon_state = "brain_implant_antidrop"
	var/active = FALSE
	var/list/stored_items = list()
	slot = ORGAN_SLOT_BRAIN_CEREBELLUM
	var/modifies_speech = TRUE

// This should appropriately grant and remove empathy from the implant - important if you are a shadekin for some reason to not remove native languages, and allow the procs to work

/obj/item/organ/cyberimp/brain/empathic_sensor/emp_act(severity)
	. = ..()
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return

	organ_flags |= ORGAN_FAILING
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	owner.remove_language(/datum/language/marish/empathy, source = LANGUAGE_IMPLANT)
	addtimer(CALLBACK(src, PROC_REF(reboot)), 180 / severity)
	to_chat(owner, span_warning("You feel overwhelmed!"))
	switch(severity)
		if (EMP_HEAVY)
			owner.adjust_stutter(180 SECONDS)
			owner.adjust_silence(30 SECONDS)
		if (EMP_LIGHT)
			owner.adjust_stutter(90 SECONDS)
			owner.adjust_silence(10 SECONDS)

/obj/item/organ/cyberimp/brain/empathic_sensor/proc/implant_ready()
	if(isnull(owner))
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	owner.grant_language(/datum/language/marish/empathy, source = LANGUAGE_IMPLANT)
	to_chat(owner, span_abductor("Your mind opens to others. You can hear the thoughts of those around you, but only faintly."))

/obj/item/organ/cyberimp/brain/empathic_sensor/on_mob_remove(mob/living/carbon/implant_owner)
	. = ..()
	organ_flags &= ~ORGAN_FAILING
	UnregisterSignal(implant_owner, COMSIG_MOB_SAY)
	implant_owner.remove_language(/datum/language/marish/empathy, source = LANGUAGE_IMPLANT)
	if(QDELETED(src))
		return
	to_chat(implant_owner, span_abductor("Your mind closes from others. It's quiet, now."))

/obj/item/organ/cyberimp/brain/empathic_sensor/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	to_chat(receiver, span_abductor("You begin to feel an awareness of those around you."))
	addtimer(CALLBACK(src, PROC_REF(implant_ready)), 90)

/obj/item/organ/cyberimp/brain/empathic_sensor/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
	implant_ready()

//code mostly lifted from shadekins

/obj/item/organ/cyberimp/brain/empathic_sensor/proc/modify_speech(datum/source, list/speech_args)
	ASYNC
		if(organ_flags & ORGAN_FAILING) //just in case they somehow activate this while the implant is disabled...
			to_chat(owner, span_abductor("You are unable to project your thoughts."))
			return
		actually_modify_speech(source, speech_args)
	speech_args[SPEECH_MESSAGE] = "" // Makes it not send to chat verbally

/obj/item/organ/cyberimp/brain/empathic_sensor/proc/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] == /datum/language/marish/empathy)
		return modify_speech(source, speech_args)

//I couldnt get this to work as a TYPE_PROC_REF. So it's copied.
/obj/item/organ/cyberimp/brain/empathic_sensor/proc/actually_modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/obj/item/organ/ears/shadekin/user_ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	var/mode = istype(user_ears)
	user.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "projecting thoughts...")

	if(!do_after(source, 2 SECONDS, source))
		message = full_capitalize(rot13(message))
	var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")

	user.log_talk(message, LOG_SAY, tag="empathic-sensor")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/ears/shadekin/target_ears = living_mob.get_organ_slot(ORGAN_SLOT_EARS)
		var/obj/item/organ/cyberimp/brain/empathic_sensor/target_implant = living_mob.get_organ_slot(ORGAN_SLOT_BRAIN_CEREBELLUM)

		if(!istype(target_implant))
			continue

		to_chat(living_mob, rendered)
		if(living_mob != user)
			mode = istype(target_ears)
			living_mob.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "transmission heard...")

	if(length(GLOB.dead_mob_list))
		for(var/mob/dead_mob in GLOB.dead_mob_list)
			if(dead_mob.client)
				var/link = FOLLOW_LINK(dead_mob, user)
				to_chat(dead_mob, "[link] [rendered]")
