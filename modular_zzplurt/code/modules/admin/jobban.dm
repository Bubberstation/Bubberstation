// // Stuff that helps the TGUI player panel jobban section to work

// GLOBAL_LIST_INIT(jobban_panel_data, list(
// 	list(
// 		"name" = "Command",
// 		"color" = "yellow",
// 		"roles" = GLOB.command_positions
// 	),
// 	list(
// 		"name" = "Security",
// 		"color" = "red",
// 		"roles" = GLOB.security_positions
// 	),
// 	list(
// 		"name" = "Engineering",
// 		"color" = "orange",
// 		"roles" = GLOB.engineering_positions
// 	),
// 	list(
// 		"name" = "Medical",
// 		"color" = "blue",
// 		"roles" = GLOB.medical_positions
// 	),
// 	list(
// 		"name" = "Science",
// 		"color" = "violet",
// 		"roles" = GLOB.science_positions
// 	),
// 	list(
// 		"name" = "Supply",
// 		"color" = "brown",
// 		"roles" = GLOB.supply_positions
// 	),
// 	list(
// 		"name" = "Service",
// 		"color" = "green",
// 		"roles" = GLOB.civilian_positions
// 	),
// 	list(
// 		"name" = "Silicon",
// 		"color" = "purple",
// 		"roles" = GLOB.nonhuman_positions
// 	),
// 	list(
// 		"name" = "Ghost Roles",
// 		"color" = "teal",
// 		"roles" = list(
// 			ROLE_PAI,
// 			ROLE_POSIBRAIN,
// 			ROLE_DRONE,
// 			ROLE_DEATHSQUAD,
// 			ROLE_LAVALAND,
// 			ROLE_GHOSTCAFE,
// 			ROLE_SENTIENCE,
// 			ROLE_MIND_TRANSFER
// 			)
// 	),
// 	list(
// 		"name" = "Antagonists",
// 		"color" = "red",
// 		"roles" = list(
// 			ROLE_TRAITOR,
// 			ROLE_CHANGELING,
// 			ROLE_HERETIC,
// 			ROLE_OPERATIVE,
// 			ROLE_REV,
// 			ROLE_CULTIST,
// 			ROLE_SERVANT_OF_RATVAR,
// 			ROLE_WIZARD,
// 			ROLE_ABDUCTOR,
// 			ROLE_ALIEN,
// 			ROLE_FAMILIES,
// 			ROLE_BLOODSUCKER,
// 			ROLE_SLAVER
// 			)
// 	),
// 	list(
// 		"name" = "Other",
// 		"color" = "red",
// 		"roles" = list(
// 		"pacifist",
// 		"appearance",
// 		"emote",
// 		"OOC",
// 		ROLE_RESPAWN
// 		)
// 	)
// ))

// // notbannedlist is just a list of strings of the job titles you want to ban.
// /datum/admins/proc/Jobban(mob/M, list/notbannedlist)
// 	if (!check_rights(R_BAN))
// 		to_chat(usr, "Error: You do not have sufficient admin rights to ban players.")
// 		return

// 	var/severity = null
// 	var/reason = null

