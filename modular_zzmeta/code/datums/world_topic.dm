/datum/world_topic/playerlist
	keyword = "playerlist"

/datum/world_topic/playerlist/Run(list/input)
	. = list()
	for(var/client/C as anything in GLOB.clients)
		var/mob/character = C.mob
		if(!istype(character) || isnewplayer(character) || !character.mind) // skip lobby/character-setup connections, nothing to report yet
			continue

		var/list/entry = list()
		entry["name"] = character.real_name || character.name
		entry["job"] = character.mind.assigned_role?.title
		entry["afk"] = !!C.is_afk()

		if(C.prefs?.read_preference(/datum/preference/toggle/chat_examine_headshot))
			var/headshot_type = issilicon(character) ? /datum/preference/text/headshot/silicon : /datum/preference/text/headshot
			var/headshot = C.prefs.read_preference(headshot_type)
			if(headshot)
				entry["headshot"] = headshot

		. += list(entry)
