// minutes left at which the owner gets a reminder
#define FINE_EVASION_WARNINGS list(10, 5, 1)

/datum/crime/citation
	var/evasion_window = 0
	var/evasion_deadline = 0
	var/evasion_timer
	var/datum/weakref/evasion_record_ref

/datum/crime/citation/Destroy(force)
	deltimer(evasion_timer)
	return ..()

/datum/crime/citation/proc/start_evasion_clock(datum/record/crew/target)
	var/window_minutes = CONFIG_GET(number/fine_evasion_minutes)
	if(!window_minutes || !target)
		return
	evasion_window = window_minutes MINUTES
	evasion_deadline = world.time + evasion_window
	evasion_record_ref = WEAKREF(target)
	evasion_check()

/datum/crime/citation/proc/stop_evasion_clock()
	deltimer(evasion_timer)
	evasion_timer = null
	evasion_deadline = 0

/datum/crime/citation/proc/evasion_check()
	var/datum/record/crew/target = evasion_record_ref?.resolve()
	if(!target || !valid || fine <= 0 || !(src in target.citations))
		stop_evasion_clock()
		return

	var/time_left = evasion_deadline - world.time
	if(time_left <= 0)
		elevate_to_evasion(target)
		return

	var/minutes_left = CEILING(time_left / (1 MINUTES), 1)
	send_evasion_message(target.name, "You have [minutes_left] minute[minutes_left == 1 ? "" : "s"] left to pay your fine for '[name]'!")
	schedule_evasion_check()

/datum/crime/citation/proc/schedule_evasion_check()
	deltimer(evasion_timer)
	var/time_left = evasion_deadline - world.time
	var/delay = time_left
	for(var/threshold in FINE_EVASION_WARNINGS)
		var/threshold_time = threshold MINUTES
		if(threshold_time < time_left)
			delay = time_left - threshold_time
			break
	evasion_timer = addtimer(CALLBACK(src, PROC_REF(evasion_check)), max(delay, 1), TIMER_STOPPABLE)

/datum/crime/citation/proc/elevate_to_evasion(datum/record/crew/target)
	stop_evasion_clock()
	var/datum/crime/evasion = new(
		name = "Fine Evasion",
		details = "Did not pay the [fine + paid][MONEY_SYMBOL] citation for '[name]' within [evasion_window / (1 MINUTES)] minutes.",
		author = "Citation Server"
	)
	target.crimes += evasion

	if(target.wanted_status != WANTED_ARREST && target.wanted_status != WANTED_PRISONER)
		target.wanted_status = WANTED_ARREST
		update_matching_security_huds(target.name)

	log_game("[target.name]'s citation '[name]' went unpaid ([fine][MONEY_SYMBOL] owed) and was elevated to fine evasion.")
	send_evasion_message(target.name, "Your fine for '[name]' has gone unpaid for too long and has elevated to arrest status, please surrender yourself to security at your convenience.")

// payments buy time in proportion to the share of the fine they cover
/datum/crime/citation/pay_fine(amount)
	var/owed_before = fine
	var/original_fine = fine + paid
	. = ..()
	if(!. || !evasion_deadline)
		return
	if(fine <= 0)
		stop_evasion_clock()
		return
	evasion_deadline += evasion_window * min(amount, owed_before) / original_fine
	schedule_evasion_check()

// alert_owner needs a sending mob, the server has none
/datum/crime/citation/proc/send_evasion_message(target_name, message)
	for(var/messenger_ref in GLOB.pda_messengers)
		var/datum/computer_file/program/messenger/messenger = GLOB.pda_messengers[messenger_ref]
		if(messenger.computer.saved_identification != target_name)
			continue

		var/datum/signal/subspace/messaging/tablet_message/signal = new(messenger.computer, list(
			"fakename" = "Security Citation",
			"fakejob" = "Citation Server",
			"message" = message,
			"targets" = list(messenger),
			"automated" = TRUE
		))
		signal.send_to_receivers()
		log_pda("(PDA: Citation Server) sent \"[message]\" to [signal.format_target()]")
		break

#undef FINE_EVASION_WARNINGS
