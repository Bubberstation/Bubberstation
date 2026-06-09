/datum/mkultra_command/sleep_command
	name = "Sleep"
	description = "Make your victim sleep for 60 seconds."
	feedback = "falls asleep instantly!"
	trigger = "go to sleep|slumber|rest|take a nap"
	phase_requirement = 2
	cooldown = 4 MINUTES

/datum/mkultra_command/sleep_command/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/victim = owner
	if(HAS_TRAIT(victim, TRAIT_KNOCKEDOUT))
		to_chat(source, span_warning("[victim] is already fast asleep!"))
		return FALSE
	victim.SetSleeping(1 MINUTES)
	return TRUE
