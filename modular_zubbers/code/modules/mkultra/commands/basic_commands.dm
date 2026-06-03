/datum/mkultra_command/relax
	name = "Relax"
	description = "Gives 30 seconds of bonus progress."
	feedback = "visibly relaxes from the command."
	processing = TRUE
	trigger = "relax|obey|stop resisting|serve|love"
	phase = 0
	cooldown = 30 SECONDS

/datum/mkultra_command/relax/tick(datum/status_effect/status, mob/owner, mob/source)
	var/datum/status_effect/mkultra/ultra = status
	if(!COOLDOWN_FINISHED(src, ultra_cooldown))
		ultra.bonus_progress = 6
		return
	ultra.bonus_progress = 0

/datum/mkultra_command/good_boy
	name = "Praise"
	description = "Give praise as a reward"
	feedback = "shudders from the praise!"
	processing = TRUE
	erp_command = TRUE
	trigger = "good boy|good girl|good pet|good job|good"
	phase = 0
	cooldown = 10 SECONDS

/datum/mkultra_command/good_boy/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	var/datum/status_effect/mkultra/ultra = status
	if(!.)
		return FALSE
	to_chat(owner, span_userlove("[ultra.get_gender()] has praised me!!"))
	owner.emote("shiver")
	ultra.progress += 20

/datum/mkultra_command/bad_boy
	name = "Punish"
	description = "Verbally punish your pet"
	feedback = "shrinks from the scorn."
	processing = TRUE
	erp_command = TRUE
	trigger = "bad boy|bad girl|bad pet|bad job"
	phase = 0
	cooldown = 10 SECONDS

/datum/mkultra_command/bad_boy/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	var/datum/status_effect/mkultra/ultra = status
	if(!.)
		return FALSE
	to_chat(owner, span_red("I've failed [ultra.get_gender()]... what a bad pet..."))
