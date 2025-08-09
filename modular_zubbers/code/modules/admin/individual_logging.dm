/datum/individual_logging_panel
	var/mob/targetMob
	var/client/targetClient
	var/current_source = LOGSRC_CKEY
	var/current_log_type = INDIVIDUAL_ATTACK_LOG

/datum/individual_logging_panel/New(mob/target, source = LOGSRC_CKEY, type = INDIVIDUAL_ATTACK_LOG)
	. = ..()
	targetMob = target
	if(target?.client)
		targetClient = target.client
	current_source = source
	current_log_type = text2num(type)

/datum/individual_logging_panel/Destroy(force, ...)
	targetMob = null
	targetClient = null
	SStgui.close_uis(src)
	return ..()

/datum/individual_logging_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!targetMob)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "IndividualLogViewer", "[targetMob.real_name] Individual Logs")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/individual_logging_panel/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/individual_logging_panel/ui_static_data(mob/user)
	. = list()

	.["available_sources"] = list(
		list("name" = "Ckey", "source" = LOGSRC_CKEY),
		list("name" = "Mob", "source" = LOGSRC_MOB)
	)

	.["available_types"] = list(
		list("name" = "Game Log", "type" = INDIVIDUAL_GAME_LOG),
		list("name" = "Attack Log", "type" = INDIVIDUAL_ATTACK_LOG),
		list("name" = "Say Log", "type" = INDIVIDUAL_SAY_LOG),
		list("name" = "Emote Log", "type" = INDIVIDUAL_EMOTE_LOG),
		list("name" = "Comms Log", "type" = INDIVIDUAL_COMMS_LOG),
		list("name" = "OOC Log", "type" = INDIVIDUAL_OOC_LOG),
		list("name" = "Show All", "type" = INDIVIDUAL_SHOW_ALL_LOG)
	)

/datum/individual_logging_panel/ui_data(mob/user)
	. = list()

	if(!targetMob)
		return

	.["mob_name"] = targetMob.real_name
	.["mob_type"] = targetMob.type
	.["source_type"] = current_source
	.["current_log_type"] = current_log_type

	if(targetMob.client)
		targetClient = targetMob.client

	var/log_source = targetMob.logging
	if(current_source == LOGSRC_CKEY && targetMob.persistent_client)
		log_source = targetMob.persistent_client.logging

	var/list/entries = list()
	if(log_source)
		for(var/log_type in log_source)
			var/nlog_type = text2num(log_type)
			if(nlog_type & current_log_type)
				var/list/all_entries = log_source[log_type]
				for(var/entry in all_entries)
					entries += list(list(
						"timestamp" = entry,
						"message" = all_entries[entry],
						"formatted_message" = all_entries[entry]
					))

	.["entries"] = entries

/datum/individual_logging_panel/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/mob/adminMob = ui.user
	var/client/adminClient = adminMob.client

	if(!check_rights_for(adminClient, R_ADMIN))
		return

	switch(action)
		if("refresh")
			SStgui.update_uis(src)
			return TRUE

		if("change_source")
			var/new_source = params["source"]
			if(new_source in list(LOGSRC_CKEY, LOGSRC_MOB))
				current_source = new_source
				SStgui.update_uis(src)
				return TRUE

		if("change_type")
			var/new_type = text2num(params["log_type"])
			if(new_type)
				current_log_type = new_type
				SStgui.update_uis(src)
				return TRUE

/proc/show_individual_logging_panel_tgui(mob/M, source = LOGSRC_CKEY, type = INDIVIDUAL_ATTACK_LOG)
	if(!M || !ismob(M))
		return

	if(!usr?.client)
		return

	if(!check_rights_for(usr.client, R_ADMIN))
		return

	var/datum/individual_logging_panel/panel = new(M, source, type)
	panel.ui_interact(usr)
