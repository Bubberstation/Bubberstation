/datum/individual_logging_panel
	var/mob/target_mob
	var/client/target_client
	var/current_source = LOGSRC_CKEY
	var/current_log_type = INDIVIDUAL_ATTACK_LOG

/datum/individual_logging_panel/New(mob/target, source = LOGSRC_CKEY, type = INDIVIDUAL_ATTACK_LOG)
	. = ..()
	target_mob = target
	if(target?.client)
		target_client = target.client
	current_source = source
	current_log_type = text2num(type)

/datum/individual_logging_panel/Destroy(force, ...)
	target_mob = null
	target_client = null
	SStgui.close_uis(src)
	return ..()

/datum/individual_logging_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!target_mob)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "IndividualLogViewer", "[target_mob.real_name] Individual Logs")
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

	if(!target_mob)
		return

	.["mob_name"] = target_mob.real_name
	.["mob_type"] = target_mob.type
	.["source_type"] = current_source
	.["current_log_type"] = current_log_type

	if(target_mob.client)
		target_client = target_mob.client

	var/log_source = target_mob.logging
	if(current_source == LOGSRC_CKEY && target_mob.persistent_client)
		log_source = target_mob.persistent_client.logging

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

	var/mob/admin_mob = ui.user
	var/client/admin_client = admin_mob.client

	if(!check_rights_for(admin_client, R_ADMIN))
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
