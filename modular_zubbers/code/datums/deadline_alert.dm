/datum/tgui_alert/deadline
	/// Days remaining until deadline
	var/days_remaining

/datum/tgui_alert/deadline/New(mob/user, message, title, list/buttons, timeout, autofocus, ui_state, days_remaining)
	. = ..()
	src.days_remaining = days_remaining

/datum/tgui_alert/deadline/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DeadlineModal")
		ui.open()

/datum/tgui_alert/deadline/ui_static_data(mob/user)
	. = ..()
	.["days_remaining"] = days_remaining

/proc/tgui_deadline_alert(mob/user, message = "", title, list/buttons = list("Ok"), timeout = 0, autofocus = TRUE, ui_state = GLOB.always_state, days_remaining)
	if (!user)
		user = usr
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return null

	if(isnull(user.client))
		return null

	// A gentle nudge - you should not be using TGUI alert for anything other than a simple message.
	if(length(buttons) > 3)
		log_tgui(user, "Error: TGUI Alert initiated with too many buttons. Use a list.", "TguiAlert")
		return tgui_input_list(user, message, title, buttons, timeout, autofocus)
	// Client does NOT have tgui_input on: Returns regular input
	if(!user.client.prefs.read_preference(/datum/preference/toggle/tgui_input))
		if(length(buttons) == 1)
			return alert(user, message, title, buttons[1])
		if(length(buttons) == 2)
			return alert(user, message, title, buttons[1], buttons[2])
		if(length(buttons) == 3)
			return alert(user, message, title, buttons[1], buttons[2], buttons[3])
	var/datum/tgui_alert/deadline/alert = new(user, message, title, buttons, timeout, autofocus, ui_state, days_remaining)
	alert.ui_interact(user)
	alert.wait()
	if (alert)
		. = alert.choice
		qdel(alert)
