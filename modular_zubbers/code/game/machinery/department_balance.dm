/obj/machinery/status_display/department_balance
	name = "department balance display"
	desc = "A digital screen displaying the current budget."

	current_mode = SD_MESSAGE
	text_color = COLOR_DISPLAY_GREEN
	header_text_color = COLOR_DISPLAY_YELLOW

	/// The account to display balance
	var/credits_account = ""
	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null

/obj/machinery/status_display/department_balance/LateInitialize()
	. = ..()
	start_process()

/obj/machinery/status_display/department_balance/update_overlays(updates)
	current_mode = SD_MESSAGE
	if(isnull(synced_bank_account))
		synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)
	set_messages("TOTAL", "[!synced_bank_account ? 0 : synced_bank_account.account_balance]", "")
	. = ..()

/obj/machinery/status_display/department_balance/process(seconds_per_tick)
	update_overlays()

/obj/machinery/status_display/department_balance/receive_signal(datum/signal/signal)
	return

/obj/machinery/status_display/department_balance/emp_act(severity)
	return

/obj/machinery/status_display/department_balance/Destroy()
	stop_process()
	. = ..()

/**
 * Adds the display to the SSclock_component process list
 */
/obj/machinery/status_display/department_balance/proc/start_process()
	START_PROCESSING(SSclock_component, src)

/**
 * Removes the display to the SSclock_component process list
 */
/obj/machinery/status_display/department_balance/proc/stop_process()
	STOP_PROCESSING(SSclock_component, src)
