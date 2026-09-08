#define SCENE_ASSISTANT_RANGE 2
#define SCENE_ASSISTANT_MAX_CHARS 2000

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
	var/mob/living/selected_participant
	var/emote_mode = "say"
	var/scene_details = ""
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
	var/avatar_size = 64
	var/log_font = "Verdana"
	var/log_font_size = 100
	var/log_line_spacing = 1.35

/datum/rp_panel/New(mob/living/new_holder)
	. = ..()
	holder = new_holder
	selected_participant = holder
	RegisterSignal(holder, COMSIG_MOB_SAY, PROC_REF(on_say))
	RegisterSignal(holder, COMSIG_MOB_EMOTE, PROC_REF(on_emote))
	RegisterSignal(holder, COMSIG_QDELETING, PROC_REF(on_holder_qdeleting))
	load_prefs()

/datum/rp_panel/Destroy()
	if(holder)
		UnregisterSignal(holder, list(COMSIG_MOB_SAY, COMSIG_MOB_EMOTE, COMSIG_QDELETING))
	holder = null
	selected_participant = null
	participants = null
	pending_invites = null
	messages = null
	typing_participants = null
	return ..()

/datum/rp_panel/proc/on_holder_qdeleting(datum/source)
	SIGNAL_HANDLER
	holder = null
	qdel(src)

/datum/rp_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/rp_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RpPanel", "Scene Assistant")
		ui.open()

/datum/rp_panel/proc/load_prefs()
	var/datum/preferences/prefs = holder?.client?.prefs
	if(!prefs)
		return
	show_avatars = prefs.read_preference(/datum/preference/toggle/scene_assistant_show_avatars)
	avatar_size = prefs.read_preference(/datum/preference/numeric/scene_assistant_avatar_size)
	log_font = prefs.read_preference(/datum/preference/text/scene_assistant_font)
	log_font_size = prefs.read_preference(/datum/preference/numeric/scene_assistant_font_size)
	log_line_spacing = prefs.read_preference(/datum/preference/numeric/scene_assistant_line_spacing)
	theme = prefs.read_preference(/datum/preference/choiced/scene_assistant_theme)
	soundpack = prefs.read_preference(/datum/preference/choiced/scene_assistant_soundpack)
	sound_message_enabled = prefs.read_preference(/datum/preference/toggle/scene_assistant_sound_message)
	sound_join_enabled = prefs.read_preference(/datum/preference/toggle/scene_assistant_sound_join)
	sound_leave_enabled = prefs.read_preference(/datum/preference/toggle/scene_assistant_sound_leave)
	volume_message = prefs.read_preference(/datum/preference/numeric/scene_assistant_volume_message)
	volume_join = prefs.read_preference(/datum/preference/numeric/scene_assistant_volume_join)
	volume_leave = prefs.read_preference(/datum/preference/numeric/scene_assistant_volume_leave)

/datum/rp_panel/proc/write_player_pref(pref_type, value)
	var/datum/preferences/prefs = holder?.client?.prefs
	if(!prefs)
		return
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return
	if(prefs.write_preference(preference_entry, value))
		prefs.recently_updated_keys |= preference_entry.type
		prefs.save_preferences()

/datum/rp_panel/proc/erp_enabled(mob/living/target)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return target?.client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences) && target.client.prefs.read_preference(/datum/preference/toggle/erp)

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
	var/static/list/palette = list("#6ea8fe", "#c084fc", "#fb7185", "#4ade80", "#fbbf24", "#22d3ee")
	var/seed = target?.ckey || target?.name || "unknown"
	var/index = (text2ascii(seed, 1) % length(palette)) + 1
	return palette[index]

/datum/rp_panel/proc/get_scene_members()
	var/list/members = list(holder)
	for(var/datum/weakref/participant_ref as anything in participants)
		var/mob/living/member = participant_ref.resolve()
		if(member && !QDELETED(member) && !(member in members))
			members += member
	return members

/datum/rp_panel/proc/get_linked_panels()
	var/list/panels = list(src)
	for(var/mob/living/member as anything in get_scene_members())
		if(member.rp_panel && !(member.rp_panel in panels))
			panels += member.rp_panel
	return panels

/datum/rp_panel/proc/add_weakref_unique(list/refs, mob/living/target)
	for(var/datum/weakref/ref as anything in refs)
		if(ref.resolve() == target)
			return
	refs += WEAKREF(target)

/datum/rp_panel/proc/drop_weakref(list/refs, mob/living/target)
	for(var/datum/weakref/ref as anything in refs)
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
	if(!joiner.ckey || !pending_invites[joiner.ckey])
		to_chat(joiner, span_warning("That scene invite is no longer valid."))
		return
	pending_invites -= joiner.ckey
	complete_add_participant(joiner)

/datum/rp_panel/proc/invite_living(mob/living/target)
	if(!target || QDELETED(target) || target == holder)
		return FALSE
	if(!can_invite_kind(target))
		to_chat(holder, span_warning("You cannot invite [target] to the scene."))
		return FALSE
	if(is_in_scene(target))
		to_chat(holder, span_notice("[target] is already in the scene."))
		return FALSE
	if(!in_scene_range(target))
		to_chat(holder, span_warning("[target] is too far away."))
		return FALSE
	if(!target.ckey)
		return complete_add_participant(target)
	pending_invites[target.ckey] = TRUE
	var/join_button = "<a href='byond://?src=[REF(src)];join=1'>Join</a>"
	to_chat(target, boxed_message(span_notice("You have been invited to [holder]'s Scene! [join_button]")))
	to_chat(holder, span_notice("Invited [target] to your Scene."))
	return TRUE

