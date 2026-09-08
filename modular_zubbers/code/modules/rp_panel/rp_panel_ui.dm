/datum/rp_panel/ui_static_data(mob/user)
	var/list/data = list()
	data["max_chars"] = SCENE_ASSISTANT_MAX_CHARS
	data["arousal_limit"] = AROUSAL_LIMIT
	data["themes"] = list(
		list("id" = "default", "label" = "Scene Assistant"),
		list("id" = "light", "label" = "Frost"),
		list("id" = "cream", "label" = "Cream"),
		list("id" = "strawberry", "label" = "Strawberry"),
		list("id" = "super_dark", "label" = "Super Dark"),
		list("id" = "apple", "label" = "Apple"),
		list("id" = "syndicate", "label" = "Syndicate Red"),
	)
	data["soundpacks"] = list(
		list("id" = "default", "label" = "Scene Assistant"),
		list("id" = "simpleandsweet", "label" = "Simple and Sweet"),
		list("id" = "delicate", "label" = "Delicate"),
		list("id" = "funkyou", "label" = "Funk You"),
		list("id" = "gravitas", "label" = "Gravitas"),
		list("id" = "8bitautumn", "label" = "8-Bit Autumn"),
	)
	data["avatar_sizes"] = list(
		list("id" = 32, "label" = "Small 32"),
		list("id" = 48, "label" = "Compact 48"),
		list("id" = 64, "label" = "Medium 64"),
		list("id" = 96, "label" = "Large 96"),
		list("id" = 128, "label" = "Huge 128"),
	)
	data["fonts"] = list("Verdana", "Arial", "Tahoma", "Trebuchet MS", "Times New Roman", "Courier New", "Comic Sans MS", "Georgia")
	data["font_sizes"] = list(
		list("id" = 80, "label" = "Small"),
		list("id" = 90, "label" = "Compact"),
		list("id" = 100, "label" = "Medium"),
		list("id" = 120, "label" = "Large"),
		list("id" = 150, "label" = "Very Large"),
	)
	data["line_spacings"] = list(
		list("id" = 1, "label" = "Tight"),
		list("id" = 1.2, "label" = "Snug"),
		list("id" = 1.35, "label" = "Normal"),
		list("id" = 1.6, "label" = "Loose"),
		list("id" = 2, "label" = "Very Loose"),
	)
	return data

/datum/rp_panel/ui_data(mob/user)
	queue_range_check()
	if(QDELETED(holder))
		return list()
	if(!(emote_mode in list("say", "whisper", "emote", "subtle", "subtler", "subtler_antighost")))
		emote_mode = "say"

	var/list/data = list()
	data["emote_mode"] = emote_mode
	data["emote_modes"] = list(
		list("id" = "say", "label" = "say"),
		list("id" = "whisper", "label" = "whisper"),
		list("id" = "emote", "label" = "emote"),
		list("id" = "subtle", "label" = "subtle"),
		list("id" = "subtler", "label" = "subtler"),
		list("id" = "subtler_antighost", "label" = "subtler anti-ghost"),
	)
	data["scene_details"] = scene_details
	data["draft"] = draft_text
	// Raw messages — TGUI escapes/formats so quotes don't become visible &#34; entities.
	data["messages"] = messages
	data["participants"] = build_participant_list()
	data["nearby"] = build_nearby_list()
	data["typing"] = build_typing_list()
	var/mob/living/current_target = get_target()
	data["selected_ref"] = current_target ? REF(current_target) : ""
	data["target"] = build_target_data()
	data["self"] = build_self_data()
	data["settings"] = list(
		"theme" = theme,
		"soundpack" = soundpack,
		"sound_message" = sound_message_enabled,
		"sound_join" = sound_join_enabled,
		"sound_leave" = sound_leave_enabled,
		"volume_message" = volume_message,
		"volume_join" = volume_join,
		"volume_leave" = volume_leave,
		"show_avatars" = show_avatars,
		"show_images" = show_images,
		"avatar_size" = avatar_size,
		"font" = log_font,
		"font_size" = log_font_size,
		"line_spacing" = log_line_spacing,
		"name_color" = name_color,
	)
	return data

/datum/rp_panel/proc/queue_range_check()
	if(range_check_queued || QDELETED(src))
		return
	range_check_queued = TRUE
	addtimer(CALLBACK(src, PROC_REF(run_queued_range_check)), 1)

/datum/rp_panel/proc/run_queued_range_check()
	range_check_queued = FALSE
	if(QDELETED(src))
		return
	check_and_remove_out_of_range()

