/datum/mkultra_command/relax
	name = "Relax"
	description = "Gives 30 seconds of bonus progress."
	feedback = "visibly relaxes from the command."
	trigger = "relax|obey|serve|love|calm down"
	cooldown = 30 SECONDS

/datum/mkultra_command/relax/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	processing = TRUE
	return TRUE

/datum/mkultra_command/relax/tick(datum/status_effect/mkultra/status, mob/owner, mob/source)
	if(!COOLDOWN_FINISHED(src, ultra_cooldown))
		status.bonus_progress = 3
		return
	processing = FALSE
	status.bonus_progress = 0
