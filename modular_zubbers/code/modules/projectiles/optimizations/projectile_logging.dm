#define MAX_LISTED_TARGETS 10

// Projectile combat logs are queued and written once a tick, grouped by shooter, this is because each write sepparately costs ~2ms,
// and a huge volley can cause shittons of lag

/datum/controller/subsystem/processing/projectiles
	/// "user ref|what_done|object|addition" -> list(user, what_done, object, addition, list(target -> count))
	var/list/queued_combat_logs = list()
	/// "atom ref|type|color|message" -> list(atom, message, type, color, count)
	var/list/queued_logs = list()

/datum/controller/subsystem/processing/projectiles/Shutdown()
	flush_logs()
	return ..()

/datum/controller/subsystem/processing/projectiles/proc/queue_combat_log(atom/user, atom/target, what_done, object, addition)
	if (!user || !target)
		return
	var/key = "[REF(user)]|[what_done]|[object]|[addition]"
	var/list/entry = queued_combat_logs[key]
	if (!entry)
		entry = list(user, what_done, "[object]", addition, list())
		queued_combat_logs[key] = entry
	var/list/targets = entry[5]
	targets[target] += 1

/datum/controller/subsystem/processing/projectiles/proc/queue_log(atom/logged, message, message_type, color)
	if (!logged)
		return
	var/key = "[REF(logged)]|[message_type]|[color]|[message]"
	var/list/entry = queued_logs[key]
	if (entry)
		entry[5] += 1
	else
		queued_logs[key] = list(logged, message, message_type, color, 1)

/// When budgeted, stops at the MC tick limit and leaves the rest queued for the next fire
/datum/controller/subsystem/processing/projectiles/proc/flush_logs(budgeted = FALSE)
	while (length(queued_combat_logs))
		if (budgeted && TICK_CHECK)
			return
		var/key = queued_combat_logs[length(queued_combat_logs)]
		var/list/entry = queued_combat_logs[key]
		queued_combat_logs.len--
		write_combat_log(entry[1], entry[2], entry[3], entry[4], entry[5])

	while (length(queued_logs))
		if (budgeted && TICK_CHECK)
			return
		var/key = queued_logs[length(queued_logs)]
		var/list/entry = queued_logs[key]
		queued_logs.len--
		var/atom/logged = entry[1]
		var/count = entry[5]
		logged.log_message("[entry[2]][count > 1 ? " (x[count])" : ""]", entry[3], color = entry[4])

/datum/controller/subsystem/processing/projectiles/proc/write_combat_log(atom/user, what_done, object, addition, list/targets)
	var/atom/only_target = targets[1]
	if (length(targets) == 1 && targets[only_target] == 1)
		log_combat(user, only_target, what_done, object, addition)
		return

	var/postfix = "[object ? " with [object]" : ""][addition ? " [addition]" : ""]"
	var/total = 0
	var/list/listed = list()
	for (var/atom/target as anything in targets)
		var/count = targets[target]
		total += count
		if (length(listed) < MAX_LISTED_TARGETS)
			var/mob/living/living_target = target
			listed += "[key_name(target)][count > 1 ? " x[count]" : ""][istype(living_target) ? " (NEWHP: [living_target.health])" : ""]"
		if (target != user && ismob(target))
			target.log_message("was [what_done] [count > 1 ? "[count] times " : ""]by [key_name(user)][postfix]", LOG_VICTIM, color = "orange", log_globally = FALSE)
	var/overflow = length(targets) - MAX_LISTED_TARGETS
	user.log_message("[what_done] [total] times[postfix] at: [jointext(listed, ", ")][overflow > 0 ? ", +[overflow] more" : ""]", LOG_ATTACK, color = "red")

#undef MAX_LISTED_TARGETS