/datum/rp_panel/proc/build_formatted_messages()
	// Kept for HTML export. The live TGUI log formats client-side.
	if(!formatted_messages_dirty && cached_formatted_messages)
		return cached_formatted_messages
	var/list/formatted = list()
	for(var/list/entry as anything in messages)
		var/list/copy = entry.Copy()
		copy["message"] = format_scene_text(entry["message"])
		formatted += list(copy)
	cached_formatted_messages = formatted
	formatted_messages_dirty = FALSE
	return formatted

/datum/rp_panel/proc/build_person_entry(mob/living/person, is_you = FALSE)
	if(!person || QDELETED(person))
		return list(
			"name" = "Unknown",
			"ref" = "",
			"headshot" = "",
			"color" = "#c084fc",
			"is_you" = is_you,
		)
	return list(
		"name" = person.name,
		"ref" = REF(person),
		"headshot" = get_headshot(person),
		"color" = get_member_color(person),
		"is_you" = is_you,
	)

/datum/rp_panel/proc/build_participant_list()
	if(cached_participants)
		return cached_participants
	var/list/result = list()
	for(var/mob/living/member as anything in get_scene_members())
		result += list(build_person_entry(member, member == holder))
	cached_participants = result
	return result

/datum/rp_panel/proc/build_nearby_list()
	if(cached_nearby && world.time < cached_nearby_at + SCENE_ASSISTANT_NEARBY_CACHE)
		return cached_nearby
	var/list/result = list()
	if(!holder || QDELETED(holder))
		cached_nearby = result
		cached_nearby_at = world.time
		return result
	var/is_admin = !!holder.client?.holder
	for(var/mob/living/nearby in view(SCENE_ASSISTANT_RANGE, holder))
		if(nearby == holder || !can_invite_kind(nearby) || is_in_scene(nearby))
			continue
		if(nearby.stat == DEAD)
			continue
		if(!nearby.client && !is_admin)
			continue
		result += list(build_person_entry(nearby))
	cached_nearby = result
	cached_nearby_at = world.time
	return result

/datum/rp_panel/proc/build_typing_list()
	var/list/names = list()
	for(var/datum/weakref/typing_ref as anything in typing_participants)
		var/mob/living/typer = typing_ref.resolve()
		if(!typer || QDELETED(typer))
			typing_participants -= typing_ref
			continue
		// Drop stale entries if their own panel is no longer flagged as typing.
		if(typer.rp_panel && !typer.rp_panel.holder_is_typing)
			typing_participants -= typing_ref
			continue
		names += typer.name
	return names

/datum/rp_panel/proc/build_target_data()
	var/mob/living/target = get_target()
	if(!target)
		return list(
			"name" = "",
			"ref" = "",
			"headshot" = "",
			"is_self" = FALSE,
			"details" = list(),
			"tags" = list(),
			"has_reference" = FALSE,
			"show_erp" = FALSE,
			"block_interact" = FALSE,
			"categories" = list(),
			"interactions" = list(),
			"descriptions" = list(),
			"colors" = list(),
			"lewd_slots" = list(),
		)
	var/list/data = list(
		"name" = target.name,
		"ref" = REF(target),
		"headshot" = get_headshot(target),
		"is_self" = (target == holder),
		"details" = build_anatomy_details(target),
		"tags" = build_status_tags(target),
		"has_reference" = FALSE,
		"show_erp" = FALSE,
		"block_interact" = FALSE,
		"categories" = list(),
		"interactions" = list(),
		"descriptions" = list(),
		"colors" = list(),
		"lewd_slots" = list(),
	)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		data["has_reference"] = !!length(human_target.dna?.features["art_ref"])
	var/allow_lewd = ishuman(target) && ishuman(holder) && erp_content_enabled(holder) && (target == holder || erp_content_enabled(target))
	data["show_erp"] = allow_lewd
	if(allow_lewd)
		var/mob/living/carbon/human/human_holder = holder
		data["your_name"] = holder.name
		data["pleasure"] = human_holder.pleasure
		data["arousal"] = human_holder.arousal
		data["pain"] = human_holder.pain
		if(target != holder && ishuman(target))
			var/mob/living/carbon/human/human_target = target
			data["their_name"] = target.name
			data["their_pleasure"] = human_target.pleasure
			data["their_arousal"] = human_target.arousal
			data["their_pain"] = human_target.pain
	if(ishuman(target) && ishuman(holder))
		var/list/verb_data = get_cached_interaction_data(target, allow_lewd)
		for(var/key in verb_data)
			data[key] = verb_data[key]
	return data

/datum/rp_panel/proc/invalidate_interaction_cache()
	cached_interaction_ref = null
	cached_interaction_lewd = null
	cached_interaction_at = 0
	cached_interaction_data = null

