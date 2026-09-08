#define SCENE_ASSISTANT_RANGE 2
#define SCENE_ASSISTANT_MAX_CHARS 2000
#define SCENE_ASSISTANT_MAX_LOG 250
#define SCENE_ASSISTANT_INVITE_TIMEOUT (2 MINUTES)
#define SCENE_ASSISTANT_RANGE_CHECK_INTERVAL (5 SECONDS)
#define SCENE_ASSISTANT_INTERACTION_CACHE (2 SECONDS)
#define SCENE_ASSISTANT_NEARBY_CACHE (1 SECONDS)

/**
 * Scene Assistant - a shared writing room for nearby living mobs.
 * Messages still go through real say/emote/subtle. This window is the scene, not a replacement for IC speech.
 */
/datum/rp_panel
	var/mob/living/holder
	var/list/participants = list()
	var/list/pending_invites = list()
	var/list/messages = list()
	var/list/typing_participants = list()
	/// True while this panel's holder has composer text (drives sprite + chat typing).
	var/holder_is_typing = FALSE
	var/mob/living/selected_participant
	var/emote_mode = "say"
	var/scene_details = ""
	/// Unsent composer text. Restored if the holder reconnects to this mob.
	var/draft_text = ""
	var/sending_message = FALSE

	var/theme = "default"
	var/soundpack = "default"
	var/sound_message_enabled = TRUE
	var/sound_join_enabled = TRUE
	var/sound_leave_enabled = TRUE
	var/volume_message = 50
	var/volume_join = 50
	var/volume_leave = 50
	var/show_avatars = TRUE
	var/show_images = TRUE
	var/avatar_size = 64
	var/log_font = "Verdana"
	var/log_font_size = 100
	var/log_line_spacing = 1.35
	var/name_color = "#c084fc"
	/// Character save slot this mob was spawned from. Never use the client's currently selected prefs slot.
	var/character_slot = 0
	var/range_check_queued = FALSE
	var/range_watch_timer
	var/cached_interaction_ref
	var/cached_interaction_lewd
	var/cached_interaction_at = 0
	var/list/cached_interaction_data
	var/list/cached_formatted_messages
	var/formatted_messages_dirty = TRUE
	var/list/cached_participants
	var/list/cached_nearby
	var/cached_nearby_at = 0

/datum/rp_panel/New(mob/living/new_holder)
	. = ..()
	holder = new_holder
	selected_participant = holder
	RegisterSignal(holder, COMSIG_MOB_SAY, PROC_REF(on_say))
	RegisterSignal(holder, COMSIG_MOB_EMOTE, PROC_REF(on_emote))
	RegisterSignal(holder, COMSIG_QDELETING, PROC_REF(on_holder_qdeleting))
	RegisterSignal(holder, COMSIG_MOVABLE_MOVED, PROC_REF(on_holder_moved))
	load_prefs()

