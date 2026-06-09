/datum/action/item_action/organ_action/velvet/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MKUltraUI")
		ui.open()

/datum/action/item_action/organ_action/velvet/ui_data(mob/user)
	var/list/data = list()

	for(var/datum/mkultra_command/command as anything in GLOB.mkultra_commands)
		var/name = command.name
		var/description = command.description
		var/trigger = command.trigger
		var/cooldown = command.cooldown / 600
		if(isnull(name) || isnull(description) || isnull(trigger))
			continue
		if(!owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
			continue
		trigger = replacetext(trigger, "|", ", ")
		data += list(list("name" = name, "description" = description, "trigger" = trigger, "erp" = command.erp_command, "cooldown" = cooldown, "phase" = command.phase_requirement))
	return list("commands" = data)

/datum/action/item_action/organ_action/velvet/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE
