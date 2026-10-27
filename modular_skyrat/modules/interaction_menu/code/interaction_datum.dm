
GLOBAL_LIST_EMPTY_TYPED(interaction_instances, /datum/interaction)

/// Returns a purple-to-pink gradient span based on intensity (0-100). Kept short so it can be reused.
/proc/lewd_gradient_span(text, intensity)
	intensity = clamp(intensity, 0, 100)
	var/red = round(106 + (255 - 106) * (intensity / 100))
	var/green = round(13 + (182 - 13) * (intensity / 100))
	var/blue = round(173 + (193 - 173) * (intensity / 100))
	return "<span style='color:rgb([red],[green],[blue])'>[text]</span>"

/datum/interaction
	/// The name to be displayed in the interaction menu for this interaction
	var/name = "broken interaction"
	/// The description of the interacton.
	var/description = "broken"
	/// If it can be done at a distance.
	var/distance_allowed = FALSE
	/// A list of possible messages displayed loaded by the JSON.
	var/list/message = list()
	/// A list of possible messages displayed directly to the USER.
	var/list/user_messages = list()
	/// A list of possible messages displayed directly to the TARGET.
	var/list/target_messages = list()
	/// Arousal-scaled message pools. These are used before the base pools when lewd and the
	/// participant arousal is in the matching range.
	var/list/message_low = list()
	var/list/message_medium = list()
	var/list/message_high = list()
	var/list/user_messages_low = list()
	var/list/user_messages_medium = list()
	var/list/user_messages_high = list()
	var/list/target_messages_low = list()
	var/list/target_messages_medium = list()
	var/list/target_messages_high = list()
	/// What category this interaction will fall under in the menu.
	var/category = INTERACTION_CAT_HIDE
	/// Defines how we interact with ourselves or others.
	var/usage = INTERACTION_OTHER
	/// Does this interaction play a sound?
	var/sound_use = FALSE
	/// If it plays a sound, how far does it travel?
	var/sound_range = 1
	/// Stores the sound for later.
	var/sound_cache = null
	/// Is this lewd?
	var/lewd = FALSE
	/// What parts do WE need(IMPORTANT TO GET IT TO THE CORRECT DEFINE, ORGAN SLOT)?
	var/list/user_required_parts = list()
	/// What parts do they need(IMPORTANT TO GET IT TO THE CORRECT DEFINE, ORGAN SLOT)?
	var/list/target_required_parts = list()
	/// The amount of pleasure the target receives from this interaciton.
	var/target_pleasure = 0
	/// The amount of arousal the target receives from this interaction.
	var/target_arousal = 0
	/// The amount of pain the target receives.
	var/target_pain = 0
	/// The amount of pleasure the user receives.
	var/user_pleasure = 0
	/// The amount of arousal the user receives.
	var/user_arousal = 0
	/// The amount of pain the user receives.
	var/user_pain = 0
	/// A list of possible sounds.
	var/list/sound_possible = list()
	/// What requirements does this interaction have? See defines.
	var/list/interaction_requires = list()
	/// What color should the interaction button be?
	var/color = "blue"
	/// What sexuality preference do we display for.
	var/sexuality = ""
	/// If this interaction involves suckling on the target's nipples and should transfer breast fluid.
	var/nipple_sucking = FALSE
	/// If this is a douche self-interaction that cleans internal cum (requires shower or water spray bottle).
	var/douche = FALSE

/datum/interaction/proc/allow_act(mob/living/user, mob/living/target)
	if(target == user && usage == INTERACTION_OTHER)
		return FALSE
	if(target != user && usage == INTERACTION_SELF)
		return FALSE

	if(user_required_parts.len)
		for(var/thing in user_required_parts)
			if(!user.has_required_part(thing))
				return FALSE

	if(target_required_parts.len)
		for(var/thing in target_required_parts)
			if(!target.has_required_part(thing))
				return FALSE

	for(var/requirement in interaction_requires)
		switch(requirement)
			if(INTERACTION_REQUIRE_SELF_HAND)
				if(!user.has_arms())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_HAND)
				if(!target.has_arms())
					return FALSE
			else
				CRASH("Unimplemented interaction requirement '[requirement]'")
	return TRUE

/datum/interaction/proc/get_arousal_message_pool(list/base_pool, list/low_pool, list/medium_pool, list/high_pool, arousal)
	if(arousal >= AROUSAL_MEDIUM && length(high_pool))
		return high_pool
	if(arousal >= AROUSAL_LOW && length(medium_pool))
		return medium_pool
	if(length(low_pool))
		return low_pool
	return base_pool

/datum/interaction/proc/act(mob/living/user, mob/living/target, obj/body_relay = null)
	if(!allow_act(user, target))
		return
	if(douche)
		if(!user.is_in_shower() && !user.holds_water_spray())
			to_chat(user, span_warning("You need to be in a shower or holding a water-filled spray bottle to clean yourself out."))
			return
		if(!user.douche_lewd())
			to_chat(user, span_notice("You're already clean."))
			return
	if(!message)
		message_admins("Interaction had a null message list. '[name]'")
		return
	if(!islist(message) && istext(message))
		message_admins("Deprecated message handling for '[name]'. Correct format is a list with one entry. This message will only show once.")
		message = list(message)

	var/max_arousal = max(user.arousal, target.arousal)
	var/lewd_intensity = clamp(max(user.arousal, target.arousal, user.pain, target.pain) / AROUSAL_LIMIT * 100, 0, 100)
	var/list/message_pool = get_arousal_message_pool(message, message_low, message_medium, message_high, max_arousal)
	var/msg = pick(message_pool)
	if(!isnull(body_relay))
		msg = replacetext(msg, "%TARGET%", "\the [body_relay.name]")
	// We replace %USER% with nothing because manual_emote already prepends it.
	msg = trim(replacetext(replacetext(msg, "%TARGET%", "[target]"), "%USER%", ""), INTERACTION_MAX_CHAR)
	msg = replacetext(msg, "%COCK%", user.get_cock_flavor())
	if(lewd)
		msg = lewd_gradient_span(msg, lewd_intensity)
		user.emote("subtle", null, msg, TRUE)
	else
		user.manual_emote(msg)

	if(user_messages.len || user_messages_low.len || user_messages_medium.len || user_messages_high.len)
		var/list/user_pool = get_arousal_message_pool(user_messages, user_messages_low, user_messages_medium, user_messages_high, max_arousal)
		var/user_msg = pick(user_pool)
		if(!isnull(body_relay))
			user_msg = replacetext(user_msg, "%TARGET%", "\the [body_relay.name]")
		user_msg = replacetext(replacetext(user_msg, "%TARGET%", "[target]"), "%USER%", "[user]")
		user_msg = replacetext(user_msg, "%COCK%", user.get_cock_flavor())
		if(lewd)
			user_msg = lewd_gradient_span(user_msg, lewd_intensity)
		to_chat(user, user_msg)

	if(target_messages.len || target_messages_low.len || target_messages_medium.len || target_messages_high.len)
		var/list/target_pool = get_arousal_message_pool(target_messages, target_messages_low, target_messages_medium, target_messages_high, max_arousal)
		var/target_msg = pick(target_pool)
		if(!isnull(body_relay))
			target_msg = replacetext(target_msg, "%USER%", "Unknown")
		target_msg = replacetext(replacetext(target_msg, "%TARGET%", "[target]"), "%USER%", "[user]")
		target_msg = replacetext(target_msg, "%COCK%", user.get_cock_flavor())
		if(lewd)
			target_msg = lewd_gradient_span(target_msg, lewd_intensity)
		to_chat(target, target_msg)

	if(sound_use)
		if(!sound_possible)
			message_admins("Interaction has sound_use set to TRUE but does not set sound! '[name]'")
			return
		if(!islist(sound_possible) && istext(sound_possible))
			message_admins("Deprecated sound handling for '[name]'. Correct format is a list with one entry. This message will only show once.")
			sound_possible = list(sound_possible)
		sound_cache = pick(sound_possible)
		// playsound()'s range is always SOUND_RANGE (15) + extrarange, so we offset by -SOUND_RANGE to make
		// extrarange effectively equal to the JSON-defined sound_range instead of stacking on top of it.
		playsound(source = user, soundin = sound_cache, vol = 50, vary = FALSE, extrarange = sound_range - SOUND_RANGE, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_emote)

	if(lewd)
		var/arousal_factor = 1 + (max_arousal / AROUSAL_LIMIT) * 0.5
		user.adjust_pleasure(round(user_pleasure * arousal_factor))
		user.adjust_arousal(round(user_arousal * arousal_factor))
		user.adjust_pain(user_pain)
		target.adjust_pleasure(round(target_pleasure * arousal_factor))
		target.adjust_arousal(round(target_arousal * arousal_factor))
		target.adjust_pain(target_pain)
		if(!douche)
			user.last_lewd_partner = target
			target.last_lewd_partner = user

		if(nipple_sucking)
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				var/obj/item/organ/genital/breasts/breasts = human_target.get_organ_slot(ORGAN_SLOT_BREASTS)
				if(breasts && breasts.lactates && breasts.reagents.total_volume > 0)
					var/amount = min(3, breasts.reagents.total_volume)
					breasts.reagents.trans_to(user, amount, transferred_by = target, methods = INGEST)
					to_chat(user, span_userlove("You drink from [target]'s nipple."))
					to_chat(target, span_userlove("[user] drinks from your nipple."))
				else
					to_chat(user, span_notice("[target]'s nipples are dry."))
			else if(iscyborg(target))
				var/mob/living/silicon/robot/robot_target = target
				if(robot_target.synthetic_breasts && robot_target.synthetic_breast_fluid > 0)
					var/amount = min(3, robot_target.synthetic_breast_fluid)
					robot_target.synthetic_breast_fluid -= amount
					user.reagents.add_reagent(robot_target.synthetic_breast_reagent, amount)
					to_chat(user, span_userlove("You drink warm [robot_target.get_synthetic_breast_fluid_name()] from [target]'s nipple."))
					to_chat(target, span_userlove("[user] drinks from your nipple."))
				else
					to_chat(user, span_notice("[target]'s nipples are dry."))

		if(body_relay)
			var/obj/lewd_portal_relay/body_portal_relay = body_relay
			body_portal_relay.update_visuals()

