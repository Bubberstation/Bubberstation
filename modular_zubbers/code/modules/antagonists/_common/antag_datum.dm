
/datum/antagonist
	var/antag_panel_title = "Antagonist Panel"
	var/antag_panel_description = "This is the antagonist panel. It contains all the abilities you have access to as an antagonist. Use them wisely."

/datum/antagonist/proc/ability_ui_data(actions = list())
	var/list/data = list()
	data["title"] = "[antag_panel_title]\n[antag_panel_data()]"
	data["description"] = antag_panel_description
	for(var/datum/action/cooldown/power as anything in actions)
		var/list/power_data = list()

		power_data["power_name"] = power.name
		power_data["power_explanation"] = power?.power_explanation
		power_data["power_icon"] = power.button_icon_state

		data["powers"] += list(power_data)
	return data
