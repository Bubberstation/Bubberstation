GLOBAL_VAR_INIT(temporary_flavor_text_indicator, generate_temporary_flavor_text_indicator())

#define NARRATE_SAME_TILE_TEXT "Same Tile"
#define NARRATE_ONE_TILE_TEXT "1-Tile Range"
#define NARRATE_CUSTOM_TILE_TEXT "Custom Range"

/proc/generate_temporary_flavor_text_indicator()
	var/mutable_appearance/temporary_flavor_text_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/temporary_flavor_text_indicator.dmi', "flavor", FLY_LAYER)
	temporary_flavor_text_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return temporary_flavor_text_indicator

/mob/living/verb/set_temporary_flavor()
	set category = "IC"
	set name = "Set Temporary Flavor Text"
	set desc = "Allows you to set a temporary flavor text."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't set your temporary flavor text now..."))
		return

	var/msg = tgui_input_text(usr, "Set the temporary flavor text in your 'examine' verb. This is for describing what people can tell by looking at your character.", "Temporary Flavor Text", temporary_flavor_text, max_length = MAX_FLAVOR_LEN, multiline = TRUE)
	if(msg == null)
		return

	// Turn empty input into no flavor text
	var/result = msg || null
	temporary_flavor_text = result
	update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

/mob/living/update_overlays()
	. = ..()
	if (temporary_flavor_text)
		. += GLOB.temporary_flavor_text_indicator

/mob/living/verb/local_narrate()
	set category = "IC"
	set name = "Local Narrate"
	set desc = "Allows you to send a narration message to a target or area"
	if(GLOB.say_disabled)	// This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't narrate right now..."))
		return

	var/target
	var/narrate_range = world.view
	var/narrated_message = tgui_input_text(usr, "Input the message you would like to send as narration", "Local Narrate", null, MAX_MESSAGE_LEN, TRUE)
	if(narrated_message == null)
		return

	var/list/viewers = get_hearers_in_range(narrate_range, usr)

	var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[usr]
	if(hologram)
		viewers |= get_hearers_in_view(narrate_range, hologram)

	viewers -= GLOB.dead_mob_list
	viewers.Remove(usr)

	for(var/mob/mob in viewers) // Filters out the AI eye and clientless mobs.
		if(istype(mob, /mob/camera/ai_eye))
			continue
		if(mob.client)
			continue
		viewers.Remove(mob)

	var/list/targets = list(NARRATE_SAME_TILE_TEXT, NARRATE_ONE_TILE_TEXT, NARRATE_CUSTOM_TILE_TEXT) + viewers
	target = tgui_input_list(usr, "Pick a target", "Target Selection", targets)
	if(!target)
		return

	switch(target)
		if(NARRATE_SAME_TILE_TEXT)
			target = 0
		if(NARRATE_ONE_TILE_TEXT)
			target = 1
		if(NARRATE_CUSTOM_TILE_TEXT)
			target = tgui_input_number(usr, "What distance will you narrate", "Custom Range", max_value = 7)

	usr.log_message(narrated_message, LOG_EMOTE)

	narrated_message = span_cyan("[usr.say_emphasis(narrated_message)]")

	if(istype(target, /mob))
		var/mob/target_mob = target
		usr.show_message(narrated_message, alt_msg = narrated_message)
		if((get_dist(usr.loc, target_mob.loc) <= narrate_range) || (hologram && get_dist(hologram.loc, target_mob.loc) <= narrate_range))
			target_mob.show_message(narrated_message, alt_msg = narrated_message)
		else
			to_chat(usr, span_warning("Your narration was unable to be sent to your target: Too far away."))
	else if(istype(target, /obj/effect/overlay/holo_pad_hologram))
		hologram = target
		if(hologram.Impersonation?.client)
			hologram.Impersonation.show_message(narrated_message, alt_msg = narrated_message)
	else
		var/watchers = get_hearers_in_view(target, usr) - GLOB.dead_mob_list

		if(hologram)
			watchers |= get_hearers_in_view(target, hologram)

		for(var/obj/effect/overlay/holo_pad_hologram/holo in watchers)
			if(holo?.Impersonation?.client)
				watchers |= holo.Impersonation

		for(var/mob/receiver in watchers)
			receiver.show_message(narrated_message, alt_msg = narrated_message)
