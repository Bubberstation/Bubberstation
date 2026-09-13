#define NARRATE_RANGE_SAME_TILE "Same Tile"
#define NARRATE_RANGE_ONE_TILE "1-Tile Range"
#define NARRATE_RANGE_MAX "Max Range"
#define NARRATE_RANGE_CUSTOM "Custom Range"

GAME_VERB_DESC(/mob/living, narrate, "Narrate", "Allows you to send a narration message to a target or area", "IC")
	usr.emote("narrate")

/datum/emote/narrate
	name = "IC Narrate"
	key = "narrate"
	message = null

/datum/emote/narrate/run_emote(mob/living/user, params, type_override = null, intentional = TRUE)
	if(GLOB.say_disabled)	// This is here to try to identify lag problems
		to_chat(user, span_danger("Speech is currently admin-disabled."))
		return

	if(IS_UNCONSCIOUS_OR_CRIT(user))
		to_chat(user, span_warning("You can't narrate right now..."))
		return

	if(user.client.prefs?.muted & MUTE_IC)
		to_chat(user, span_danger("You are muted from sending IC messages."))
		return

	var/message = tgui_input_text(user, "Input the message you would like to send as narration", "Narrate", null, MAX_MESSAGE_LEN, TRUE)
	if(!message)
		return

	// Account for AI projecting on a holopad
	var/atom/movable/user_mob_or_hologram = GLOB.hologram_impersonators[user] || user

	var/list/viewers = get_hearers_in_view(world.view, user_mob_or_hologram)
	viewers -= GLOB.dead_mob_list
	viewers.Remove(user_mob_or_hologram)
	for(var/mob/mob in viewers) // Filters out the AI eye and clientless mobs.
		if(isaicamera(mob) || !mob.client)
			viewers.Remove(mob)

	var/list/targets = list(NARRATE_RANGE_SAME_TILE, NARRATE_RANGE_ONE_TILE, NARRATE_RANGE_MAX, NARRATE_RANGE_CUSTOM) + viewers
	var/target = tgui_input_list(user, "Pick a target", "Target Selection", targets)

	switch(target)
		if(NARRATE_RANGE_SAME_TILE)
			target = 0
		if(NARRATE_RANGE_ONE_TILE)
			target = 1
		if(NARRATE_RANGE_MAX)
			target = 7
		if(NARRATE_RANGE_CUSTOM)
			target = tgui_input_number(user, "What distance will you narrate", "Custom Range", max_value = world.view)
	if(isnull(target))
		return

	user.log_message(message, LOG_EMOTE)
	user.show_message(span_narrate("[message]"))

	// Handle target = range
	if(isnum(target))
		// Regenerate viewer list, people may have moved out of range since
		viewers = get_hearers_in_view(target, user_mob_or_hologram) - GLOB.dead_mob_list - user
		for(var/obj/effect/overlay/holo_pad_hologram/holo in viewers)
			if(holo.Impersonation?.client)
				viewers |= holo.Impersonation

		for(var/mob/receiver in viewers)
			receiver.show_message(span_narrate("[message] \n\ (Narration: [user])"), MSG_VISUAL)
	// Handle target = an individual
	else
		var/mob/target_mob = astype(target, /obj/effect/overlay/holo_pad_hologram)?.Impersonation || target
		if(!istype(target_mob))
			return // Target was neither a hologram with an impersonation attached, or a mob
		if(get_dist(user_mob_or_hologram.loc, target_mob.loc) > world.view)
			to_chat(user, span_warning("Your narration was unable to be sent to your target: Too far away."))
			return
		target_mob.show_message(span_narrate("[message] \n\ (Narration: [user])"), MSG_VISUAL)

#undef NARRATE_RANGE_MAX
#undef NARRATE_RANGE_SAME_TILE
#undef NARRATE_RANGE_ONE_TILE
#undef NARRATE_RANGE_CUSTOM