/datum/rp_panel/proc/complete_add_participant(mob/living/target)
	if(!target || QDELETED(target) || QDELETED(src) || QDELETED(holder) || target == holder)
		return FALSE
	if(!can_invite_kind(target) || is_in_scene(target))
		return FALSE
	if(!in_scene_range(target))
		to_chat(target, span_warning("You are too far away to join [holder]'s Scene."))
		return FALSE

	var/list/members = get_scene_members()
	if(!target.rp_panel)
		target.rp_panel = new(target)
	for(var/mob/living/member as anything in members)
		if(!member.rp_panel)
			member.rp_panel = new(member)
		add_weakref_unique(member.rp_panel.participants, target)
		add_weakref_unique(target.rp_panel.participants, member)

	target.rp_panel.messages = deep_copy_list(messages)
	target.rp_panel.scene_details = scene_details

	to_chat(holder, span_notice("[target] joined the scene."))
	to_chat(target, span_notice("You joined [holder]'s Scene."))
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
	target.rp_panel.ui_interact(target)
	return TRUE

/datum/rp_panel/proc/remove_participant(mob/living/target)
	if(!target || target == holder || !is_in_scene(target))
		return FALSE
	var/list/members = get_scene_members()
	for(var/mob/living/member as anything in members)
		if(!member.rp_panel)
			continue
		drop_weakref(member.rp_panel.participants, target)
		if(target.rp_panel)
			drop_weakref(target.rp_panel.participants, member)
		if(member.rp_panel.selected_participant == target)
			member.rp_panel.selected_participant = member
		SStgui.update_uis(member.rp_panel)
	play_sound_to_participants("leave")
	to_chat(holder, span_notice("Removed [target] from the scene."))
	to_chat(target, span_notice("[holder] removed you from the scene."))
	return TRUE

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

/datum/rp_panel/proc/append_scene_message(list/message_entry)
	for(var/datum/rp_panel/panel as anything in get_linked_panels())
		panel.messages += list(message_entry)
		SStgui.update_uis(panel)

/datum/rp_panel/proc/build_log_entry(mob/living/speaker, message, mode)
	return list(
		"name" = speaker.name,
		"message" = message,
		"headshot" = get_headshot(speaker),
		"mode" = mode,
		"timestamp" = time2text(world.timeofday, "HH:MM:SS"),
		"ref" = REF(speaker),
		"color" = get_member_color(speaker),
	)

/datum/rp_panel/proc/send_scene_message(raw_message)
	var/message = trim(copytext_char("[raw_message]", 1, SCENE_ASSISTANT_MAX_CHARS + 1))
	if(!length(message))
		return
	clear_typing()
	if(holder.client?.autopunctuation)
		message = autopunct_bare(message)
	sending_message = TRUE
	switch(emote_mode)
		if("say")
			holder.say(message)
		if("emote")
			holder.emote("me", message = message, intentional = TRUE)
		if("subtle")
			holder.emote("subtle", null, message, TRUE)
		if("subtler")
			send_subtler_message(message, 1)
		if("subtler_antighost")
			send_subtler_message(message, 0)
		else
			sending_message = FALSE
			return
	append_scene_message(build_log_entry(holder, message, emote_mode))
	play_sound_to_participants("message")
	sending_message = FALSE

/datum/rp_panel/proc/send_subtler_message(message, range)
	var/decoded = html_decode(message)
	var/space = (length(decoded) && should_have_space_before_emote(decoded[1])) ? " " : ""
	var/subtler_message = span_subtler("<b>[holder]</b>[space]<i>[holder.apply_message_emphasis(message)]</i>")
	var/list/in_view = get_hearers_in_view(range, holder)
	in_view -= GLOB.dead_mob_list
	for(var/mob/viewer as anything in in_view)
		if(!isliving(viewer) || istype(viewer, /mob/eye/camera/ai))
			continue
		if(!viewer.client && viewer != holder)
			continue
		viewer.show_message(subtler_message, alt_msg = subtler_message)
	holder.log_message(message, LOG_SUBTLER)

/datum/rp_panel/proc/play_sound_to_participants(sound_type)
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
	for(var/mob/living/member as anything in get_scene_members())
		if(member.client)
			member.playsound_local(get_turf(holder), sound_file, volume, FALSE)

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
	append_scene_message(build_log_entry(source, message, "say"))

/datum/rp_panel/proc/on_emote(mob/living/source, datum/emote/emote, act, type_override, message, intentional)
	SIGNAL_HANDLER
	if(sending_message || !length(participants) || !intentional)
		return
	if(!istype(emote) || !(emote.key in list("me", "subtle", "subtler")))
		return
	if(!message)
		return
	append_scene_message(build_log_entry(source, message, emote.key))

/datum/rp_panel/proc/set_typing(is_typing)
	if(is_typing)
		add_weakref_unique(typing_participants, holder)
		if(holder.client?.typing_indicators)
			ADD_TRAIT(holder, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
			holder.create_typing_indicator()
	else
		clear_typing()
	for(var/datum/rp_panel/panel as anything in get_linked_panels())
		if(panel != src)
			if(is_typing)
				add_weakref_unique(panel.typing_participants, holder)
			else
				drop_weakref(panel.typing_participants, holder)
		SStgui.update_uis(panel)

/datum/rp_panel/proc/clear_typing()
	drop_weakref(typing_participants, holder)
	holder.remove_typing_indicator()
	if(!holder.active_thinking_indicator)
		REMOVE_TRAIT(holder, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)

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
