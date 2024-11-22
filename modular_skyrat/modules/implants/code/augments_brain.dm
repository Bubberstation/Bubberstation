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

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/emp_act(severity)
	. = ..()
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	
	owner.adjust_stutter(30 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(reboot)), 180 / severity)
	to_chat(owner, span_warning("You feel overwhelmed!"))
	implant_disabled(owner)


/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/implant_disabled()
	organ_flags |= ORGAN_FAILING
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	owner.remove_language(/datum/language/marish/empathy, source = LANGUAGE_IMPLANT)

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/implant_ready()
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	owner.grant_language(/datum/language/marish/empathy, source = LANGUAGE_IMPLANT)
	if(owner)
		to_chat(owner, span_abductor("Your mind opens to others. You can hear the thoughts of those around you, but only faintly."))

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/on_mob_remove(mob/living/carbon/implant_owner)
	. = ..()
	implant_disabled(owner = implant_owner)
	if(QDELETED(src))
		return
	to_chat(implant_owner, span_abductor("Your mind closes from others. It's quiet, now."))

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/on_mob_insert(mob/living/carbon/receiver)
	. = ..()
	to_chat(owner, span_abductor("You begin to feel an awareness of those around you."))
	addtimer(CALLBACK(src, PROC_REF(implant_ready)), 90)

/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
	implant_ready()

//code mostly lifted from shadekins
	
/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/modify_speech(datum/source, list/speech_args)
	ASYNC
		if((organ_flags & ORGAN_FAILING))
			return
		CALLBACK(source, TYPE_PROC_REF(/obj/item/organ/internal/tongue/shadekin, actually_modify_speech), source = owner, speech_args)
	speech_args[SPEECH_MESSAGE] = "" // Makes it not send to chat verbally
	
/obj/item/organ/internal/cyberimp/brain/empathic_sensor/proc/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] == /datum/language/marish/empathy)
		modify_speech(source, speech_args)