// 	switch(tgui_alert(usr, "Job ban type", buttons = list("Temporary", "Permanent", "Cancel")))
// 		if("Temporary")
// 			var/mins = input(usr,"How long (in minutes)?","Ban time",1440) as num|null
// 			if(mins <= 0)
// 				to_chat(usr, span_danger("[mins] is not a valid duration."))
// 				return
// 			reason = input(usr,"Please State Reason For Banning [M.key].","Reason") as message|null
// 			if(!reason)
// 				return
// 			severity = tgui_alert(usr, "Set the severity of the note/ban", buttons = list("High", "Medium", "Minor", "None"))
// 			if(!severity)
// 				return
// 			var/msg
// 			for(var/job in notbannedlist)
// 				if(!DB_ban_record(BANTYPE_JOB_TEMP, M, mins, reason, job))
// 					to_chat(usr, span_danger("Failed to apply ban."))
// 					return
// 				if(M.client)
// 					jobban_buildcache(M.client)
// 				ban_unban_log_save("[key_name(usr)] temp-jobbanned [key_name(M)] from [job] for [mins] minutes. reason: [reason]")
// 				log_admin_private("[key_name(usr)] temp-jobbanned [key_name(M)] from [job] for [mins] minutes.")
// 				if(!msg)
// 					msg = job
// 				else
// 					msg += ", [job]"
// 			create_message("note", M.key, null, "Banned  from [msg] - [reason]", null, null, 0, 0, null, 0, severity)
// 			message_admins(span_adminnotice("[key_name_admin(usr)] banned [key_name_admin(M)] from [msg] for [mins] minutes."))
// 			to_chat(M, span_boldannounce("<BIG>You have been [((msg == "ooc") || (msg == "appearance") || (msg == "pacifist")) ? "banned" : "jobbanned"] by [usr.client.key] from: [msg == "pacifist" ? "using violence" : msg].</BIG>"))
// 			to_chat(M, span_boldannounce("The reason is: [reason]"))
// 			to_chat(M, span_danger("This jobban will be lifted in [mins] minutes."))

// 		if("Permanent")
// 			reason = input(usr,"Please State Reason For Banning [M.key].","Reason") as message|null
// 			if (!reason)
// 				return
// 			severity = tgui_alert(usr, "Please State Reason For Banning", buttons = list("High", "Medium", "Minor", "None"))
// 			if (!severity)
// 				return

// 			var/msg
// 			for(var/job in notbannedlist)
// 				if(!DB_ban_record(BANTYPE_JOB_PERMA, M, -1, reason, job))
// 					to_chat(usr, span_danger("Failed to apply ban."))
// 					return
// 				if(M.client)
// 					jobban_buildcache(M.client)
// 				ban_unban_log_save("[key_name(usr)] perma-jobbanned [key_name(M)] from [job]. reason: [reason]")
// 				log_admin_private("[key_name(usr)] perma-banned [key_name(M)] from [job]")
// 				if(!msg)
// 					msg = job
// 				else
// 					msg += ", [job]"
// 			create_message("note", M.key, null, "Banned  from [msg] - [reason]", null, null, 0, 0, null, 0, severity)
// 			message_admins(span_adminnotice("[key_name_admin(usr)] banned [key_name_admin(M)] from [msg]."))
// 			to_chat(M, span_boldannounce("<BIG>You have been [((msg == "ooc") || (msg == "appearance") || (msg == "pacifist")) ? "banned" : "jobbanned"] by [usr.client.key] from: [msg == "pacifist" ? "using violence" : msg].</BIG>"))
// 			to_chat(M, span_boldannounce("The reason is: [reason]"))
// 			to_chat(M, span_danger("This jobban can be lifted only upon request."))

// // notbannedlist is just a list of strings of the job titles you want to unban.
// /datum/admins/proc/UnJobban(mob/M, list/bannedlist)

// 	if (!check_rights(R_BAN))
// 		to_chat(usr, "Error: You do not have sufficient admin rights to unban players.")
// 		return

// 	var/msg
// 	for(var/job in bannedlist)
// 		var/reason = jobban_isbanned(M, job)
// 		if (tgui_alert(usr, "Job: '[job]' Ban reason: '[reason]'", "Un-Jobban This Player?", list("Yes", "No")) == "Yes")
// 			ban_unban_log_save("[key_name(usr)] unjobbanned [key_name(M)] from [job]")
// 			log_admin_private("[key_name(usr)] unbanned [key_name(M)] from [job]")
// 			DB_ban_unban(M.ckey, BANTYPE_ANY_JOB, job)
// 			if(M.client)
// 				jobban_buildcache(M.client)
// 			if(!msg)
// 				msg = job
// 			else
// 				msg += ", [job]"
// 	if(msg)
// 		message_admins(span_adminnotice("[key_name_admin(usr)] unbanned [key_name_admin(M)] from [msg]."))
// 		to_chat(M, span_boldannounce("<BIG>You have been un-jobbanned by [usr.client.key] from [msg].</BIG>"))
