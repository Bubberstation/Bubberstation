/**
 * public
 *
 * Sends a message to the front end to push the UI window to position 0,0
 *
 * optional can_be_suspended bool
 */
/datum/tgui/proc/reset_ui_position()
	if(window)
		// Windows you want to keep are usually blue screens of death
		// and we want to keep them around, to allow user to read
		// the error message properly.
		window.send_message("resetposition")