/datum/rp_panel/Destroy()
	stop_range_watch()
	if(holder)
		if(holder_is_typing)
			holder.remove_all_indicators()
			holder_is_typing = FALSE
		UnregisterSignal(holder, list(COMSIG_MOB_SAY, COMSIG_MOB_EMOTE, COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
		if(holder.rp_panel == src)
			holder.rp_panel = null
		holder = null
	selected_participant = null
	participants = null
	pending_invites = null
	messages = null
	typing_participants = null
	cached_interaction_data = null
	cached_formatted_messages = null
	cached_participants = null
	cached_nearby = null
	return ..()

/datum/rp_panel/proc/on_holder_qdeleting(datum/source)
	SIGNAL_HANDLER
	SStgui.close_uis(src)
	if(holder?.rp_panel == src)
		holder.rp_panel = null
	holder = null
	qdel(src)

/datum/rp_panel/proc/on_holder_moved(atom/movable/source)
	SIGNAL_HANDLER
	cached_nearby = null
	cached_nearby_at = 0
	if(length(participants) || length(pending_invites))
		expire_stale_invites()
		queue_range_check()

/datum/rp_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/rp_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RpPanel", "Scene Assistant")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/rp_panel/ui_close(mob/user)
	set_typing(FALSE)
	return ..()

/datum/asset/simple/scene_assistant
	assets = list(
		"scene_assistant.png" = 'tgui/packages/tgui/interfaces/RpPanel/scene_assistant.png',
	)

/datum/rp_panel/ui_assets(mob/user)
	return list(get_asset_datum(/datum/asset/simple/scene_assistant))

/datum/rp_panel/proc/load_prefs()
	var/datum/preferences/prefs = holder?.client?.prefs
	if(!prefs)
		name_color = default_scene_assistant_name_color(holder?.name || holder?.ckey)
		return
	show_avatars = prefs.read_preference(/datum/preference/toggle/scene_assistant_show_avatars)
	show_images = prefs.read_preference(/datum/preference/toggle/scene_assistant_show_images)
	avatar_size = prefs.read_preference(/datum/preference/numeric/scene_assistant_avatar_size)
	log_font = prefs.read_preference(/datum/preference/text/scene_assistant_font)
	log_font_size = prefs.read_preference(/datum/preference/numeric/scene_assistant_font_size)
	log_line_spacing = prefs.read_preference(/datum/preference/numeric/scene_assistant_line_spacing)
	sound_message_enabled = prefs.read_preference(/datum/preference/toggle/scene_assistant_sound_message)
	sound_join_enabled = prefs.read_preference(/datum/preference/toggle/scene_assistant_sound_join)
	sound_leave_enabled = prefs.read_preference(/datum/preference/toggle/scene_assistant_sound_leave)
	volume_message = prefs.read_preference(/datum/preference/numeric/scene_assistant_volume_message)
	volume_join = prefs.read_preference(/datum/preference/numeric/scene_assistant_volume_join)
	volume_leave = prefs.read_preference(/datum/preference/numeric/scene_assistant_volume_leave)
	character_slot = get_played_character_slot(holder)
	theme = read_mob_character_pref(holder, /datum/preference/choiced/scene_assistant_theme) || "default"
	soundpack = read_mob_character_pref(holder, /datum/preference/choiced/scene_assistant_soundpack) || "default"
	var/saved_color = read_mob_character_pref(holder, /datum/preference/color/scene_assistant_name_color)
	name_color = sanitize_hexcolor(saved_color) || default_scene_assistant_name_color(holder?.real_name || holder?.name || holder?.ckey)

/datum/rp_panel/proc/get_played_character_slot(mob/living/target)
	if(!target)
		return 0
	if(target.rp_panel && target.rp_panel.character_slot)
		return target.rp_panel.character_slot
	var/slot = 0
	if(target.mind?.original_character_slot_index)
		slot = target.mind.original_character_slot_index
	else
		slot = find_character_slot_by_name(target)
	if(slot && target.rp_panel)
		target.rp_panel.character_slot = slot
	return slot

/datum/rp_panel/proc/find_character_slot_by_name(mob/living/target)
	var/datum/preferences/prefs = target?.client?.prefs
	if(!prefs?.savefile)
		return 0
	var/mob_name = target.real_name || target.name
	if(!mob_name)
		return 0
	for(var/slot in 1 to prefs.max_save_slots)
		var/list/save_data = prefs.savefile.get_entry("character[slot]")
		if(!islist(save_data))
			continue
		if(save_data["real_name"] == mob_name)
			return slot
	return 0

/datum/rp_panel/proc/prefs_cache_belongs_to_mob(mob/living/target, datum/preferences/prefs)
	if(!target || !prefs || !prefs.value_cache)
		return FALSE
	var/cached_name = prefs.value_cache[/datum/preference/name/real_name]
	if(!cached_name)
		return FALSE
	return cached_name == (target.real_name || target.name)

/datum/rp_panel/proc/read_mob_character_pref(mob/living/target, pref_type)
	var/datum/preferences/prefs = target?.client?.prefs
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return null
	if(preference_entry.savefile_identifier != PREFERENCE_CHARACTER)
		return prefs?.read_preference(pref_type)
	var/slot = get_played_character_slot(target)
	if(slot && prefs?.savefile)
		var/list/save_data = prefs.savefile.get_entry("character[slot]")
		var/value = preference_entry.read(save_data, prefs)
		if(!isnull(value))
			return value
	return character_pref_fallback(preference_entry, target)

/datum/rp_panel/proc/character_pref_fallback(datum/preference/preference_entry, mob/living/target)
	if(istype(preference_entry, /datum/preference/color/scene_assistant_name_color))
		return default_scene_assistant_name_color(target?.real_name || target?.name || target?.ckey)
	return preference_entry.create_default_value()

/datum/rp_panel/proc/write_mob_character_pref(mob/living/target, pref_type, value)
	var/datum/preferences/prefs = target?.client?.prefs
	if(!prefs)
		return FALSE
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return FALSE
	if(preference_entry.savefile_identifier != PREFERENCE_CHARACTER)
		if(!prefs.write_preference(preference_entry, value))
			return FALSE
		prefs.recently_updated_keys |= preference_entry.type
		prefs.save_preferences()
		return TRUE
	var/slot = get_played_character_slot(target)
	if(!slot)
		return FALSE
	var/tree_key = "character[slot]"
	var/list/save_data = prefs.savefile.get_entry(tree_key)
	if(isnull(save_data))
		prefs.savefile.set_entry(tree_key, list())
		save_data = prefs.savefile.get_entry(tree_key)
	var/new_value = preference_entry.deserialize(value, prefs)
	if(!preference_entry.write(save_data, new_value, prefs))
		return FALSE
	if(prefs.default_slot == slot && prefs_cache_belongs_to_mob(target, prefs))
		prefs.value_cache[preference_entry.type] = new_value
	prefs.savefile.save()
	return TRUE

/datum/rp_panel/proc/write_player_pref(pref_type, value)
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return
	if(preference_entry.savefile_identifier == PREFERENCE_CHARACTER)
		write_mob_character_pref(holder, pref_type, value)
		return
	var/datum/preferences/prefs = holder?.client?.prefs
	if(!prefs)
		return
	if(prefs.write_preference(preference_entry, value))
		prefs.recently_updated_keys |= preference_entry.type
		prefs.save_preferences()

/datum/rp_panel/proc/erp_enabled(mob/living/target)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return target?.client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences) && target.client.prefs.read_preference(/datum/preference/toggle/erp)

/datum/rp_panel/proc/erp_content_enabled(mob/living/target)
	if(!erp_enabled(target))
		return FALSE
	var/erp_status = read_mob_character_pref(target, /datum/preference/choiced/erp_status)
	if(!erp_status || erp_status == "No" || erp_status == "None")
		return FALSE
	return TRUE

/datum/rp_panel/proc/get_headshot(mob/living/target)
	if(!target)
		return ""
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		return human_target.dna?.features["headshot"] || ""
	if(target.client?.ckey)
		var/datum/preference/text/headshot/pref = GLOB.preference_entries[/datum/preference/text/headshot]
		if(pref?.stored_link)
			return pref.stored_link[target.client.ckey] || ""
	return ""

/datum/rp_panel/proc/get_member_color(mob/living/target)
	if(!target || QDELETED(target))
		return "#c084fc"
	if(target.rp_panel?.name_color)
		return target.rp_panel.name_color
	var/saved_color = read_mob_character_pref(target, /datum/preference/color/scene_assistant_name_color)
	if(saved_color)
		return sanitize_hexcolor(saved_color)
	return default_scene_assistant_name_color(target.name || target.ckey)

/datum/rp_panel/proc/apply_name_color(raw_color)
	var/sanitized = sanitize_hexcolor(raw_color)
	if(!sanitized)
		return FALSE
	name_color = sanitized
	write_player_pref(/datum/preference/color/scene_assistant_name_color, name_color)
	var/holder_ref = REF(holder)
	for(var/datum/rp_panel/panel as anything in get_linked_panels())
		for(var/list/entry as anything in panel.messages)
			if(entry["ref"] == holder_ref)
				entry["color"] = name_color
		panel.invalidate_formatted_log()
		panel.invalidate_participant_cache()
		SStgui.update_uis(panel)
	return TRUE

/datum/rp_panel/proc/get_scene_members()
	var/list/members = list()
	if(holder && !QDELETED(holder))
		members += holder
	for(var/datum/weakref/participant_ref as anything in participants)
		var/mob/living/member = participant_ref.resolve()
		if(member && !QDELETED(member) && !(member in members))
			members += member
	return members

/datum/rp_panel/proc/get_linked_panels()
	var/list/panels = list()
	for(var/mob/living/member as anything in collect_scene_members())
		if(member.rp_panel && !(member.rp_panel in panels))
			panels += member.rp_panel
	if(!(src in panels))
		panels += src
	return panels

/// Walk every connected participant list so the scene is one shared group.
/datum/rp_panel/proc/collect_scene_members()
	var/list/seen = list()
	var/list/queue = get_scene_members()
	while(length(queue))
		var/mob/living/member = queue[1]
		queue.Cut(1, 2)
		if(!member || QDELETED(member) || (member in seen))
			continue
		seen += member
		if(!member.rp_panel)
			continue
		for(var/mob/living/other as anything in member.rp_panel.get_scene_members())
			if(!(other in seen))
				queue += other
	return seen

/// Write the same member set onto every panel so joins/leaves stay in sync.
/datum/rp_panel/proc/sync_scene_membership(list/members)
	for(var/mob/living/member as anything in members)
		if(!member || QDELETED(member))
			continue
		if(!member.rp_panel)
			member.rp_panel = new(member)
		member.rp_panel.participants = list()
		for(var/mob/living/other as anything in members)
			if(!other || QDELETED(other) || other == member)
				continue
			add_weakref_unique(member.rp_panel.participants, other)
		member.rp_panel.scene_details = scene_details
		member.rp_panel.invalidate_participant_cache()

/datum/rp_panel/proc/add_weakref_unique(list/refs, mob/living/target)
	for(var/datum/weakref/ref as anything in refs)
		if(ref.resolve() == target)
			return
	refs += WEAKREF(target)

/datum/rp_panel/proc/drop_weakref(list/refs, mob/living/target)
	if(!refs)
		return
	for(var/datum/weakref/ref as anything in refs.Copy())
		if(ref.resolve() == target)
			refs -= ref

/datum/rp_panel/proc/is_in_scene(mob/living/target)
	if(target == holder)
		return TRUE
	for(var/datum/weakref/ref as anything in participants)
		if(ref.resolve() == target)
			return TRUE
	return FALSE

/datum/rp_panel/proc/in_scene_range(mob/living/target)
	var/turf/holder_turf = get_turf(holder)
	var/turf/target_turf = get_turf(target)
	if(!holder_turf || !target_turf)
		return FALSE
	return get_dist(holder_turf, target_turf) <= SCENE_ASSISTANT_RANGE

/datum/rp_panel/proc/can_invite_kind(mob/living/target)
	return iscarbon(target) || issilicon(target)

/datum/rp_panel/Topic(href, href_list)
	. = ..()
	var/mob/living/joiner = usr
	if(!isliving(joiner) || !href_list["join"])
		return
	if(QDELETED(src) || QDELETED(holder))
		to_chat(joiner, span_warning("That scene invite is no longer valid."))
		return
	if(!joiner.ckey || !is_invite_valid(joiner))
		pending_invites -= joiner.ckey
		to_chat(joiner, span_warning("That scene invite is no longer valid."))
		return
	if(!in_scene_range(joiner))
		pending_invites -= joiner.ckey
		to_chat(joiner, span_warning("You are too far away to join [holder]'s Scene."))
		return
	pending_invites -= joiner.ckey
	complete_add_participant(joiner)

/datum/rp_panel/proc/invite_living(mob/living/target)
	if(!target || QDELETED(target) || target == holder)
		return FALSE
	if(!can_invite_kind(target))
		to_chat(holder, span_warning("You cannot invite [target] to the scene."))
		return FALSE
	if(target in collect_scene_members())
		to_chat(holder, span_notice("[target] is already in the scene."))
		return FALSE
	if(!in_scene_range(target))
		to_chat(holder, span_warning("[target] is too far away."))
		return FALSE
	if(!target.ckey)
		return complete_add_participant(target)
	pending_invites[target.ckey] = list("time" = world.time, "ref" = WEAKREF(target))
	start_range_watch()
	var/join_button = "<a href='byond://?src=[REF(src)];join=1'>Join</a>"
	to_chat(target, boxed_message(span_notice("You have been invited to [holder]'s Scene! [join_button]")))
	play_scene_invite_sound(target)
	to_chat(holder, span_notice("Invited [target] to your Scene."))
	return TRUE

/// Alert sound for the invitee only (not gated by scene sound toggles).
/datum/rp_panel/proc/play_scene_invite_sound(mob/living/target)
	if(!target?.client)
		return
	target.playsound_local(
		get_turf(target),
		'modular_zubbers/sound/misc/rppanelsounds/messagechime.ogg',
		65,
		FALSE,
		pressure_affected = FALSE,
		use_reverb = FALSE,
	)

/datum/rp_panel/proc/complete_add_participant(mob/living/target)
	if(!target || QDELETED(target) || QDELETED(src) || QDELETED(holder) || target == holder)
		return FALSE
	if(!can_invite_kind(target))
		return FALSE
	var/list/members = collect_scene_members()
	if(target in members)
		to_chat(holder, span_notice("[target] is already in the scene."))
		return FALSE
	if(!in_scene_range(target))
		to_chat(target, span_warning("You are too far away to join [holder]'s Scene."))
		return FALSE

	members += target
	sync_scene_membership(members)
	// Joiners keep their own log. Do not copy missed messages from the live scene.
	target.rp_panel.scene_details = scene_details

	to_chat(holder, span_notice("[target] joined the scene."))
	to_chat(target, span_notice("You joined the scene."))
	append_scene_message(list(
		"name" = "Scene",
		"message" = "[target.name] joined the scene.",
		"headshot" = "",
		"mode" = "system",
		"timestamp" = time2text(world.timeofday, "HH:MM:SS"),
		"ref" = "",
		"color" = "#c084fc",
	))
	play_sound_to_participants("join")
	for(var/mob/living/member as anything in members)
		if(member.rp_panel)
			member.rp_panel.start_range_watch()
			SStgui.update_uis(member.rp_panel)
	target.rp_panel.ui_interact(target)
	return TRUE

/datum/rp_panel/proc/is_invite_valid(mob/living/target)
	if(!target?.ckey)
		return FALSE
	var/list/invite = pending_invites[target.ckey]
	if(!islist(invite))
		return FALSE
	if(world.time > invite["time"] + SCENE_ASSISTANT_INVITE_TIMEOUT)
		return FALSE
	return TRUE

/datum/rp_panel/proc/expire_stale_invites()
	if(!length(pending_invites))
		return
	for(var/invite_ckey in pending_invites.Copy())
		var/list/invite = pending_invites[invite_ckey]
		if(!islist(invite) || world.time > invite["time"] + SCENE_ASSISTANT_INVITE_TIMEOUT)
			pending_invites -= invite_ckey
			continue
		var/datum/weakref/target_ref = invite["ref"]
		var/mob/living/target = target_ref?.resolve()
		if(!target || QDELETED(target) || !in_scene_range(target))
			pending_invites -= invite_ckey

/datum/rp_panel/proc/start_range_watch()
	if(range_watch_timer || QDELETED(src))
		return
	if(!length(participants) && !length(pending_invites))
		return
	range_watch_timer = addtimer(CALLBACK(src, PROC_REF(range_watch_tick)), SCENE_ASSISTANT_RANGE_CHECK_INTERVAL, TIMER_STOPPABLE | TIMER_DELETE_ME)

/datum/rp_panel/proc/stop_range_watch()
	if(!range_watch_timer)
		return
	deltimer(range_watch_timer)
	range_watch_timer = null

/datum/rp_panel/proc/range_watch_tick()
	range_watch_timer = null
	if(QDELETED(src))
		return
	expire_stale_invites()
	if(length(participants))
		queue_range_check()
	if(length(participants) || length(pending_invites))
		start_range_watch()

/// Anyone in the scene may remove anyone else. Pass voluntary = TRUE to leave yourself.
/datum/rp_panel/proc/remove_participant(mob/living/target, voluntary = FALSE)
	if(!target || QDELETED(target))
		return FALSE
	if(!voluntary && target == holder)
		return FALSE
	var/list/members = collect_scene_members()
	if(!(target in members))
		return FALSE
	play_sound_to_participants("leave")
	members -= target
	for(var/mob/living/member as anything in members)
		if(member.rp_panel?.selected_participant == target)
			member.rp_panel.selected_participant = member
		drop_weakref(member.rp_panel?.typing_participants, target)
	if(target.rp_panel)
		target.rp_panel.set_typing(FALSE)
		target.rp_panel.participants = list()
		target.rp_panel.typing_participants = list()
		target.rp_panel.selected_participant = target
		target.rp_panel.stop_range_watch()
		target.rp_panel.invalidate_participant_cache()
		if(voluntary)
			SStgui.update_uis(target.rp_panel)
		else
			SStgui.close_uis(target.rp_panel)
	sync_scene_membership(members)
	var/list/leave_entry = list(
		"name" = "Scene",
		"message" = "[target.name] left the scene.",
		"headshot" = "",
		"mode" = "system",
		"timestamp" = time2text(world.timeofday, "HH:MM:SS"),
		"ref" = "",
		"color" = "#c084fc",
	)
	for(var/mob/living/member as anything in members)
		if(!member.rp_panel)
			continue
		member.rp_panel.add_log_entry(leave_entry)
		if(length(member.rp_panel.participants))
			member.rp_panel.start_range_watch()
		else
			member.rp_panel.stop_range_watch()
		SStgui.update_uis(member.rp_panel)
	if(voluntary)
		to_chat(target, span_notice("You left the scene."))
	else
		to_chat(holder, span_notice("Removed [target] from the scene."))
		to_chat(target, span_notice("You were removed from the scene."))
	return TRUE

/datum/rp_panel/proc/leave_scene()
	return remove_participant(holder, TRUE)

/datum/rp_panel/proc/check_and_remove_out_of_range()
	var/list/leaving = list()
	for(var/datum/weakref/participant_ref as anything in participants)
		var/mob/living/participant = participant_ref.resolve()
		if(!participant || QDELETED(participant) || !in_scene_range(participant))
			leaving += participant_ref
	for(var/datum/weakref/ref_to_drop as anything in leaving)
		var/mob/living/gone = ref_to_drop.resolve()
		if(gone)
			to_chat(holder, span_notice("[gone] left the scene's range."))
			to_chat(gone, span_notice("You left [holder]'s Scene range."))
			remove_participant(gone)
		else
			participants -= ref_to_drop
			invalidate_participant_cache()

/datum/rp_panel/proc/append_scene_message(list/message_entry)
	for(var/datum/rp_panel/panel as anything in get_linked_panels())
		panel.add_log_entry(message_entry)
		SStgui.update_uis(panel)

/datum/rp_panel/proc/add_log_entry(list/message_entry)
	messages += list(message_entry)
	if(length(messages) > SCENE_ASSISTANT_MAX_LOG)
		messages.Cut(1, length(messages) - SCENE_ASSISTANT_MAX_LOG + 1)
	invalidate_formatted_log()

/datum/rp_panel/proc/invalidate_formatted_log()
	formatted_messages_dirty = TRUE
	cached_formatted_messages = null

/datum/rp_panel/proc/invalidate_participant_cache()
	cached_participants = null
	cached_nearby = null
	cached_nearby_at = 0

/datum/rp_panel/proc/build_log_entry(mob/living/speaker, message, mode, image_url = "")
	return list(
		"name" = speaker.name,
		"message" = message,
		"headshot" = get_headshot(speaker),
		"mode" = mode,
		"timestamp" = time2text(world.timeofday, "HH:MM:SS"),
		"ref" = REF(speaker),
		"color" = get_member_color(speaker),
		"image" = image_url,
	)

/datum/rp_panel/proc/is_scene_image_url(raw_url)
	var/value = trim("[raw_url]")
	if(!length(value) || copytext(value, 1, 9) != "https://")
		return FALSE
	var/url_no_query = splittext(value, "?")[1]
	url_no_query = splittext(url_no_query, "#")[1]
	var/list/value_split = splittext(url_no_query, ".")
	var/extension = lowertext(value_split[length(value_split)])
	var/static/list/valid_extensions = list("jpg", "png", "jpeg", "gif", "webp")
	if(!(extension in valid_extensions))
		return FALSE
	var/datum/preference/text/headshot/headshot_pref = GLOB.preference_entries[/datum/preference/text/headshot]
	if(!headshot_pref)
		return FALSE
	return findtext(value, headshot_pref.link_regex) == 9

/datum/rp_panel/proc/sanitize_scene_image_url(raw_url)
	var/value = trim("[raw_url]")
	if(is_scene_image_url(value))
		return value
	to_chat(holder, span_warning("Images must be a direct https jpg, png, jpeg, gif, or webp link from Catbox, Imgbox, Gyazo, Lensdump, or F-List."))
	return ""

/datum/rp_panel/proc/newlines_to_html(raw_text)
	return replacetext("[raw_text]", regex("(?:\\r\\n?|\\n)", "g"), "<br>")

/datum/rp_panel/proc/flatten_newlines(raw_text)
	return replacetext("[raw_text]", regex("(?:\\r\\n?|\\n)", "g"), " ")

/datum/rp_panel/proc/send_scene_image(raw_url, raw_caption = "")
	if(holder_cannot_emote())
		notify_cannot_act("emote")
		return
	var/image_url = sanitize_scene_image_url(raw_url)
	if(!image_url)
		return
	var/caption = trim(copytext_char("[raw_caption]", 1, SCENE_ASSISTANT_MAX_CHARS + 1))
	if(holder.client?.autopunctuation && length(caption))
		caption = autopunct_bare(caption)
	set_typing(FALSE)
	draft_text = ""
	append_scene_message(build_log_entry(holder, caption, "subtler", image_url))
	play_sound_to_participants("message")
	holder.log_message("scene image: [image_url][length(caption) ? " - [caption]" : ""]", LOG_SUBTLER)

/datum/rp_panel/proc/notify_cannot_act(action_word)
	if(!holder)
		return
	holder.balloon_alert(holder, "can't [action_word]!")
	var/reason = "unconscious"
	if(holder.stat == DEAD)
		reason = "dead"
	else if(holder.stat >= SOFT_CRIT)
		reason = "in crit"
	to_chat(holder, span_warning("You cannot [action_word] while [reason]."))

/datum/rp_panel/proc/holder_cannot_emote()
	return QDELETED(holder) || holder.stat == DEAD || IS_UNCONSCIOUS_OR_CRIT(holder)

/// Mirror living_say: dead never speaks IC; unconscious only whispers in hard crit.
/datum/rp_panel/proc/holder_can_speak_ic(whispering)
	if(QDELETED(holder))
		return FALSE
	if(holder.stat == DEAD)
		notify_cannot_act("speak")
		return FALSE
	if(IS_UNCONSCIOUS(holder) && (!whispering || holder.stat != HARD_CRIT))
		notify_cannot_act("speak")
		return FALSE
	return TRUE

/datum/rp_panel/proc/can_send_scene_speech(mode)
	if(GLOB.say_disabled)
		to_chat(holder, span_danger("Speech is currently admin-disabled."))
		return FALSE
	if(holder.client?.prefs?.muted & MUTE_IC)
		to_chat(holder, span_warning("You cannot send IC messages (muted)."))
		return FALSE
	switch(mode)
		if("emote", "subtle", "subtler", "subtler_antighost")
			if(holder_cannot_emote())
				notify_cannot_act("emote")
				return FALSE
			if(SSdbcore.IsConnected() && holder.ckey && is_banned_from(holder.ckey, "emote"))
				to_chat(holder, span_warning("You cannot send emotes (banned)."))
				return FALSE
		if("say")
			if(!holder_can_speak_ic(FALSE))
				return FALSE
		if("whisper")
			if(!holder_can_speak_ic(TRUE))
				return FALSE
	return TRUE

/datum/rp_panel/proc/begin_sending_message()
	sending_message = TRUE
	addtimer(VARSET_CALLBACK(src, sending_message, FALSE), 10 SECONDS, TIMER_DELETE_ME)

/datum/rp_panel/proc/end_sending_message()
	sending_message = FALSE

/datum/rp_panel/proc/send_scene_message(raw_message)
	var/message = trim(copytext_char("[raw_message]", 1, SCENE_ASSISTANT_MAX_CHARS + 1))
	if(!length(message))
		return
	if(is_scene_image_url(message))
		send_scene_image(message)
		return
	if(!can_send_scene_speech(emote_mode))
		return
	set_typing(FALSE)
	draft_text = ""
	if(holder.client?.autopunctuation)
		message = autopunct_bare(message)
	var/ic_message = message
	var/log_message = message
	switch(emote_mode)
		if("say", "whisper")
			ic_message = flatten_newlines(message)
			log_message = ic_message
		if("emote", "subtle", "subtler", "subtler_antighost")
			ic_message = newlines_to_html(message)
	begin_sending_message()
	switch(emote_mode)
		if("say")
			holder.say(ic_message)
		if("whisper")
			holder.whisper(ic_message)
		if("emote")
			holder.emote("me", message = ic_message, intentional = TRUE)
		if("subtle")
			holder.emote("subtle", null, ic_message, TRUE)
		if("subtler")
			send_subtler_message(ic_message, 1)
		if("subtler_antighost")
			send_subtler_message(ic_message, 0)
		else
			end_sending_message()
			return
	append_scene_message(build_log_entry(holder, log_message, emote_mode))
	play_sound_to_participants("message")
	end_sending_message()

/// Subtler params skip the picker but force world.view, so we send with the intended range ourselves.
/// subtler = 1-tile anti-ghost; subtler_antighost = same-tile anti-ghost.
/datum/rp_panel/proc/send_subtler_message(message, range)
	var/decoded = html_decode(message)
	if(!length(decoded))
		return
	var/space = should_have_space_before_emote(decoded[1]) ? " " : ""
	var/subtler_message = span_subtler("<b>[holder]</b>[space]<i>[holder.apply_message_emphasis(message)]</i>")
	var/list/ghostless = get_hearers_in_view(range, holder) - GLOB.dead_mob_list
	var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[holder]
	if(hologram)
		ghostless |= get_hearers_in_view(range, hologram)
	for(var/obj/effect/overlay/holo_pad_hologram/holo in ghostless)
		if(holo?.Impersonation?.client)
			ghostless |= holo.Impersonation
	for(var/mob/receiver in ghostless)
		if(istype(receiver, /mob/eye/camera/ai))
			continue
		receiver.show_message(subtler_message, alt_msg = subtler_message)
		// Scene Assistant plays its own message chime — no subtler glockenspiel here.
	holder.log_message(message, LOG_SUBTLER)

/datum/rp_panel/proc/play_sound_to_participants(sound_type)
	for(var/datum/rp_panel/panel as anything in get_linked_panels())
		panel.play_own_scene_sound(sound_type)

/datum/rp_panel/proc/play_own_scene_sound(sound_type)
	if(!holder?.client)
		return
	var/static/list/message_sounds = list(
		"default" = 'modular_zubbers/sound/misc/rppanelsounds/messagechime.ogg',
		"simpleandsweet" = 'modular_zubbers/sound/misc/rppanelsounds/simpleandsweetmessage.ogg',
		"delicate" = 'modular_zubbers/sound/misc/rppanelsounds/delicatemessage.ogg',
		"funkyou" = 'modular_zubbers/sound/misc/rppanelsounds/funkyoumessage.ogg',
		"gravitas" = 'modular_zubbers/sound/misc/rppanelsounds/gravitasmessage.ogg',
		"8bitautumn" = 'modular_zubbers/sound/misc/rppanelsounds/8bitautumnmessage.ogg',
	)
	var/static/list/join_sounds = list(
		"default" = 'modular_zubbers/sound/misc/rppanelsounds/messagejoin.ogg',
		"simpleandsweet" = 'modular_zubbers/sound/misc/rppanelsounds/simpleandsweetjoin.ogg',
		"delicate" = 'modular_zubbers/sound/misc/rppanelsounds/delicatejoin.ogg',
		"funkyou" = 'modular_zubbers/sound/misc/rppanelsounds/funkyoujoin.ogg',
		"gravitas" = 'modular_zubbers/sound/misc/rppanelsounds/gravitasjoin.ogg',
		"8bitautumn" = 'modular_zubbers/sound/misc/rppanelsounds/8bitautumnjoin.ogg',
	)
	var/static/list/leave_sounds = list(
		"default" = 'modular_zubbers/sound/misc/rppanelsounds/messageleave.ogg',
		"simpleandsweet" = 'modular_zubbers/sound/misc/rppanelsounds/simpleandsweetexit.ogg',
		"delicate" = 'modular_zubbers/sound/misc/rppanelsounds/delicateexit.ogg',
		"funkyou" = 'modular_zubbers/sound/misc/rppanelsounds/funkyouexit.ogg',
		"gravitas" = 'modular_zubbers/sound/misc/rppanelsounds/gravitasexit.ogg',
		"8bitautumn" = 'modular_zubbers/sound/misc/rppanelsounds/8bitautumnexit.ogg',
	)
	var/sound_file
	var/volume
	switch(sound_type)
		if("message")
			if(!sound_message_enabled)
				return
			sound_file = message_sounds[soundpack] || message_sounds["default"]
			volume = volume_message
		if("join")
			if(!sound_join_enabled)
				return
			sound_file = join_sounds[soundpack] || join_sounds["default"]
			volume = volume_join
		if("leave")
			if(!sound_leave_enabled)
				return
			sound_file = leave_sounds[soundpack] || leave_sounds["default"]
			volume = volume_leave
		else
			return
	holder.playsound_local(get_turf(holder), sound_file, volume, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/// HTML-safe formatting for exported logs. Live TGUI formatting is client-side.
/datum/rp_panel/proc/format_scene_text(raw_text)
	if(isnull(raw_text) || raw_text == "")
		return ""
	var/encoded = newlines_to_html(html_encode("[raw_text]"))
	if(!holder)
		return encoded
	return holder.apply_message_emphasis(encoded)

/datum/rp_panel/proc/on_say(mob/living/source, list/speech_args)
	SIGNAL_HANDLER
	if(sending_message || !length(participants))
		return
	var/list/message_mods = speech_args[SPEECH_MODS] || list()
	if(message_mods[RADIO_EXTENSION])
		return
	var/message = speech_args[SPEECH_MESSAGE]
	if(!message)
		return
	var/mode = message_mods[WHISPER_MODE] ? "whisper" : "say"
	append_scene_message(build_log_entry(source, message, mode))

/datum/rp_panel/proc/on_emote(mob/living/source, datum/emote/emote, act, type_override, message, intentional)
	SIGNAL_HANDLER
	if(sending_message || !length(participants) || !intentional)
		return
	if(!istype(emote) || !(emote.key in list("me", "subtle", "subtler")))
		return
	if(!message)
		return
	append_scene_message(build_log_entry(source, message, emote.key))

/datum/rp_panel/proc/is_holder_typing()
	return holder_is_typing

/// Content-driven typing: on while the composer has text, off when empty.
/// Early-outs when unchanged, and pushes a typing-only UI patch (no full refresh).
/datum/rp_panel/proc/set_typing(is_typing)
	is_typing = !!is_typing
	if(is_typing == holder_is_typing)
		return
	holder_is_typing = is_typing
	if(is_typing)
		add_weakref_unique(typing_participants, holder)
		if(holder?.client?.typing_indicators)
			ADD_TRAIT(holder, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
			holder.remove_thinking_indicator()
			holder.create_typing_indicator()
	else
		drop_weakref(typing_participants, holder)
		holder?.remove_all_indicators()
	for(var/datum/rp_panel/panel as anything in get_linked_panels())
		if(panel != src)
			if(is_typing)
				add_weakref_unique(panel.typing_participants, holder)
			else
				drop_weakref(panel.typing_participants, holder)
		panel.push_typing_update()

/// Lightweight partial update so typing toggles do not rebuild the whole scene payload.
/datum/rp_panel/proc/push_typing_update()
	if(!LAZYLEN(open_uis))
		return
	var/list/names = build_typing_list()
	// BYOND JSON omits empty lists, which would leave a stale "X is typing" after merge.
	// null still serializes, and the UI treats non-arrays as [].
	var/list/payload = list("typing" = length(names) ? names : null)
	for(var/datum/tgui/ui as anything in open_uis)
		ui.send_update(payload, force = TRUE)

/datum/rp_panel/proc/get_preference_status(choice)
	if(!choice || choice == "No" || choice == "None")
		return "NO"
	if(findtext(choice, "Ask"))
		return "L(OOC)"
	if(findtext(choice, "Check"))
		return "NOTE"
	return "YES"

/datum/rp_panel/proc/get_target()
	if(!selected_participant || QDELETED(selected_participant) || !is_in_scene(selected_participant))
		selected_participant = holder
	if(QDELETED(holder))
		return null
	return selected_participant

/mob/living/proc/open_scene_assistant(mob/living/invite_target)
	var/mob/living/user = usr
	if(!isliving(user))
		return
	if(!user.rp_panel)
		user.rp_panel = new(user)
	user.rp_panel.ui_interact(user)
	if(isliving(invite_target) && invite_target != user)
		user.rp_panel.invite_living(invite_target)

GAME_VERB_DESC(/mob/living, scene_assistant, "Scene Assistant", "Open a shared scene writing room, or invite a nearby person.", "IC")
	open_scene_assistant(src)

GAME_VERB_CONTEXT(/mob/living, scene_assistant_invite, "Scene Assistant", "Open a shared scene writing room, or invite a nearby person.", null, /mob/living)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_VIEW, /mob/living)
	open_scene_assistant(target)

/datum/keybinding/living/scene_assistant
	hotkey_keys = list("Unbound")
	name = "scene_assistant"
	full_name = "Open Scene Assistant"
	description = "Opens your Scene Assistant writing room."
	keybind_signal = COMSIG_KB_LIVING_SCENE_ASSISTANT_DOWN

/datum/keybinding/living/scene_assistant/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/owner = user.mob
	if(!isliving(owner))
		return
	if(!owner.rp_panel)
		owner.rp_panel = new(owner)
	owner.rp_panel.ui_interact(owner)
	return TRUE
