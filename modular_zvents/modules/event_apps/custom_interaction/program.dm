/datum/computer_file/program/trigger_control
	filename = "triggerctrl"
	filedesc = "Trigger Control Panel"
	program_open_overlay = "wrench"
	extended_desc = "Remote control for mapped triggers."
	size = 0
	undeletable = TRUE
	power_cell_use = NONE
	tgui_id = "NtosTriggerControlPanel"
	program_icon = "bolt"

	var/list/registered_triggers = list()  // key -> /datum/trigger_type/remote_controlled

/datum/computer_file/program/trigger_control/ui_data(mob/user)
	var/list/data = list()
	data["actions"] = list()

	for(var/key in registered_triggers)
		var/datum/trigger_type/remote_controlled/T = registered_triggers[key]
		if(QDELETED(T) || QDELETED(T.parent))
			registered_triggers -= key
			continue

		data["actions"] += list(list(
			"key" = key,
			"name" = T.name,
			"trigger_type" = T.ui_type,
			"del_on_use" = T.del_on_use,
			"active" = T.active
		))

	return data

/datum/computer_file/program/trigger_control/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/key = params["action_key"]
	var/datum/trigger_type/remote_controlled/T = registered_triggers[key]
	if(!T)
		return

	switch(action)
		if("on_action_press")
			if(T.ui_type == "button")
				T.trigger()
		if("on_action_toggle")
			if(T.ui_type == "toggle" || T.ui_type == "switch")
				T.toggle(params["value"])

	return TRUE

/datum/computer_file/program/trigger_control/proc/register_trigger(key, datum/trigger_type/remote_controlled/T)
	registered_triggers[key] = T

/datum/computer_file/program/trigger_control/proc/unregister_trigger(key)
	registered_triggers -= key