/datum/rp_panel/proc/get_cached_interaction_data(mob/living/target, allow_lewd = FALSE)
	var/target_ref = REF(target)
	if(cached_interaction_data && cached_interaction_ref == target_ref && cached_interaction_lewd == allow_lewd && world.time < cached_interaction_at + SCENE_ASSISTANT_INTERACTION_CACHE)
		var/list/cached = cached_interaction_data.Copy()
		var/datum/component/interactable/interaction_component = target.GetComponent(/datum/component/interactable)
		cached["block_interact"] = interaction_component ? (interaction_component.interact_next >= world.time) : FALSE
		return cached
	var/list/verb_data = build_interaction_data(target, allow_lewd)
	cached_interaction_ref = target_ref
	cached_interaction_lewd = allow_lewd
	cached_interaction_at = world.time
	cached_interaction_data = verb_data
	return verb_data

/datum/rp_panel/proc/build_anatomy_details(mob/living/target)
	var/list/details = list()
	if(!ishuman(target))
		return details
	var/mob/living/carbon/human/human_target = target
	if(human_target.has_arms(REQUIRE_GENITAL_ANY) > 0)
		details += human_target.is_hands_uncovered() ? "has covered hands" : "has uncovered hands"
	if(human_target.has_feet(REQUIRE_GENITAL_ANY) > 0)
		if(human_target.is_barefoot() && (!human_target.socks || human_target.socks == "Nude" || (human_target.underwear_visibility & UNDERWEAR_HIDE_SOCKS)))
			details += "is barefoot"
		else if(human_target.is_barefoot())
			details += "is wearing socks"
		else
			details += "has feet covered"
	var/obj/item/bodypart/head/head_part = human_target.get_bodypart(BODY_ZONE_HEAD)
	if(head_part)
		var/mouth_covered = (human_target.wear_mask?.flags_inv & HIDEFACE) || (human_target.head?.flags_inv & HIDEFACE)
		details += mouth_covered ? "has a mouth, which is covered" : "has a mouth, which is uncovered"
	details += human_target.is_head_uncovered() ? "has head covered" : "has head uncovered"
	if(human_target.is_topless() && human_target.is_bottomless())
		details += "is naked"
	else if(human_target.is_topless())
		details += "is topless"
	else if(human_target.is_bottomless())
		details += "is bottomless"
	var/static/list/genital_lines = list(
		ORGAN_SLOT_PENIS = "has a penis",
		ORGAN_SLOT_TESTICLES = "has testicles",
		ORGAN_SLOT_VAGINA = "has a vagina",
		ORGAN_SLOT_BREASTS = "has breasts",
		ORGAN_SLOT_ANUS = "has an anus",
	)
	for(var/slot in genital_lines)
		var/obj/item/organ/genital/genital = human_target.get_organ_slot(slot)
		if(istype(genital) && genital.is_exposed())
			details += genital_lines[slot]
	return details

/datum/rp_panel/proc/build_status_tags(mob/living/target)
	var/list/tags = list()
	if(!target.client?.prefs)
		return tags
	tags += list(list("label" = "ERP", "value" = get_preference_status(read_mob_character_pref(target, /datum/preference/choiced/erp_status))))
	tags += list(list("label" = "HYPNOSIS", "value" = get_preference_status(read_mob_character_pref(target, /datum/preference/choiced/erp_status_hypno))))
	tags += list(list("label" = "VORE", "value" = get_preference_status(read_mob_character_pref(target, /datum/preference/choiced/erp_status_v))))
	tags += list(list("label" = "NON-CON", "value" = get_preference_status(read_mob_character_pref(target, /datum/preference/choiced/erp_status_nc))))
	var/mechanics = read_mob_character_pref(target, /datum/preference/choiced/erp_status_mechanics)
	tags += list(list("label" = "MECHANICS", "value" = (!mechanics || mechanics == "None") ? "NO" : uppertext(mechanics)))
	return tags

