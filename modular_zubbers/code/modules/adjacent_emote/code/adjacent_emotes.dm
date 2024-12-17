/datum/emote/door_emote
	key = "doorknocker"
	message = null

/mob/living/verb/door_emote(atom/target in obj/machinery/door|turf/closed in get_adjacent_occupied_turfs())
	set name = "Emote Using Wall/Door"
	set category = "IC"

	if(!istype(target))
		to_chat(src, span_danger("No target."))
		return FALSE
	if (loc && (!src.IsUnconscious())) // If user's location is a turf, if it is not null, and if the user is not unconcious, continue.
		usr.emote("doorknocker")

/datum/emote/door_emote/run_emote(mob/living/user, params, type_override = null, intentional = TRUE)
	/// The message that will be sent from as the target.
	var/wall_message
	/// What was inputted by the user.
	var/door_emote = params
	if(QDELETED(user))
		return FALSE
	if(is_banned_from(user, "emote"))
		tgui_alert(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client?.prefs?.muted & MUTE_IC)
		tgui_alert(user, "You cannot send IC messages (muted).")
		return FALSE

	else if(!params) // User didn't put anything after the emote in command line, or just used the emote raw? Open a window.
		door_emote = tgui_input_text(user, "What would you like to emote?", "Container Emote" , null, MAX_MESSAGE_LEN, TRUE, TRUE, 0)
		if(!door_emote)
			return FALSE
		var/list/choices = list("Visible","Audible")
		var/type = tgui_input_list(user, "Is this a visible or audible emote?", "Wall or Door Emote", choices, FALSE)
		switch(type)
			if("Visible")
				emote_type = EMOTE_VISIBLE
			if("Audible")
				emote_type = EMOTE_AUDIBLE
			else
				tgui_alert(user, "Unable to use this emote, must be either audible or visible.")
				return
		door_message = door_emote //Like lemmings, I'm following the guy who did container_emote
	else
		door_message = params // Same as above.
		if(type_override)
			emote_type = type_override
		else
			emote_type = EMOTE_VISIBLE
	. = TRUE

	if(!can_run_emote(user))
		return FALSE

	user.log_message(door_message, LOG_EMOTE)

	var/space = should_have_space_before_emote(html_decode(door_emote)[1]) ? " " : ""

	door_message = ("[user.say_emphasis(door_message)]")

	// Make sure the emote isnt sent after the window pops up, after the source becomes invalid
	if(!can_run_emote(user))
		return FALSE

	if ((!target) || QDELETED(target) || user.IsUnconscious() || QDELETED(user)) //one last sanity check
		return FALSE

	if(emote_type == EMOTE_AUDIBLE)
		picked_loc.audible_message(message = door_message, self_message = door_message, audible_message_flags = EMOTE_MESSAGE, separation = space)

	else if (emote_type == EMOTE_VISIBLE)
		picked_loc.visible_message(message = door_message, self_message = door_message, visible_message_flags = EMOTE_MESSAGE, separation = space)
