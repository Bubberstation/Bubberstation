// Projectile logs are queued and written once a tick, because each write costs ~2ms
// and a big volley can cause a lot of lag

/datum/controller/subsystem/processing/projectiles
	/// "ref|type|hp ref|message" -> list(atom, message, type, color, log_globally, hp_of, count)
	var/list/queued_logs = list()

/datum/controller/subsystem/processing/projectiles/Shutdown()
	flush_logs()
	return ..()

/datum/controller/subsystem/processing/projectiles/proc/queue_combat_log(atom/user, atom/target, what_done, object, addition)
	if (!user || !target)
		return
	var/postfix = "[object ? " with [object]" : ""][addition ? " [addition]" : ""]"
	queue_log(user, "[what_done] [key_name(target)][postfix]", LOG_ATTACK, "red", hp_of = target)
	if (user != target)
		queue_log(target, "was [what_done] by [key_name(user)][postfix]", LOG_VICTIM, "orange", log_globally = FALSE, hp_of = target)

/datum/controller/subsystem/processing/projectiles/proc/queue_log(atom/logged, message, message_type, color, log_globally = TRUE, atom/hp_of)
	if (!logged)
		return
	var/key = "[REF(logged)]|[message_type]|[REF(hp_of)]|[message]"
	var/list/entry = queued_logs[key]
	if (entry)
		entry[7] += 1
	else
		queued_logs[key] = list(logged, message, message_type, color, log_globally, hp_of, 1)

/// When budgeted, stops at the MC tick limit and leaves the rest queued for the next fire
/datum/controller/subsystem/processing/projectiles/proc/flush_logs(budgeted = FALSE)
	while (length(queued_logs))
		if (budgeted && TICK_CHECK)
			return
		var/list/entry = queued_logs[queued_logs[length(queued_logs)]]
		queued_logs.len--
		var/atom/logged = entry[1]
		var/mob/living/hp_of = entry[6]
		var/count = entry[7]
		var/hp = istype(hp_of) ? " (NEWHP: [hp_of.health])" : ""
		logged.log_message("[entry[2]][hp][count > 1 ? " (x[count])" : ""]", entry[3], color = entry[4], log_globally = entry[5])