/datum/interaction/proc/load_from_json(path)
	var/fpath = path
	if(!fexists(fpath))
		message_admins("Attempted to load an interaction from json and the file does not exist")
		qdel(src)
		return FALSE
	var/file = file(fpath)
	var/list/json = json_load(file)
	name = sanitize_text(json["name"])
	description = sanitize_text(json["description"])
	distance_allowed = sanitize_integer(json["distance_allowed"], 0, 1, 0)
	message = sanitize_islist(json["message"], list("json error"))
	message_low = sanitize_islist(json["message_low"], list())
	message_medium = sanitize_islist(json["message_medium"], list())
	message_high = sanitize_islist(json["message_high"], list())
	category = sanitize_text(json["category"])
	usage = sanitize_text(json["usage"])
	sound_use = sanitize_integer(json["sound_use"], 0, 1, 0)
	sound_range = sanitize_integer(json["sound_range"], 1, 7, 1)
	sound_possible = sanitize_islist(json["sound_possible"], list("json error"))
	interaction_requires = sanitize_islist(json["interaction_requires"], list())
	color = sanitize_text(json["color"])

	user_messages = sanitize_islist(json["user_messages"], list())
	user_messages_low = sanitize_islist(json["user_messages_low"], list())
	user_messages_medium = sanitize_islist(json["user_messages_medium"], list())
	user_messages_high = sanitize_islist(json["user_messages_high"], list())
	user_required_parts = sanitize_islist(json["user_required_parts"], list())
	user_arousal = sanitize_integer(json["user_arousal"], 0, 100, 0)
	user_pleasure = sanitize_integer(json["user_pleasure"], 0, 100, 0)
	user_pain = sanitize_integer(json["user_pain"], 0, 100, 0)
	target_messages = sanitize_islist(json["target_messages"], list())
	target_messages_low = sanitize_islist(json["target_messages_low"], list())
	target_messages_medium = sanitize_islist(json["target_messages_medium"], list())
	target_messages_high = sanitize_islist(json["target_messages_high"], list())
	target_required_parts = sanitize_islist(json["target_required_parts"], list())
	target_arousal = sanitize_integer(json["target_arousal"], 0, 100, 0)
	target_pleasure = sanitize_integer(json["target_pleasure"], 0, 100, 0)
	target_pain = sanitize_integer(json["target_pain"], 0, 100, 0)
	lewd = sanitize_integer(json["lewd"], 0, 1, 0)
	sexuality = sanitize_text(json["sexuality"])
	nipple_sucking = sanitize_integer(json["nipple_sucking"], 0, 1, 0)
	douche = sanitize_integer(json["douche"], 0, 1, 0)
	return TRUE

/datum/interaction/proc/json_save(path)
	var/fpath = path
	if(fexists(fpath))
		fdel(fpath)
	var/list/json = list(
		"name" = name,
		"description" = description,
		"distance_allowed" = distance_allowed,
		"message" = message,
		"message_low" = message_low,
		"message_medium" = message_medium,
		"message_high" = message_high,
		"category" = category,
		"usage" = usage,
		"sound_use" = sound_use,
		"sound_range" = sound_range,
		"sound_possible" = sound_possible,
		"interaction_requires" = interaction_requires,
		"color" = color,
		"user_messages" = user_messages,
		"user_messages_low" = user_messages_low,
		"user_messages_medium" = user_messages_medium,
		"user_messages_high" = user_messages_high,
		"user_required_parts" = user_required_parts,
		"user_arousal" = user_arousal,
		"user_pleasure" = user_pleasure,
		"user_pain" = user_pain,
		"target_messages" = target_messages,
		"target_messages_low" = target_messages_low,
		"target_messages_medium" = target_messages_medium,
		"target_messages_high" = target_messages_high,
		"target_required_parts" = target_required_parts,
		"target_arousal" = target_arousal,
		"target_pleasure" = target_pleasure,
		"target_pain" = target_pain,
		"lewd" = lewd,
		"sexuality" = sexuality,
		"nipple_sucking" = nipple_sucking,
		"douche" = douche,
	)
	var/file = file(fpath)
	WRITE_FILE(file, json_encode(json))
	return TRUE

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/interactable)

/// Global loading procs
/proc/populate_interaction_instances()
	for(var/spath in subtypesof(/datum/interaction))
		var/datum/interaction/interaction = new spath()
		GLOB.interaction_instances[interaction.name] = interaction
	populate_interaction_jsons(INTERACTION_JSON_FOLDER)

/proc/populate_interaction_jsons(directory)
	for(var/file in flist(directory))
		if(flist(directory + file) && !findlasttext(directory + file, ".json"))
			populate_interaction_instances(directory + file)
			continue
		if(findlasttext(directory + file, ".master.json")) // This is a master json which has special handling
			populate_interaction_jsons_master(directory + file)
			continue
		var/datum/interaction/interaction = new()
		if(interaction.load_from_json(directory + file))
			GLOB.interaction_instances[interaction.name] = interaction
		else message_admins("Error loading interaction from file: '[directory + file]'. Inform coders.")

/proc/populate_interaction_jsons_master(path)
	if(!fexists(path))
		message_admins("We are attempting to load an interaction master without the file existing! '[path]'")
		return
	var/file = file(path)
	var/list/json = json_load(file)

	for(var/iname in json)
		if(GLOB.interaction_instances[iname])
			message_admins("Interaction Master '[path]' contained a duplicate interaction! '[iname]'")
			continue

		var/list/ijson = json[iname]
		if(ijson["name"] != iname)
			message_admins("Interaction Master '[path]' contained an invalid interaction! '[iname]'")
			continue

		var/datum/interaction/interaction = new()

		interaction.distance_allowed = sanitize_integer(ijson["distance_allowed"], 0, 1, 0)
		interaction.message = sanitize_islist(ijson["message"], list("json error"))
		interaction.message_low = sanitize_islist(ijson["message_low"], list())
		interaction.message_medium = sanitize_islist(ijson["message_medium"], list())
		interaction.message_high = sanitize_islist(ijson["message_high"], list())
		interaction.category = sanitize_text(ijson["category"])
		interaction.usage = sanitize_text(ijson["usage"])
		interaction.sound_use = sanitize_integer(ijson["sound_use"], 0, 1, 0)
		interaction.sound_range = sanitize_integer(ijson["sound_range"], 1, 7, 1)
		interaction.sound_possible = sanitize_islist(ijson["sound_possible"], list("json error"))
		interaction.interaction_requires = sanitize_islist(ijson["interaction_requires"], list())
		interaction.color = sanitize_text(ijson["color"])

		interaction.user_messages = sanitize_islist(ijson["user_messages"], list())
		interaction.user_messages_low = sanitize_islist(ijson["user_messages_low"], list())
		interaction.user_messages_medium = sanitize_islist(ijson["user_messages_medium"], list())
		interaction.user_messages_high = sanitize_islist(ijson["user_messages_high"], list())
		interaction.user_required_parts = sanitize_islist(ijson["user_required_parts"], list())
		interaction.user_arousal = sanitize_integer(ijson["user_arousal"], 0, 100, 0)
		interaction.user_pleasure = sanitize_integer(ijson["user_pleasure"], 0, 100, 0)
		interaction.user_pain = sanitize_integer(ijson["user_pain"], 0, 100, 0)
		interaction.target_messages = sanitize_islist(ijson["target_messages"], list())
		interaction.target_messages_low = sanitize_islist(ijson["target_messages_low"], list())
		interaction.target_messages_medium = sanitize_islist(ijson["target_messages_medium"], list())
		interaction.target_messages_high = sanitize_islist(ijson["target_messages_high"], list())
		interaction.target_required_parts = sanitize_islist(ijson["target_required_parts"], list())
		interaction.target_arousal = sanitize_integer(ijson["target_arousal"], 0, 100, 0)
		interaction.target_pleasure = sanitize_integer(ijson["target_pleasure"], 0, 100, 0)
		interaction.target_pain = sanitize_integer(ijson["target_pain"], 0, 100, 0)
		interaction.lewd = sanitize_integer(ijson["lewd"], 0, 1, 0)
		interaction.sexuality = sanitize_text(ijson["sexuality"])
		interaction.nipple_sucking = sanitize_integer(ijson["nipple_sucking"], 0, 1, 0)

		GLOB.interaction_instances[iname] = interaction

ADMIN_VERB(reload_interactions, R_DEBUG, "Reload Interactions", "Force reload interactions.", ADMIN_CATEGORY_DEBUG)
	populate_interaction_instances()
