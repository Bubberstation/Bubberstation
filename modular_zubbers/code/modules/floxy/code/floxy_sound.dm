///Takes an input from either proc/play_web_sound or the request manager and runs it through youtube-dl and prompts the user before playing it to the server.
/proc/web_sound(mob/user, input, credit)
	if(!check_rights(R_SOUND))
		return
	if(!CONFIG_GET(string/floxy_url))
		to_chat(user, span_boldwarning("Floxy was not configured, action unavailable."), type = MESSAGE_TYPE_ADMINLOG, confidential = TRUE) //Check config.txt for the INVOKE_YOUTUBEDL value
		return
	var/web_sound_url = ""
	var/stop_web_sounds = FALSE
	var/duration = 0
	var/list/music_extra_data = list()
	if(istext(input))
		var/list/info = SSfloxy.download_and_wait(input, timeout = 30 SECONDS, discard_failed = TRUE)
		if(!info)
			to_chat(user, span_boldwarning("Failed to fetch [input]"), type = MESSAGE_TYPE_ADMINLOG, confidential = TRUE)
			return
		else if(info["status"] != FLOXY_STATUS_COMPLETED)
			to_chat(user, span_boldwarning("Floxy returned status '[info["status"]]' while trying to fetch [input]"), type = MESSAGE_TYPE_ADMINLOG, confidential = TRUE)
			return
		if(length(info["endpoints"]))
			web_sound_url = info["endpoints"][1]
		else
			log_floxy("Floxy did not return a music endpoint for [input]")
			to_chat(user, span_boldwarning("Floxy did not return an endpoint for [input]! That's weird!"), type = MESSAGE_TYPE_ADMINLOG, confidential = TRUE)
			return
		var/list/metadata = info["metadata"]
		var/webpage_url = info["url"]
		var/title = webpage_url
		if(metadata)
			if(metadata["title"])
				title = metadata["title"]
			if(metadata["url"])
				webpage_url = "<a href=\"[metadata["url"]]\">[title]</a>"
			if(metadata["duration"])
				duration = metadata["duration"] * 1 SECONDS
				music_extra_data["duration"] = DisplayTimeText(duration)
			if(metadata["artist"])
				music_extra_data["artist"] = metadata["artist"]
			if(metadata["album"])
				music_extra_data["album"] = metadata["album"]
		if (duration > 10 MINUTES)
			if((tgui_alert(user, "This song is over 10 minutes long. Are you sure you want to play it?", "Length Warning!", list("No", "Yes", "Cancel")) != "Yes"))
				return
		var/include_song_data = tgui_input_list(user, "Show the title of and link to this song to the players?\n[title]", "Show Info?", list("Yes", "No", "Custom Title", "Cancel"))
		switch(include_song_data)
			if("Yes")
				music_extra_data["title"] = title
				music_extra_data["link"] = metadata["url"] || input
			if("No")
				music_extra_data["link"] = "\[\[HYPERLINK BLOCKED\]\]"
				music_extra_data["title"] = "Untitled"
				music_extra_data["artist"] = "Unknown"
				music_extra_data["upload_date"] = "XX.YY.ZZZZ"
				music_extra_data["album"] = "Default"
			if("Custom Title")
				var/custom_title = tgui_input_text(user, "Enter the title to show to players", "Custom sound info", null)
				if (!length(custom_title))
					tgui_alert(user, "No title specified, using default.", "Custom sound info", list("Okay"))
				else
					music_extra_data["title"] = custom_title
			if("Cancel", null)
				return
		var/credit_yourself = tgui_alert(user, "Display who played the song?", "Credit Yourself", list("Yes", "No", "Cancel"))

		var/list/to_chat_message = list()

		switch(credit_yourself)
			if("Yes")
				if(include_song_data == "Yes")
					to_chat_message += span_notice("[user.ckey] played: [span_linkify(webpage_url)]")
				else
					to_chat_message += span_notice("[user.ckey] played a sound.")
			if("No")
				if(include_song_data == "Yes")
					to_chat_message += span_notice("An admin played: [span_linkify(webpage_url)]")
				else
					to_chat_message += span_notice("An admin played a sound.")
			if("Cancel", null)
				return

		if(credit)
			to_chat_message += span_notice("<br>[credit]")

		to_chat(world, fieldset_block("Now Playing: [span_bold(music_extra_data["title"])] by [span_bold(music_extra_data["artist"])]", jointext(to_chat_message, ""), "boxed_message"), type = MESSAGE_TYPE_OOC)
		SSblackbox.record_feedback("nested tally", "played_url", 1, list("[user.ckey]", "[input]"))
		log_admin("[key_name(user)] played web sound: [input]")
		message_admins("[key_name(user)] played web sound: [webpage_url]")
	else
		//pressed ok with blank
		log_admin("[key_name(user)] stopped web sounds.")

		message_admins("[key_name(user)] stopped web sounds.")
		web_sound_url = null
		stop_web_sounds = TRUE
	if(web_sound_url && !is_http_protocol(web_sound_url))
		tgui_alert(user, "The media provider returned a content URL that isn't using the HTTP or HTTPS protocol. This is a security risk and the sound will not be played.", "Security Risk", list("OK"))
		to_chat(user, span_boldwarning("BLOCKED: Content URL not using HTTP(S) Protocol!"), type = MESSAGE_TYPE_ADMINLOG, confidential = TRUE)
		return

	if(web_sound_url || stop_web_sounds)
		for(var/mob/player as anything in GLOB.player_list)
			play_music_to_player(player, web_sound_url, music_extra_data, stop_web_sounds)

	CLIENT_COOLDOWN_START(GLOB, web_sound_cooldown, duration)
	BLACKBOX_LOG_ADMIN_VERB("Play Internet Sound")

