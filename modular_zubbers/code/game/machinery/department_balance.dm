/obj/machinery/status_display/department_balance
	name = "department balance display"
	desc = "A digital screen displaying the current budget."

	current_mode = SD_MESSAGE
	text_color = COLOR_DISPLAY_GREEN
	header_text_color = COLOR_DISPLAY_YELLOW

	/// The account to display balance
	var/credits_account = ""
	/// The account to display balance
	var/default_logo = "default"

	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null
	/// If the screen is actively resetting or not
	var/display_reset_state = 0

/obj/machinery/status_display/department_balance/post_machine_initialize()
	. = ..()
	start_process()
	display_reset_state = 0

/obj/machinery/status_display/department_balance/proc/update_balance(updates)
	current_mode = SD_MESSAGE
	switch(SSticker.current_state)
		if(GAME_STATE_STARTUP, GAME_STATE_PREGAME, GAME_STATE_SETTING_UP)
			set_messages("CASH", "", "")
			update_overlays()
			return

	if(display_reset_state)
		if(display_reset_state < 5) // show a generic splash screen for 5 seconds
			display_reset_state++
			current_mode = SD_PICTURE
			set_picture(default_logo)
			return
		display_reset_state = 0 // we now return to our regularly scheduled programming
		text_color = COLOR_DISPLAY_GREEN
		set_messages("CASH", " ", " ")
		update_overlays()
		return
	else if(!display_reset_state && prob(1)) // force a reset of the display randomly (resolves red text when power is lost)
		display_reset_state = 1
		text_color = COLOR_DISPLAY_GREEN
		set_messages(" ", " ", " ")
		update_overlays()
		return

	if(isnull(synced_bank_account))
		synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)
	var/balance = !synced_bank_account ? 0 : synced_bank_account.account_balance
	var/balance_remainer = round((balance % 1000) / 100)
	if(balance > 99999)
		text_color = COLOR_DISPLAY_GREEN
	else if(balance > 74999)
		text_color = COLOR_SLIME_GOLD
	else if(balance > 49999)
		text_color = COLOR_DISPLAY_YELLOW
	else if(balance > 14999)
		text_color = COLOR_DISPLAY_ORANGE
	else
		text_color = COLOR_DISPLAY_RED
	if(balance > 999999)
		balance_remainer = round((balance % 1000000) / 100000)
		set_messages("CASH", "[round(balance / 1000000)].[balance_remainer]M", "")
	else if(balance > 99999 || balance > 1000 && balance_remainer == 0)
		set_messages("CASH", "[round(balance / 1000)]K", "")
	else if(balance > 1000)
		set_messages("CASH", "[round(balance / 1000)].[balance_remainer]K", "")
	else
		set_messages("CASH", "[balance]", "")
	update_overlays()

/obj/machinery/status_display/department_balance/process(seconds_per_tick)
	update_balance()

/obj/machinery/status_display/department_balance/receive_signal(datum/signal/signal)
	return

/obj/machinery/status_display/department_balance/emp_act(severity)
	return

/obj/machinery/status_display/department_balance/Destroy()
	stop_process()
	. = ..()

/**
 * Adds the display to the SSdigital_clock process list
 */
/obj/machinery/status_display/department_balance/proc/start_process()
	START_PROCESSING(SSdigital_clock, src)

/**
 * Removes the display to the SSdigital_clock process list
 */
/obj/machinery/status_display/department_balance/proc/stop_process()
	STOP_PROCESSING(SSdigital_clock, src)
