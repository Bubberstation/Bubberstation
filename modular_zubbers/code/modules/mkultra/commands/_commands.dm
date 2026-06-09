GLOBAL_LIST_INIT(mkultra_commands, subtypesof(/datum/mkultra_command))

/datum/mkultra_command
	/// The name of your command
	var/name = "abstract command"
	/// The description of your command
	var/description = "You shouldn't be seeing this."
	/// Feedback text. "to_chat(enchanter, span_notice("[owner] example text")
	var/feedback
	/// Trigger words for this command. trigger_words = regex()
	var/trigger = "Coder, you should not forgot to set this!"
	/// Whether this command processes every status effect tick
	var/processing = FALSE
	/// Is regex? Will convert to regex on New() if true.
	var/regex = TRUE
	/// Required phase
	var/phase_requirement = 0
	/// Is this an ERP command?
	var/erp_command = FALSE
	/// Does this command place mkultra on cooldown?
	var/cooldown
	COOLDOWN_DECLARE(ultra_cooldown)

/datum/mkultra_command/New()
	. = ..()
	if(regex)
		trigger = regex(trigger, "i")

/** This is executed when the status effect is removed. Use this to clear references and other effects.
 *	* status - MKUltra status effect
 *  * owner - MKUltra status owner
 *  * source - MKUltra enchanter
 */

/datum/mkultra_command/proc/on_destroy(datum/status_effect/status, mob/owner, mob/source)
	return TRUE

/**
 * the executed proc when /datum/status_effect/mkultra/proc/listener() is called.
 * 	* status - MKUltra status effect
 *  * owner - MKUltra status holder
 *  * source - MKUltra enchanter
 *  * message - The message that triggered this proc.
 */

/datum/mkultra_command/proc/execute(datum/status_effect/status, mob/owner, mob/source, message)
	var/datum/status_effect/mkultra/status_effect = status
	if(status_effect.phase < phase_requirement)
		return FALSE

	if(cooldown && !COOLDOWN_FINISHED(src, ultra_cooldown))
		to_chat(source, span_notice("[owner] hasn't finished internalizing your [LOWER_TEXT(name)] command!"))
		return FALSE
	else
		if(feedback)
			to_chat(source, span_notice("[owner] [feedback]"))
		if(cooldown)
			COOLDOWN_START(src, ultra_cooldown, cooldown)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), source, span_notice("[owner] has finished internalizing your last command!")), cooldown)
	return TRUE

/**
 * Processes per tick on the original status effect. Is called during /datum/status_effect/mkultra/tick()
 * Set processing = TRUE inside execute()
 * 	* status - MKUltra status effect
 *  * owner - MKUltra status holder
 *  * source - MKUltra enchanter
 */

/datum/mkultra_command/proc/tick(datum/status_effect/status, mob/owner, mob/source)
	return TRUE

