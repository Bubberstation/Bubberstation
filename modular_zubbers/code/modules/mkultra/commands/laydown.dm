/datum/mkultra_command/laydown
	name = "Kneel / Laydown"
	description = "Causes your thrall to lay down."
	feedback = "immediately places themselves on the ground."
	trigger = "lay down|kneel|rest|on the floor"
	phase_requirement = 1
	erp_command = TRUE
	cooldown = 10 SECONDS

/datum/mkultra_command/laydown/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return
	var/datum/status_effect/mkultra/ultra = status
	var/mob/living/victim = owner
	to_chat(owner, span_userlove("You quickly bring yourself to the floor at [ultra.get_gender()]'s sharp command!"))
	victim.toggle_resting()

