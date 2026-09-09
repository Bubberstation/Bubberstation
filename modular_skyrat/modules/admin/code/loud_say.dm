//ADMIN_VERB(cmd_loud_admin_say, R_NONE, "loudAsay", "Send a message to other admins (loudly).", ADMIN_CATEGORY_MAIN)
ADMIN_VERB(cmd_loud_admin_say, R_NONE, "loudAsay", "Send a message to other admins (loudly).", ADMIN_CATEGORY_MAIN)
	VERB_ARG(message, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	message = emoji_parse(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message)
		return

	message = emoji_parse(message)
	user.mob.log_talk(message, LOG_ASAY)

	send_asay_to_other_server(user.ckey, span_command_headset(message))

	message = keywords_lookup(message)
	var/custom_asay_color = (CONFIG_GET(flag/allow_admin_asaycolor) && user.mob.client?.prefs?.read_preference(/datum/preference/color/asay_color)) ? "<font color=[user.mob.client?.prefs?.read_preference(/datum/preference/color/asay_color)]>" : "<font color='#FF4500'>"
	message = span_command_headset("<span class='adminsay'><span class='prefix'>ADMIN:</span> <EM>[key_name(user, 1)]</EM> [ADMIN_FLW(user.mob)]: [custom_asay_color]<span class='message linkify'>[message]</span></span></span>[custom_asay_color ? "</font>":null]")

	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINCHAT,
		html = message,
		confidential = TRUE)

	for(var/client/admin_client in GLOB.admins)
		if(admin_client?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(admin_client, sound('modular_skyrat/modules/admin/sound/duckhonk.ogg')) //Stop using loud mode if you don't need to.
		window_flash(admin_client, ignorepref = TRUE)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "loudAsay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
