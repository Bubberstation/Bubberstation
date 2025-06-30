#define SUBTLE_DEFAULT_DISTANCE world.view
#define SUBTLE_ONE_TILE 1
#define SUBTLE_SAME_TILE_DISTANCE 0
#define SUBTLER_TELEKINESIS_DISTANCE 7

#define SUBTLE_ONE_TILE_TEXT "1-Tile Range"
#define SUBTLE_SAME_TILE_TEXT "Same Tile"

#define PORTAL_ONE_TILE_TEXT "Portal 1-Tile Range"
#define PORTAL_SAME_TILE_TEXT "Portal Tile"

/datum/emote/living/subtle
	key = "subtle"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/subtle/run_emote(mob/user, params, type_override = null)
	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE
	var/subtle_message
	var/subtle_emote = params
	if(SSdbcore.IsConnected() && is_banned_from(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		subtle_emote = tgui_input_text(user, "Choose an emote to display.", "Subtle", null, MAX_MESSAGE_LEN, TRUE)
		if(!subtle_emote)
			return FALSE
		subtle_message = subtle_emote
	else
		subtle_message = params
		if(type_override)
			emote_type = type_override

	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE

	user.log_message(subtle_message, LOG_SUBTLE)

	var/space = should_have_space_before_emote(html_decode(subtle_emote)[1]) ? " " : ""

	subtle_message = span_subtle("<b>[user]</b>[space]<i>[user.apply_message_emphasis(subtle_message)]</i>")

	var/list/viewers = get_hearers_in_view(SUBTLE_ONE_TILE, user)

	var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
	if(hologram)
		viewers |= get_hearers_in_view(SUBTLE_ONE_TILE, hologram)

	for(var/obj/effect/overlay/holo_pad_hologram/iterating_hologram in viewers)
		if(iterating_hologram?.Impersonation?.client)
			viewers |= iterating_hologram.Impersonation

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		if((ghost.client?.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers))
			to_chat(ghost, "[FOLLOW_LINK(ghost, user)] [subtle_message]")

	for(var/mob/receiver in viewers)
		receiver.show_message(subtle_message, alt_msg = subtle_message)
		// Optional sound notification
		if(!isobserver(receiver))
			var/datum/preferences/prefs = receiver.client?.prefs
			if(prefs && prefs.read_preference(/datum/preference/toggle/subtler_sound))
				receiver.playsound_local(get_turf(receiver), 'sound/effects/achievement/glockenspiel_ping.ogg', 50)

	return TRUE

/*
*	SUBTLE 2: NO GHOST BOOGALOO
*/

/datum/emote/living/subtler
	key = "subtler"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/subtler/run_emote(mob/user, params, type_override = null)
	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE
	var/subtler_message
	var/subtler_emote = params
	var/target
	var/subtler_range = SUBTLE_DEFAULT_DISTANCE

	if(SSdbcore.IsConnected() && is_banned_from(user, "emote"))
		to_chat(user, span_warning("You cannot send subtle emotes (banned)."))
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, span_warning("You cannot send IC messages (muted)."))
		return FALSE
	else if(!subtler_emote)
		subtler_emote = tgui_input_text(user, "Choose an emote to display.", "Subtler Anti-Ghost" , null, MAX_MESSAGE_LEN, TRUE)
		if(!subtler_emote)
			return FALSE

		var/list/in_view = get_hearers_in_view(subtler_range, user)

		var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
		if(hologram)
			in_view |= get_hearers_in_view(subtler_range, hologram)

		in_view -= GLOB.dead_mob_list
		in_view.Remove(user)

		for(var/mob/mob in in_view) // Filters out the AI eye and clientless mobs.
			if(istype(mob, /mob/eye/camera/ai))
				continue
			if(mob.client)
				continue
			in_view.Remove(mob)

		var/list/targets = list(SUBTLE_ONE_TILE_TEXT, SUBTLE_SAME_TILE_TEXT) + in_view
		var/obj/structure/lewd_portal/portal = user?.buckled
		if(istype(portal, /obj/structure/lewd_portal))
			targets.Insert(1, PORTAL_ONE_TILE_TEXT, PORTAL_SAME_TILE_TEXT)
		target = tgui_input_list(user, "Pick a target", "Target Selection", targets)
		if(!target)
			return FALSE

		switch(target)
			if(SUBTLE_ONE_TILE_TEXT)
				target = SUBTLE_ONE_TILE
			if(SUBTLE_SAME_TILE_TEXT)
				target = SUBTLE_SAME_TILE_DISTANCE
		subtler_message = subtler_emote
	else
		target = SUBTLE_DEFAULT_DISTANCE
		subtler_message = subtler_emote
		if(type_override)
			emote_type = type_override

	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE

	user.log_message(subtler_message, LOG_SUBTLER)

	var/space = should_have_space_before_emote(html_decode(subtler_emote)[1]) ? " " : ""

	subtler_message = span_subtler("<b>[user]</b>[space]<i>[user.apply_message_emphasis(subtler_message)]</i>")

	if(istype(target, /mob))
		var/mob/target_mob = target
		user.show_message(subtler_message, alt_msg = subtler_message)
		var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
		if((get_dist(user.loc, target_mob.loc) <= subtler_range) || (hologram && get_dist(hologram.loc, target_mob.loc) <= subtler_range))
			target_mob.show_message(subtler_message, alt_msg = subtler_message)
			subtler_sound(target_mob)
		else
			to_chat(user, span_warning("Your emote was unable to be sent to your target: Too far away."))
	else if(istype(target, /obj/effect/overlay/holo_pad_hologram))
		var/obj/effect/overlay/holo_pad_hologram/hologram = target
		if(hologram.Impersonation?.client)
			hologram.Impersonation.show_message(subtler_message, alt_msg = subtler_message)
			subtler_sound(hologram.Impersonation)
	else if(istype(target, /obj/lewd_portal_relay)) //Direct Message to a portal user
		var/obj/lewd_portal_relay/portal_relay = target
		user.show_message(subtler_message, alt_msg = subtler_message)
		if(portal_relay.owner?.client)
			subtler_message = span_subtler("<b>Unknown</b>[space]<i>[user.apply_message_emphasis(subtler_emote)]</i>")
			portal_relay.owner.show_message(subtler_message, alt_msg = subtler_message)
			subtler_sound(portal_relay.owner)
	else
		var/ghostless
		if(target == PORTAL_SAME_TILE_TEXT || target == PORTAL_ONE_TILE_TEXT)
			switch(target)
				if(PORTAL_ONE_TILE_TEXT)
					target = SUBTLE_ONE_TILE
				if(PORTAL_SAME_TILE_TEXT)
					target = SUBTLE_SAME_TILE_DISTANCE
			var/obj/structure/lewd_portal/portal_reference = user.buckled
			var/obj/lewd_portal_relay/output_portal = portal_reference?.relayed_body
			ghostless = get_hearers_in_view(target, output_portal) //Broadcast message through portal
			user.show_message(subtler_message, alt_msg = subtler_message)
			subtler_message = span_subtler("<b>[output_portal]</b>[space]<i>[user.apply_message_emphasis(subtler_emote)]</i>")
		else
			ghostless = get_hearers_in_view(target, user) - GLOB.dead_mob_list

		var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
		if(hologram)
			ghostless |= get_hearers_in_view(target, hologram)

		for(var/obj/effect/overlay/holo_pad_hologram/holo in ghostless)
			if(holo?.Impersonation?.client)
				ghostless |= holo.Impersonation

		for(var/mob/receiver in ghostless)
			receiver.show_message(subtler_message, alt_msg = subtler_message)
			// Optional sound notification
			subtler_sound(receiver)

		for(var/obj/lewd_portal_relay/portal in ghostless) //Message portal owners caught in range
			if(portal?.owner?.client && portal.owner != user)
				subtler_message = span_subtler("<b>Unknown</b>[space]<i>[user.apply_message_emphasis(subtler_emote)]</i>")
				portal.owner.show_message(subtler_message, alt_msg = subtler_message)
			subtler_sound(portal.owner)

	return TRUE

// Optional sound notification for subtler
/datum/emote/living/subtler/proc/subtler_sound(mob/hearer)
	var/datum/preferences/prefs = hearer.client?.prefs
	if(prefs && prefs.read_preference(/datum/preference/toggle/subtler_sound))
		hearer.playsound_local(get_turf(hearer), 'sound/effects/achievement/glockenspiel_ping.ogg', 50)

/*
*	VERB CODE
*/

/mob/living/proc/subtle_keybind()
	var/message = input(src, "", "subtle") as text|null
	if(!length(message))
		return
	return subtle(message)

/mob/living/verb/subtle()
	set name = "Subtle"
	set category = "IC"
	if(GLOB.say_disabled)	// This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	usr.emote("subtle")

/*
*	VERB CODE 2
*/

/mob/living/verb/subtler()
	set name = "Subtler Anti-Ghost"
	set category = "IC"
	if(GLOB.say_disabled)	// This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	usr.emote("subtler")

#undef SUBTLE_DEFAULT_DISTANCE
#undef SUBTLE_ONE_TILE
#undef SUBTLE_SAME_TILE_DISTANCE
#undef SUBTLER_TELEKINESIS_DISTANCE

#undef SUBTLE_ONE_TILE_TEXT
#undef SUBTLE_SAME_TILE_TEXT

#undef PORTAL_ONE_TILE_TEXT
#undef PORTAL_SAME_TILE_TEXT