/datum/rp_panel/proc/build_interaction_data(mob/living/target, allow_lewd = FALSE)
	var/list/data = list(
		"categories" = list(),
		"interactions" = list(),
		"descriptions" = list(),
		"colors" = list(),
		"lewd_slots" = list(),
		"block_interact" = FALSE,
	)
	if(!ishuman(target) || !ishuman(holder))
		return data
	var/datum/component/interactable/interaction_component = target.GetComponent(/datum/component/interactable)
	if(!interaction_component)
		return data
	data["block_interact"] = interaction_component.interact_next >= world.time
	var/list/categories = list()
	var/list/descriptions = list()
	var/list/colors = list()
	for(var/interaction_id in GLOB.interaction_instances)
		var/datum/interaction/interaction = GLOB.interaction_instances[interaction_id]
		if(interaction.lewd && !allow_lewd)
			continue
		if(!interaction_component.can_interact(interaction, holder))
			continue
		if(!categories[interaction.category])
			categories[interaction.category] = list(interaction.name)
		else
			categories[interaction.category] += interaction.name
			categories[interaction.category] = sort_list(categories[interaction.category])
		descriptions[interaction.name] = interaction.description
		colors[interaction.name] = interaction.color
	var/list/display_categories = list()
	for(var/category in categories)
		display_categories += category
	data["categories"] = sort_list(display_categories)
	data["interactions"] = categories
	data["descriptions"] = descriptions
	data["colors"] = colors

	if(!allow_lewd)
		return data
	var/mob/living/carbon/human/human_holder = holder
	var/mob/living/carbon/human/human_target = target
	if(interaction_component.can_lewd_strip(human_holder, human_target) && human_target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		var/list/slots = list()
		if(human_target.has_vagina())
			slots += list(interaction_component.generate_strip_entry(ORGAN_SLOT_VAGINA, human_target, human_holder, human_target.vagina))
		if(human_target.has_penis())
			slots += list(interaction_component.generate_strip_entry(ORGAN_SLOT_PENIS, human_target, human_holder, human_target.penis))
		if(human_target.has_anus())
			slots += list(interaction_component.generate_strip_entry(ORGAN_SLOT_ANUS, human_target, human_holder, human_target.anus))
		slots += list(interaction_component.generate_strip_entry(ORGAN_SLOT_NIPPLES, human_target, human_holder, human_target.nipples))
		data["lewd_slots"] = slots
	return data

/datum/rp_panel/proc/build_self_data()
	var/list/data = list(
		"show_erp" = erp_enabled(holder),
		"autocum" = FALSE,
		"prefs" = list(),
		"genitals" = list(),
		"underwear" = list(),
	)
	if(!ishuman(holder))
		return data
	var/mob/living/carbon/human/human_holder = holder
	data["underwear"] = list(
		"underwear" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_UNDIES),
		"bra" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_BRA),
		"undershirt" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_SHIRT),
		"socks" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_SOCKS),
	)
	if(!data["show_erp"] || !holder.client?.prefs)
		return data
	data["autocum"] = holder.client.prefs.read_preference(/datum/preference/toggle/erp/autocum)
	var/static/list/pref_map = list(
		"erp_status" = /datum/preference/choiced/erp_status,
		"erp_status_nc" = /datum/preference/choiced/erp_status_nc,
		"erp_status_v" = /datum/preference/choiced/erp_status_v,
		"erp_status_hypno" = /datum/preference/choiced/erp_status_hypno,
		"erp_status_mechanics" = /datum/preference/choiced/erp_status_mechanics,
	)
	var/list/pref_payload = list()
	for(var/key in pref_map)
		var/datum/preference/choiced/pref = GLOB.preference_entries[pref_map[key]]
		pref_payload[key] = list(
			"value" = read_mob_character_pref(holder, pref_map[key]),
			"options" = pref.get_choices(),
		)
	data["prefs"] = pref_payload
	var/static/list/genital_slots = list(
		ORGAN_SLOT_PENIS = "Penis",
		ORGAN_SLOT_TESTICLES = "Testicles",
		ORGAN_SLOT_VAGINA = "Vagina",
		ORGAN_SLOT_ANUS = "Anus",
		ORGAN_SLOT_BREASTS = "Breasts",
	)
	var/list/genitals = list()
	for(var/slot in genital_slots)
		var/obj/item/organ/genital/genital = human_holder.get_organ_slot(slot)
		if(!istype(genital) || genital.visibility_preference == GENITAL_SKIP_VISIBILITY)
			continue
		genitals += list(list(
			"slot" = slot,
			"name" = genital_slots[slot],
			"visibility" = genital.visibility_preference,
		))
	data["genitals"] = genitals
	return data

