/datum/mkultra_command/stun
	name = "Stun"
	description = "Briefly incapacitate your victim."
	feedback = "is suddenly stunned!"
	trigger = "hold on|stop|stun|halt|wait|stand still"
	phase_requirement = 2
	cooldown = 1 MINUTES

/datum/mkultra_command/stun/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return
	var/mob/living/victim = owner
	to_chat(victim, span_warning("Your muscles seize and your feet root in place the second [source] orders you to stop!"))
	victim.Paralyze(10 SECONDS, TRUE)
