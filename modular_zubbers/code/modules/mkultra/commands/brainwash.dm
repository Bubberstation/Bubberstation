/datum/mkultra_command/mind_control
	name = "Brainwash"
	description = "Brainwash your victim with a new objective. This is mechanic backed brainwashing that gives your victim the brainwashed antag status."
	feedback = "loosens as you instill a new objective."
	trigger = "new order|obey this command|new objective"
	phase_requirement = 3
	cooldown = 5 MINUTES

/datum/mkultra_command/mind_control/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/text = tgui_input_text(source, title = "Brainwash Input", max_length = 150)
	if(!text)
		return FALSE
	brainwash(owner, text)
	return TRUE
