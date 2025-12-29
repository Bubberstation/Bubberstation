/datum/listener_type/announce
	var/title = "Priority Alert"
	var/message = "Something has happened."
	var/announcer = "Central Command"
	var/sound = 'sound/effects/alert.ogg'
	var/color = COLOR_BLUE

/datum/listener_type/announce/parse_extra_args(title, message, announcer, sound, color)
	src.title = title
	src.message = message
	src.announcer = announcer
	src.sound = sound
	src.color = color

/datum/listener_type/announce/apply_action(datum/trigger_type/trigger, list/extra_args, key)
	var/final_title = title
	var/final_message = message
	var/final_sound = sound

	if(length(extra_args))
		var/list/data = extra_args[1]
		if(islist(data))
			if(data["title"])
				final_title = data["title"]
			if(data["message"])
				final_message = data["message"]
			if(data["sound"])
				final_sound = data["sound"]

	priority_announce(
		text = final_message,
		title = final_title,
		sound = final_sound,
		sender_override = announcer,
		color_override = color
	)


/obj/effect/mapping_helpers/listener_helper/announce
	name = "Announce Listener Helper"
	icon_state = "listener_announce"
	listener_type = /datum/listener_type/announce

	var/EDITOR_title = "SELF-DESTRUCT SEQUENCE ACTIVATED"
	var/EDITOR_message = "The station will self-destruct in T-10 minutes. Evacuate immediately."
	var/EDITOR_announcer = "Automated Announcement System"
	var/EDITOR_sound = 'sound/effects/alert.ogg'
	var/EDITOR_color = COLOR_BLUE

/obj/effect/mapping_helpers/listener_helper/announce/Initialize(mapload)
	extra_params = list(
		"title" = EDITOR_title,
		"message" = EDITOR_message,
		"announcer" = EDITOR_announcer,
		"sound" = EDITOR_sound,
		"color" = EDITOR_color
	)
	return ..()