/datum/rp_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(usr != holder)
		return FALSE
	switch(action)
		if("send_message")
			send_scene_message(params["message"])
			return TRUE
		if("send_image")
			send_scene_image(params["url"], params["caption"])
			return TRUE
		if("open_image")
			open_scene_image(params["url"])
			return TRUE
		if("set_emote_mode")
			if(!(params["mode"] in list("say", "whisper", "emote", "subtle", "subtler", "subtler_antighost")))
				return FALSE
			if(emote_mode == params["mode"])
				return FALSE
			emote_mode = params["mode"]
			return TRUE
		if("set_scene_details")
			var/new_details = copytext_char("[params["details"]]", 1, SCENE_ASSISTANT_MAX_CHARS + 1)
			if(scene_details == new_details)
				return FALSE
			scene_details = new_details
			for(var/datum/rp_panel/panel as anything in get_linked_panels())
				panel.scene_details = scene_details
				SStgui.update_uis(panel)
			return TRUE
		if("set_selected")
			var/mob/living/picked = locate(params["ref"])
			var/mob/living/next_target = (picked && is_in_scene(picked)) ? picked : holder
			if(selected_participant == next_target)
				return FALSE
			selected_participant = next_target
			invalidate_interaction_cache()
			return TRUE
		if("set_typing")
			set_typing(!!text2num(params["typing"]))
			return FALSE // set_typing pushes a typing-only patch itself
		if("set_draft")
			draft_text = copytext_char("[params["text"]]", 1, SCENE_ASSISTANT_MAX_CHARS + 1)
			return FALSE // store only; reconnect reads it from ui_data
		if("invite_participant")
			invite_living(locate(params["ref"]))
			return TRUE
		if("remove_participant")
			remove_participant(locate(params["ref"]))
			return TRUE
		if("leave_scene")
			leave_scene()
			return TRUE
		if("open_examine")
			open_examine(locate(params["ref"]) || get_target())
			return TRUE
		if("open_reference")
			open_reference(get_target())
			return TRUE
		if("trigger_interaction")
			run_interaction(params["interaction"])
			return TRUE
		if("remove_lewd_item")
			remove_lewd_item(params["item_slot"])
			return TRUE
		if("set_self_preference")
			set_self_preference(params["pref_type"], params["pref_value"])
			return TRUE
		if("set_genital_visibility")
			set_genital_visibility(params["slot"], text2num(params["visibility"]))
			return TRUE
		if("toggle_underwear")
			toggle_underwear(params["kind"])
			return TRUE
		if("toggle_autocum")
			if(erp_content_enabled(holder))
				toggle_autocum()
			return TRUE
		if("trigger_climax")
			if(erp_content_enabled(holder) && ishuman(holder))
				var/mob/living/carbon/human/human_holder = holder
				human_holder.climax(manual = TRUE)
			return TRUE
		if("set_theme")
			if(params["theme"] in list("default", "light", "cream", "strawberry", "super_dark", "apple", "syndicate"))
				theme = params["theme"]
				write_player_pref(/datum/preference/choiced/scene_assistant_theme, theme)
			return TRUE
		if("set_soundpack")
			if(params["soundpack"] in list("default", "simpleandsweet", "delicate", "funkyou", "gravitas", "8bitautumn"))
				soundpack = params["soundpack"]
				write_player_pref(/datum/preference/choiced/scene_assistant_soundpack, soundpack)
			return TRUE
		if("toggle_sound")
			switch(params["kind"])
				if("message")
					sound_message_enabled = !sound_message_enabled
					write_player_pref(/datum/preference/toggle/scene_assistant_sound_message, sound_message_enabled)
				if("join")
					sound_join_enabled = !sound_join_enabled
					write_player_pref(/datum/preference/toggle/scene_assistant_sound_join, sound_join_enabled)
				if("leave")
					sound_leave_enabled = !sound_leave_enabled
					write_player_pref(/datum/preference/toggle/scene_assistant_sound_leave, sound_leave_enabled)
			return TRUE
		if("set_volume")
			var/new_volume = text2num(params["volume"])
			if(!isnum(new_volume))
				return TRUE
			new_volume = clamp(new_volume, 0, 100)
			switch(params["kind"])
				if("message")
					volume_message = new_volume
					write_player_pref(/datum/preference/numeric/scene_assistant_volume_message, volume_message)
				if("join")
					volume_join = new_volume
					write_player_pref(/datum/preference/numeric/scene_assistant_volume_join, volume_join)
				if("leave")
					volume_leave = new_volume
					write_player_pref(/datum/preference/numeric/scene_assistant_volume_leave, volume_leave)
			return TRUE
		if("toggle_avatars")
			show_avatars = !show_avatars
			write_player_pref(/datum/preference/toggle/scene_assistant_show_avatars, show_avatars)
			return TRUE
		if("toggle_images")
			show_images = !show_images
			write_player_pref(/datum/preference/toggle/scene_assistant_show_images, show_images)
			return TRUE
		if("set_avatar_size")
			var/new_size = text2num(params["size"])
			if(new_size in list(32, 48, 64, 96, 128))
				avatar_size = new_size
				write_player_pref(/datum/preference/numeric/scene_assistant_avatar_size, avatar_size)
			return TRUE
		if("set_font")
			log_font = sanitize_scene_assistant_font(params["font"])
			write_player_pref(/datum/preference/text/scene_assistant_font, log_font)
			return TRUE
		if("set_font_size")
			var/new_font_size = text2num(params["size"])
			if(!isnum(new_font_size))
				return TRUE
			log_font_size = clamp(new_font_size, 80, 150)
			write_player_pref(/datum/preference/numeric/scene_assistant_font_size, log_font_size)
			return TRUE
		if("set_line_spacing")
			var/new_spacing = text2num(params["spacing"])
			if(!isnum(new_spacing))
				return TRUE
			log_line_spacing = clamp(new_spacing, 1, 2)
			write_player_pref(/datum/preference/numeric/scene_assistant_line_spacing, log_line_spacing)
			return TRUE
		if("pick_name_color")
			var/chosen = tgui_color_picker(usr, "Choose your name color in Scene Assistant.", "Name Color", name_color)
			if(QDELETED(src) || usr != holder)
				return TRUE
			if(chosen)
				apply_name_color(chosen)
			return TRUE
		if("set_name_color")
			apply_name_color(params["color"])
			return TRUE
		if("export_log")
			export_log()
			return TRUE
		if("clear_log")
			clear_scene_log()
			return TRUE

