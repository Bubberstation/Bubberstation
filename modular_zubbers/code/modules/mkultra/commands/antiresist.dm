/datum/mkultra_command/antiresist
	name = "Anti-Resist"
	description = "Make your victim unable to resist for a short time"
	feedback = "stops resisting."
	trigger = "stop resisting|give up|give in|stop being difficult|unable to resist"
	cooldown = 60 SECONDS
	phase_requirement = 3
	erp_command = FALSE
	var/resist = FALSE

/datum/mkultra_command/antiresist/on_destroy(datum/status_effect/status, mob/owner, mob/source)
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)

/datum/mkultra_command/antiresist/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	processing = TRUE
	RegisterSignal(owner, COMSIG_LIVING_RESIST, PROC_REF(resist_command_block))
	return TRUE

/datum/mkultra_command/antiresist/tick(datum/status_effect/mkultra/status, mob/owner, mob/source)
	. = ..()
	if(!COOLDOWN_FINISHED(src, ultra_cooldown))
		resist = TRUE
		return TRUE
	processing = FALSE
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)
	return FALSE

/datum/mkultra_command/antiresist/proc/resist_command_block(mob/living/owner)
	SIGNAL_HANDLER
	if(resist)
		to_chat(owner, span_warning("You find yourself incapable of resisting with the recent command permeating your thoughts."))
		return COMPONENT_BLOCK_RESIST

