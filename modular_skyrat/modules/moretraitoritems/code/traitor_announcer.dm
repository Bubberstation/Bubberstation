#define INFINITE_CHARGES -1

/obj/item/device/traitor_announcer
	name = "odd device"
	desc = "Hmm... what is this for?"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A remote that can be used to transmit a fake announcement of your own design."
	icon = 'icons/obj/devices/scanner.dmi'
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	///How many uses does it have? -1 for infinite
	var/uses = 1

/proc/try_user_announce(mob/living/user, list/available_sounds = GLOB.announcer_keys)
	//build our announcement
	var/origin = reject_bad_text(tgui_input_text(user, "Who is announcing, or where is the announcement coming from?", "Announcement Origin", get_area_name(user), max_length = 28))
	if(!origin)
		user.balloon_alert(user, "bad origin!")
		return FALSE
	var/audio_key = tgui_input_list(user, "Which announcement audio key should play? ('Intercept' is default)", "Announcement Audio", available_sounds, ANNOUNCER_INTERCEPT)
	if(!audio_key)
		user.balloon_alert(user, "bad audio!")
		return FALSE
	var/color = tgui_input_list(user, "Which color should the announcement be?", "Announcement Hue", ANNOUNCEMENT_COLORS, "default")
	if(!color)
		user.balloon_alert(user, "bad color!")
		return FALSE
	var/title = reject_bad_text(tgui_input_text(user, "Choose the title of the announcement.", "Announcement Title", max_length = 42))
	if(!title)
		user.balloon_alert(user, "bad title!")
		return FALSE
	var/input = reject_bad_text(tgui_input_text(user, "Choose the bodytext of the announcement.", "Announcement Text", max_length = 512, multiline = TRUE))
	if(!input)
		user.balloon_alert(user, "bad text!")
		return FALSE
	//treat voice
	var/list/message_data = user.treat_message(input)
	//send
	priority_announce(
		text = message_data["message"],
		title = title,
		sound = audio_key,
		has_important_message = TRUE,
		sender_override = origin,
		color_override = color,
		encode_text = FALSE,
		encode_title = FALSE
	)

	deadchat_broadcast(" made a fake priority announcement from [span_name("[get_area_name(usr, TRUE)]")].", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)
	user.log_talk("\[Message title\]: [title], \[Message\]: [input], \[Audio key\]: [audio_key]", LOG_TELECOMMS, tag = "priority announcement")
	message_admins("[ADMIN_LOOKUPFLW(user)] has made a fake announcement of [input].")

	return TRUE

/obj/item/device/traitor_announcer/attack_self(mob/living/user, modifiers)
	. = ..()
	//can we use this?
	if(!isliving(user) || (uses == 0))
		user.balloon_alert(user, "no uses left!")
		return

	var/result = try_user_announce(user)
	if(result)
		if(uses != INFINITE_CHARGES)
			uses--

// Adminbus
/obj/item/device/traitor_announcer/infinite
	uses = -1

#undef INFINITE_CHARGES