/datum/rp_panel/proc/open_examine(mob/living/target)
	if(!target || QDELETED(target))
		return
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if(human_target.tgui)
			human_target.tgui.holder = human_target
			human_target.tgui.ui_interact(holder)
			return
	else if(issilicon(target))
		var/mob/living/silicon/silicon_target = target
		if(silicon_target.examine_panel)
			silicon_target.examine_panel.holder = silicon_target
			silicon_target.examine_panel.ui_interact(holder)
			return
	holder.run_examinate(target)

/datum/rp_panel/proc/open_reference(mob/living/target)
	if(!ishuman(target))
		to_chat(holder, span_warning("[target] doesn't have a reference image set."))
		return
	var/mob/living/carbon/human/human_target = target
	var/reference_url = human_target.dna?.features["art_ref"] || ""
	if(copytext(reference_url, 1, 9) != "https://")
		to_chat(holder, span_warning("[target] doesn't have a reference image set."))
		return
	holder << browse("<html><body style='margin:0;background:#111;text-align:center'><img src='[html_encode(reference_url)]' style='max-width:100%'></body></html>", "window=scene_assistant_ref;size=800x600")

/datum/rp_panel/proc/open_scene_image(raw_url)
	var/image_url = sanitize_scene_image_url(raw_url)
	if(!image_url)
		return
	holder << browse("<html><body style='margin:0;background:#111;text-align:center'><img src='[html_encode(image_url)]' style='max-width:100%'></body></html>", "window=scene_assistant_img;size=800x800")

/datum/rp_panel/proc/run_interaction(interaction_name)
	if(holder_cannot_emote())
		notify_cannot_act("interact")
		return
	var/mob/living/target = get_target()
	if(!ishuman(target) || !ishuman(holder) || !interaction_name)
		return
	var/datum/component/interactable/interaction_component = target.GetComponent(/datum/component/interactable)
	var/datum/interaction/found_interaction = GLOB.interaction_instances[interaction_name]
	if(!interaction_component || !found_interaction)
		return
	if(found_interaction.lewd && (!erp_content_enabled(holder) || !erp_content_enabled(target)))
		return
	if(!interaction_component.can_interact(found_interaction, holder))
		to_chat(holder, span_warning("You cannot perform '[interaction_name]' on [target]."))
		return
	var/interaction_message = ""
	if(length(found_interaction.message))
		var/msg = pick(found_interaction.message)
		if(interaction_component.body_relay && !can_see(holder, target))
			msg = replacetext(msg, "%TARGET%", "\the [interaction_component.body_relay.name]")
		interaction_message = trim(replacetext(replacetext(msg, "%TARGET%", "[target]"), "%USER%", ""), INTERACTION_MAX_CHAR)
	begin_sending_message()
	if(interaction_component.body_relay && !can_see(holder, target))
		found_interaction.act(holder, target, interaction_component.body_relay)
	else
		found_interaction.act(holder, target)
	end_sending_message()
	var/datum/component/interactable/holder_component = holder.GetComponent(/datum/component/interactable)
	if(holder_component)
		holder_component.interact_last = world.time
		interaction_component.interact_next = holder_component.interact_last + INTERACTION_COOLDOWN
		holder_component.interact_next = interaction_component.interact_next
	if(length(interaction_message))
		append_scene_message(build_log_entry(holder, interaction_message, found_interaction.lewd ? "subtle" : "emote"))
	play_sound_to_participants("message")
	invalidate_interaction_cache()

