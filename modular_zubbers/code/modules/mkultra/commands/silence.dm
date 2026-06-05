/datum/mkultra_command/silence
	name = "Invoke Silence"
	description = "Invoke silence in your target."
	feedback = "shuts their mouth tight!"
	trigger = "shh|silence|stop talking|shut up|be quiet|hush"
	cooldown = 60 SECONDS
	phase_requirement = 1

/datum/mkultra_command/silence/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/datum/status_effect/mkultra/ultra = status
	var/mob/living/victim = owner
	if(ultra.phase == 3)
		ADD_TRAIT(victim, TRAIT_MUTE, "mkultra")
		to_chat(victim, span_warning("Your mouth snaps shut [ultra.lewd ? "obediently" : ""] from the spontaneous demand."))
	else
		victim.adjust_silence(20 SECONDS * ultra.phase)
		to_chat(victim, span_warning("Your mouth fumbles shut as [ultra.lewd ? ultra.get_gender() : source] commands silence."))
	return TRUE

/datum/mkultra_command/silence/on_destroy(datum/status_effect/status, mob/owner, mob/source)
	var/mob/living/victim = owner
	REMOVE_TRAIT(victim, TRAIT_MUTE, "mkultra")
	victim.set_silence(0)

/datum/mkultra_command/speak
	name = "Allow Speech"
	description = "Allow your target to speak normally again."
	feedback = "is allowed to speak again."
	trigger = "talk|speak|talk to me|say something|speak"
	phase_requirement = 1

/datum/mkultra_command/speak/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/datum/status_effect/mkultra/ultra = status
	var/mob/living/victim = owner
	REMOVE_TRAIT(victim, TRAIT_MUTE, "mkultra")
	victim.set_silence(0)
	to_chat(victim, span_notice("[ultra.lewd ? ultra.get_gender() : source] allows you to speak again."))
	return TRUE
