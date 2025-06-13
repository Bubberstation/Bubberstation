ADMIN_VERB(ping_deadmins, R_ADMIN, "Ping De-adminned Admins", "Send a notification and message to all currently de-adminned admins.", ADMIN_CATEGORY_MAIN)
	var/message = tgui_input_text(user, "Enter message to send with ping", "Notify Deadmins", "Need help with tickets...", max_length = 256)
	if(!message)
		return

	var/list/admins_notified = list()
	for(var/ckey as anything in GLOB.deadmins)
		var/client/deadmin_client = GLOB.directory[ckey]
		if(!deadmin_client)
			continue
		to_chat(
			deadmin_client,
			fieldset_block(
				span_adminhelp("[user.key] is requesting help"),
				span_adminsay(message),
				"boxed_message red_box"),
			type = MESSAGE_TYPE_SYSTEM,
			confidential = TRUE,
		)
		SEND_SOUND(deadmin_client, sound('sound/effects/adminhelp.ogg'))
		admins_notified += ckey

	log_admin("[key_name_admin(user)] pinged [length(admins_notified)] ([admins_notified.Join(", ")]) de-adminned admin(s) with message: [message]")
	message_admins("[key_name_admin(user)] pinged [length(admins_notified)] ([admins_notified.Join(", ")]) de-adminned admin(s) with message: [message]")
