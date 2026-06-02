GLOBAL_LIST_INIT(mkultra_commands, mkultra_command_int())

/proc/mkultra_command_int()
	var/list/commands = list()
	for(var/datum/mkultra_command/command as anything in subtypesof(/datum/mkultra_command))
		commands += new command
	return commands

/datum/mkultra_command
	/// The name of your command
	var/name = "abstract command"
	/// The description of your command
	var/description = "You shouldn't be seeing this."
	/// Trigger words for this command. trigger_words = regex()
	var/trigger
	/// Is regex? Will convert to regex on New() if true.
	var/regex = TRUE
	/// Required phase
	var/phase = 1
	/// Is this an ERP command?
	var/erp_command = TRUE
	/// Does this command place mkultra on cooldown?
	var/cooldown
	COOLDOWN_DECLARE(ultra_cooldown)

/datum/mkultra_command/New()
	. = ..()
	if(regex)
		trigger = regex(trigger)

/// What actions this command should do.
/datum/mkultra_command/proc/execute(datum/status_effect/status, mob/owner, mob/source, message)
	var/datum/status_effect/mkultra/status_effect = status
	if(status_effect.phase < phase)
		return FALSE

	if(cooldown && !COOLDOWN_FINISHED(src, ultra_cooldown))
		to_chat(source, span_notice("[source] hasn't finished internalizing your last command!"))
		return FALSE
	else if(cooldown)
		COOLDOWN_START(src, ultra_cooldown, cooldown)
	return TRUE

/datum/mkultra_command/debug_command
	trigger = "trigger|test"

/datum/mkultra_command/debug_command/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	var/mob/living/human = owner
	human.say("FUCK YEAH, TEST COMPLETE")