/proc/play_music_to_player(mob/player, web_sound_url, list/music_extra_data, stop_web_sounds)
	var/client/client = player.client
	if(!client.prefs?.read_preference(/datum/preference/numeric/volume/sound_midi))
		return
	// Stops playing lobby music and admin loaded music automatically.
	SEND_SOUND(client, sound(null, channel = CHANNEL_LOBBYMUSIC))
	SEND_SOUND(client, sound(null, channel = CHANNEL_ADMIN))
	if(!stop_web_sounds)
		client.tgui_panel?.play_music(web_sound_url, music_extra_data)
	else
		client.tgui_panel?.stop_music()

ADMIN_VERB(play_web_sound, R_SOUND, "Play Internet Sound", "Play a given internet sound to all players.", ADMIN_CATEGORY_FUN)
	if(!CLIENT_COOLDOWN_FINISHED(GLOB, web_sound_cooldown))
		if(tgui_alert(user, "Someone else is already playing an Internet sound! It has [DisplayTimeText(CLIENT_COOLDOWN_TIMELEFT(GLOB, web_sound_cooldown), 1)] remaining. \
		Would you like to override?", "Musicalis Interruptus", list("No","Yes")) != "Yes")
			return

	var/web_sound_input = tgui_input_text(user, "Enter content URL (supported sites only, leave blank to stop playing)", "Play Internet Sound", null)

	if(!length(web_sound_input))
		web_sound(user.mob, null)
		return
	web_sound_input = trim(web_sound_input)
	if(findtext(web_sound_input, ":") && !is_http_protocol(web_sound_input))
		to_chat(user, span_boldwarning("Non-http(s) URIs are not allowed."), confidential = TRUE)
		to_chat(user, span_warning("For youtube-dl shortcuts like ytsearch: please use the appropriate full URL from the website."), confidential = TRUE)
		return
	if(findtext(web_sound_input, "spotify.com") || findtext(web_sound_input, "music.apple.com") || findtext(web_sound_input, "deezer.com") || findtext(web_sound_input, "tidal.com"))
		to_chat(user, span_warning("This URL is unsupported. Try a YouTube, Bandcamp, or Soundcloud URL."), confidential = TRUE)
		return
	web_sound(user.mob, web_sound_input)

ADMIN_VERB_CUSTOM_EXIST_CHECK(play_web_sound)
	return !!CONFIG_GET(string/floxy_url)
