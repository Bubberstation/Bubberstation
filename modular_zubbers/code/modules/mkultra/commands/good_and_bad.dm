/datum/mkultra_command/good_boy
	name = "Praise"
	description = "Give praise as a reward"
	feedback = "shudders from the praise!"
	erp_command = TRUE
	trigger = "good boy|good girl|good pet|good job|good"
	cooldown = 10 SECONDS

/datum/mkultra_command/good_boy/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	var/datum/status_effect/mkultra/ultra = status
	if(!.)
		return FALSE
	to_chat(owner, span_userlove("[ultra.get_gender()] has praised me!!"))
	owner.emote("shiver")
	ultra.progress += 20
	return TRUE

/datum/mkultra_command/bad_boy
	name = "Punish"
	description = "Verbally punish your pet"
	feedback = "shrinks from the scorn."
	erp_command = TRUE
	trigger = "bad boy|bad girl|bad pet|bad job"
	cooldown = 10 SECONDS

/datum/mkultra_command/bad_boy/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	var/datum/status_effect/mkultra/ultra = status
	if(!.)
		return FALSE
	to_chat(owner, span_red("I've failed [ultra.get_gender()]... what a bad pet..."))
	return TRUE