/datum/rp_panel/proc/remove_lewd_item(item_slot)
	if(holder_cannot_emote())
		notify_cannot_act("interact")
		return
	var/mob/living/target = get_target()
	if(!ishuman(target) || !ishuman(holder) || !item_slot)
		return
	if(!erp_content_enabled(holder) || (target != holder && !erp_content_enabled(target)))
		return
	var/datum/component/interactable/interaction_component = target.GetComponent(/datum/component/interactable)
	if(!interaction_component)
		return
	var/mob/living/carbon/human/source = holder
	var/mob/living/carbon/human/human_target = target
	var/obj/item/clothing/sextoy/new_item = source.get_active_held_item()
	var/obj/item/clothing/sextoy/existing_item = human_target.vars[item_slot]
	if(!existing_item && !new_item)
		source.show_message(span_warning("No item to insert or remove!"))
		return
	if(!existing_item && !istype(new_item))
		source.show_message(span_warning("The item you're holding is not a toy!"))
		return
	if(!interaction_component.can_lewd_strip(source, human_target, item_slot) || !interaction_component.is_toy_compatible(new_item, item_slot))
		source.show_message(span_warning("Failed to adjust [human_target.name]'s toys!"))
		return
	var/internal = (item_slot in list(ORGAN_SLOT_VAGINA, ORGAN_SLOT_ANUS))
	var/insert_or_attach = internal ? "insert" : "attach"
	var/into_or_onto = internal ? "into" : "onto"
	if(existing_item)
		source.visible_message(span_purple("[source.name] starts trying to remove something from [human_target.name]'s [item_slot]."), span_purple("You start to remove [existing_item.name] from [human_target.name]'s [item_slot]."), span_purple("You hear someone trying to remove something from someone nearby."), vision_distance = 1, ignored_mobs = list(human_target))
	else if(new_item)
		source.visible_message(span_purple("[source.name] starts trying to [insert_or_attach] the [new_item.name] [into_or_onto] [human_target.name]'s [item_slot]."), span_purple("You start to [insert_or_attach] the [new_item.name] [into_or_onto] [human_target.name]'s [item_slot]."), span_purple("You hear someone trying to [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1, ignored_mobs = list(human_target))
	if(source != human_target)
		human_target.show_message(span_warning("[source.name] is trying to [existing_item ? "remove the [existing_item.name] [internal ? "in" : "on"]" : new_item ? "is trying to [insert_or_attach] the [new_item.name] [into_or_onto]" : span_alert("What the fuck, impossible condition? rp_panel_ui.dm!")] your [item_slot]!"))
	if(!do_after(source, 5 SECONDS, human_target, interaction_key = "interaction_[item_slot]") || !interaction_component.can_lewd_strip(source, human_target, item_slot))
		return
	if(existing_item)
		source.visible_message(span_purple("[source.name] removes [existing_item.name] from [human_target.name]'s [item_slot]."), span_purple("You remove [existing_item.name] from [human_target.name]'s [item_slot]."), span_purple("You hear someone remove something from someone nearby."), vision_distance = 1)
		human_target.dropItemToGround(existing_item, force = TRUE)
		human_target.vars[item_slot] = null
	else if(new_item)
		source.visible_message(span_purple("[source.name] [internal ? "inserts" : "attaches"] the [new_item.name] [into_or_onto] [human_target.name]'s [item_slot]."), span_purple("You [insert_or_attach] the [new_item.name] [into_or_onto] [human_target.name]'s [item_slot]."), span_purple("You hear someone [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1)
		human_target.vars[item_slot] = new_item
		new_item.forceMove(human_target)
		new_item.lewd_equipped(human_target, item_slot)
	human_target.update_inv_lewd()
	invalidate_interaction_cache()

/datum/rp_panel/proc/set_self_preference(pref_type, pref_value)
	if(!holder.client?.prefs || !pref_type || isnull(pref_value) || !erp_enabled(holder))
		return
	var/static/list/pref_map = list(
		"erp_status" = /datum/preference/choiced/erp_status,
		"erp_status_nc" = /datum/preference/choiced/erp_status_nc,
		"erp_status_v" = /datum/preference/choiced/erp_status_v,
		"erp_status_hypno" = /datum/preference/choiced/erp_status_hypno,
		"erp_status_mechanics" = /datum/preference/choiced/erp_status_mechanics,
	)
	var/pref_path = pref_map[pref_type]
	if(!pref_path)
		return
	write_mob_character_pref(holder, pref_path, pref_value)

/datum/rp_panel/proc/set_genital_visibility(organ_slot, visibility)
	if(!ishuman(holder) || !organ_slot)
		return
	if(!(visibility in list(GENITAL_NEVER_SHOW, GENITAL_HIDDEN_BY_CLOTHES, GENITAL_ALWAYS_SHOW)))
		return
	var/mob/living/carbon/human/human_holder = holder
	var/obj/item/organ/genital/genital = human_holder.get_organ_slot(organ_slot)
	if(!genital)
		return
	genital.visibility_preference = visibility
	human_holder.update_body()
	SEND_SIGNAL(human_holder, COMSIG_HUMAN_TOGGLE_GENITALS)

/datum/rp_panel/proc/toggle_underwear(kind)
	if(!ishuman(holder))
		return
	var/mob/living/carbon/human/human_holder = holder
	switch(kind)
		if("underwear")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
		if("bra")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_BRA
		if("undershirt")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
		if("socks")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
		else
			return
	human_holder.update_body()
	SEND_SIGNAL(human_holder, COMSIG_HUMAN_TOGGLE_UNDERWEAR, kind)

/datum/rp_panel/proc/toggle_autocum()
	if(!ishuman(holder) || !holder.client?.prefs || !erp_enabled(holder))
		return
	var/datum/preferences/prefs = holder.client.prefs
	var/datum/preference/toggle/erp/autocum/autocum_pref = GLOB.preference_entries[/datum/preference/toggle/erp/autocum]
	var/new_value = !prefs.read_preference(/datum/preference/toggle/erp/autocum)
	if(prefs.write_preference(autocum_pref, new_value))
		prefs.recently_updated_keys |= autocum_pref.type
		autocum_pref.apply_to_client_updated(holder.client, new_value)
		prefs.save_preferences()

/datum/rp_panel/proc/clear_scene_log()
	messages = list()
	invalidate_formatted_log()
	SStgui.update_uis(src)

/datum/rp_panel/proc/export_log()
	var/static/list/mode_classes = list(
		"say" = "say",
		"whisper" = "whisper",
		"emote" = "emote",
		"subtle" = "subtle",
		"subtler" = "subtle",
		"subtler_antighost" = "subtle",
		"system" = "system",
	)
	var/list/lines = list({"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Scene Assistant Log</title>
<style>
body {
	margin: 0;
	padding: 20px 24px 32px;
	background: #161822;
	color: #e8e6ef;
	font-family: Verdana, Geneva, sans-serif;
	font-size: 14px;
	line-height: 1.45;
}
h1 {
	margin: 0 0 4px;
	font-size: 20px;
	font-weight: normal;
	color: #c4b5fd;
	letter-spacing: 0.03em;
}
.subtitle {
	margin: 0 0 18px;
	color: #94a3b8;
	font-size: 12px;
}
.details {
	background: #1f2330;
	border-left: 3px solid #a78bfa;
	padding: 10px 14px;
	margin-bottom: 18px;
	color: #ddd6fe;
}
.entry {
	margin: 0 0 10px;
	padding: 8px 12px;
	background: #1c1f2b;
	border-left: 3px solid #64748b;
}
.say { border-left-color: #6ea8fe; }
.whisper { border-left-color: #94a3b8; font-style: italic; }
.emote { border-left-color: #c084fc; }
.subtle { border-left-color: #a78bfa; }
.system { border-left-color: #c084fc; color: #e9d5ff; font-style: italic; }
.name {
	font-weight: bold;
}
.meta {
	color: #7c8499;
	font-size: 11px;
	margin-left: 8px;
}
.msg {
	margin-top: 4px;
}
img {
	display: block;
	max-width: 100%;
	max-height: 360px;
	margin-top: 8px;
	border-radius: 4px;
}
.empty {
	color: #7c8499;
	font-style: italic;
}
</style>
</head>
<body>
<h1>Scene Assistant</h1>
"})
	lines += "<p class='subtitle'>Exported [time2text(world.timeofday, "YYYY-MM-DD HH:MM:SS")]</p>"
	if(length(scene_details))
		lines += "<div class='details'><b>Scene details</b><div class='msg'>[format_scene_text(scene_details)]</div></div>"
	if(!length(messages))
		lines += "<p class='empty'>No messages.</p>"
	for(var/list/entry as anything in messages)
		var/mode = "[entry["mode"]]"
		var/css_class = mode_classes[mode] || "emote"
		var/body = format_scene_text(entry["message"])
		if((mode == "say" || mode == "whisper") && copytext("[entry["message"]]", 1, 2) != "\"")
			body = "\"[body]\""
		lines += "<div class='entry [css_class]'>"
		if(mode == "system")
			lines += "<div class='msg'>[body]</div>"
		else
			lines += "<div><span class='name' style='color:[html_encode("[entry["color"]]")]'>[html_encode(entry["name"])]</span><span class='meta'>[html_encode(mode)] · [html_encode("[entry["timestamp"]]")]</span></div>"
			if(length("[entry["message"]]"))
				lines += "<div class='msg'>[body]</div>"
		if(entry["image"])
			lines += "<img src='[html_encode(entry["image"])]'>"
		lines += "</div>"
	lines += "</body></html>"
	holder << browse(jointext(lines, ""), "window=scene_assistant_export;size=760x620")

#undef SCENE_ASSISTANT_RANGE
#undef SCENE_ASSISTANT_MAX_CHARS
#undef SCENE_ASSISTANT_MAX_LOG
#undef SCENE_ASSISTANT_INVITE_TIMEOUT
#undef SCENE_ASSISTANT_RANGE_CHECK_INTERVAL
#undef SCENE_ASSISTANT_INTERACTION_CACHE
#undef SCENE_ASSISTANT_NEARBY_CACHE
