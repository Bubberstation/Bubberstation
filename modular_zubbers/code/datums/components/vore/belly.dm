/obj/vore_belly
	name = "Default Belly"
	desc = "It's very bland!"

	var/datum/component/vore/owner
	var/datum/digest_mode/digest_mode
	var/noise_cooldown = 0

	var/can_taste = TRUE
	var/insert_verb = "ingest"
	var/release_verb = "expels"

	var/brute_damage = 0
	var/burn_damage = 1

	// Mean things
	var/muffles_radio = TRUE // muffles radios used inside it
	var/escape_chance = 100
	var/escape_time = DEFAULT_ESCAPE_TIME

	// Sounds
	var/is_wet = TRUE
	var/wet_loop = TRUE

	var/fancy_sounds = TRUE
	var/insert_sound = "Gulp"
	var/release_sound = "Splatter"

/obj/vore_belly/Initialize(mapload, datum/component/vore/new_owner)
	. = ..()
	if(!istype(new_owner))
		return INITIALIZE_HINT_QDEL
	owner = new_owner
	LAZYADD(owner.vore_bellies, src)
	digest_mode = GLOB.digest_modes["None"]
	START_PROCESSING(SSvore, src)
	// Do our best not to get dropped
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/vore_belly/Destroy(force)
	STOP_PROCESSING(SSvore, src)
	if(owner)
		LAZYREMOVE(owner.vore_bellies, src)
	owner = null
	digest_mode = null
	// Safely yeet everything out
	var/turf/T = get_turf(src)
	for(var/atom/movable/A as anything in contents)
		A.forceMove(T)
	. = ..()

/// On process, bellies ask their digestion mode (if there is one) to process them
/obj/vore_belly/process(seconds_per_tick)
	digest_mode?.handle_belly(src, seconds_per_tick)
	prey_loop()

/// Called from /datum/component/vore/ui_data to display belly settings
/obj/vore_belly/ui_data(mob/user)
	var/user_is_parent = user == owner.parent
	var/list/data = list()

	data["name"] = name
	if(user_is_parent)
		data["desc"] = desc
	else
		data["desc"] = format_message(desc, user)
	// Try not to leak refs too much
	if(user_is_parent)
		data["ref"] = REF(src)
	else
		data["owner_name"] = "[owner.parent]"

	var/list/contents_data = list()
	for(var/atom/A as anything in contents)
		UNTYPED_LIST_ADD(contents_data, list(
			"name" = A.name,
			"ref" = REF(A),
			"appearance" = REF(A.appearance),
		))
	data["contents"] = contents_data

	data["digest_mode"] = digest_mode?.name

	data["can_taste"] = can_taste
	data["insert_verb"] = insert_verb
	data["release_verb"] = release_verb

	data["brute_damage"] = brute_damage
	data["burn_damage"] = burn_damage

	data["muffles_radio"] = muffles_radio
	data["escape_chance"] = escape_chance
	data["escape_time"] = escape_time

	data["is_wet"] = is_wet
	data["wet_loop"] = wet_loop

	data["fancy_sounds"] = fancy_sounds
	data["insert_sound"] = insert_sound
	data["release_sound"] = release_sound

	return data

/// Called from /datum/component/vore/ui_act to update belly settings
/obj/vore_belly/proc/ui_modify_var(var_name, value)
	switch(var_name)
		if("name")
			var/new_name = permissive_sanitize_name(value)
			if(new_name)
				name = new_name
		if("desc")
			desc = STRIP_HTML_SIMPLE(value, MAX_FLAVOR_LEN)
		if("digest_mode")
			var/datum/digest_mode/new_digest_mode = GLOB.digest_modes[value]
			if(istype(new_digest_mode))
				digest_mode = new_digest_mode
		if("can_taste")
			can_taste = !can_taste
		if("insert_verb")
			insert_verb = STRIP_HTML_SIMPLE(value, MAX_VERB_LENGTH)
		if("release_verb")
			release_verb = STRIP_HTML_SIMPLE(value, MAX_VERB_LENGTH)
		if("brute_damage")
			brute_damage = clamp(value, 0, MAX_BRUTE_DAMAGE)
		if("burn_damage")
			burn_damage = clamp(value, 0, MAX_BURN_DAMAGE)
		if("muffles_radio")
			muffles_radio = !muffles_radio
		if("escape_chance")
			escape_chance = clamp(value, 0, 100)
		if("escape_time")
			escape_time = clamp(value, MIN_ESCAPE_TIME, MAX_ESCAPE_TIME)
		if("is_wet")
			is_wet = !is_wet
		if("wet_loop")
			wet_loop = !wet_loop
		if("fancy_sounds")
			fancy_sounds = !fancy_sounds
			// Different sound set, switching between these could cause issues
			insert_sound = "Gulp"
			release_sound = "Splatter"
		if("insert_sound")
			var/list/sounds_to_pick_from
			if(fancy_sounds)
				sounds_to_pick_from = GLOB.vore_sounds_insert_fancy
			else
				sounds_to_pick_from = GLOB.vore_sounds_insert_classic
			var/new_sound = tgui_input_list(usr, "Pick an insert sound", "Insert Sound", sounds_to_pick_from, insert_sound)
			if(new_sound)
				insert_sound = new_sound
		if("release_sound")
			var/list/sounds_to_pick_from
			if(fancy_sounds)
				sounds_to_pick_from = GLOB.vore_sounds_release_fancy
			else
				sounds_to_pick_from = GLOB.vore_sounds_release_classic
			var/new_sound = tgui_input_list(usr, "Pick an release sound", "Release Sound", sounds_to_pick_from, release_sound)
			if(new_sound)
				release_sound = new_sound

// Disables assume_air
/obj/vore_belly/assume_air(datum/gas_mixture/giver)
	return null

/// Disables remove_air
/obj/vore_belly/remove_air(amount)
	return null

/// Disables return_air
/obj/vore_belly/return_air()
	return null

/// Returns an immutable mixture, GLOB.belly_air, which is always safe to breath
/obj/vore_belly/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	if(breath_request > 0)
		var/breath_percentage = breath_request / GLOB.belly_air.return_volume()
		return GLOB.belly_air.remove(GLOB.belly_air.total_moles() * breath_percentage)
	else
		return null

/// Sounds
/obj/vore_belly/proc/get_insert_sound()
	if(fancy_sounds)
		return GLOB.vore_sounds_insert_fancy[insert_sound]
	else
		return GLOB.vore_sounds_insert_classic[insert_sound]

/obj/vore_belly/proc/get_release_sound()
	if(fancy_sounds)
		return GLOB.vore_sounds_release_fancy[release_sound]
	else
		return GLOB.vore_sounds_release_classic[release_sound]

/obj/vore_belly/proc/prey_loop()
	if(!is_wet || !wet_loop)
		return

	for(var/mob/living/listening_mob in src)
		var/datum/vore_preferences/listener_vore_prefs = listening_mob.get_vore_prefs()
		if(!listener_vore_prefs)
			continue
		var/pref_enabled = listener_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion_noises)
		//We don't bother executing any other code if the prey doesn't want to hear the noises.
		if(!pref_enabled)
			// In case someone turns off their pref
			listening_mob.stop_sound_channel(CHANNEL_PREYLOOP)
			continue

		// We don't want the sounds to overlap, but we do want them to steadily replay.
		// We also don't want the sounds to play if the pred hasn't marked this belly as fleshy, or doesn't
		// have the right sounds to play.
		if(TIMER_COOLDOWN_FINISHED(listening_mob, COOLDOWN_PREYLOOP))
			listening_mob.stop_sound_channel(CHANNEL_PREYLOOP)
			// Must reload each time because playsound_local modifies the sound datum
			var/sound/preyloop = sound('modular_zubbers/sound/vore/sunesound/prey/loop.ogg')
			listening_mob.playsound_local(get_turf(src), preyloop, 80, 0, channel = CHANNEL_PREYLOOP)
			TIMER_COOLDOWN_START(listening_mob, COOLDOWN_PREYLOOP, 52 SECONDS)

/// Handles prey entering a belly, and starts deep_search_prey
/obj/vore_belly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(!owner)
		return
	var/mob/living/living_parent = owner.parent
	owner.play_vore_sound(get_insert_sound())
	to_chat(living_parent, span_notice("[arrived] slides into your [lowertext(name)]."))
	owner.appearance_holder.vis_contents += arrived
	if(ismob(arrived))
		var/mob/M = arrived
		RegisterSignal(M, COMSIG_MOVABLE_USING_RADIO, PROC_REF(try_deny_radio))
		ADD_TRAIT(M, TRAIT_SOFTSPOKEN, TRAIT_SOURCE_VORE)
		deep_search_prey(M)
		to_chat(M, examine_block("You slide into [span_notice("[owner.parent]")]'s [span_green(lowertext(name))]!\n[format_message(desc, M)]"))
		// Add the appearance_holder to prey so they can see fellow prey
		if(can_taste && iscarbon(M))
			var/mob/living/carbon/H = M
			to_chat(living_parent, span_notice("[H] tastes of [H.dna.features["taste"] || "nothing"]."))
		if(M.client)
			M.client.screen += owner.appearance_holder

/obj/vore_belly/proc/try_deny_radio()
	if(muffles_radio)
		return COMPONENT_CANNOT_USE_RADIO
	return null

/// Search through prey's recursive contents to prevent smuggling any GLOB.vore_blacklist_types items around
/obj/vore_belly/proc/deep_search_prey(mob/arrived)
	var/turf/reject_location = get_turf(src)
	var/list/all_contents = arrived.get_contents()
	for(var/atom/movable/AM as anything in all_contents)
		if(is_type_in_list(AM, GLOB.vore_blacklist_types))
			// If it's directly in their inventory, call dropItemToGround so that it cleans up the hud
			if(AM in arrived)
				arrived.dropItemToGround(AM, TRUE)
			AM.forceMove(reject_location)
		#if DISABLES_SENSORS
		if(istype(AM, /obj/item/clothing/under))
			var/obj/item/clothing/under/sensor_clothing = AM
			sensor_clothing.sensor_mode = NO_SENSORS
			if(ishuman(arrived))
				var/mob/living/carbon/human/H = arrived
				if(H.w_uniform == sensor_clothing)
					H.update_suit_sensors()
		#endif

/// Handles prey leaving a belly
/obj/vore_belly/Exited(atom/movable/gone, direction)
	. = ..()
	if(!owner)
		return
	// Deleted/transferred mobs don't play exit sounds
	var/mob/living/living_parent = owner.parent
	if(!living_parent.contains(gone))
		owner.play_vore_sound(get_release_sound())
	owner.appearance_holder.vis_contents -= gone
	if(ismob(gone))
		var/mob/M = gone
		UnregisterSignal(M, COMSIG_MOVABLE_USING_RADIO)
		REMOVE_TRAIT(M, TRAIT_SOFTSPOKEN, TRAIT_SOURCE_VORE)
		if(!istype(M.loc, /obj/vore_belly))
			M.stop_sound_channel(CHANNEL_PREYLOOP)
		// We added it so let's take it away
		if(M.client)
			M.client.screen -= owner.appearance_holder

/// Does not call parent, which hides the "you can't move while buckled" message
/// Also makes squelchy sounds when prey tries to squirm.
/obj/vore_belly/relaymove(mob/living/user, direction)
	return container_resist_act(user)

/obj/vore_belly/proc/escapable(mob/living/user)
	var/mob/living/living_parent = owner.parent
	if(!escape_chance && !living_parent.stat)
		return FALSE
	// TODO: absorbed
	return TRUE

/obj/vore_belly/container_resist_act(mob/living/user)
	// This sets a hard limit on how often the user can try to escape or squirm
	if(!TIMER_COOLDOWN_FINISHED(user, COOLDOWN_ESCAPE))
		return
	TIMER_COOLDOWN_START(user, COOLDOWN_ESCAPE, COOLDOWN_ESCAPE_TIME)

	var/mob/living/living_parent = owner.parent

	var/escape_attempt_prey_message = span_warning(format_message(pick(GLOB.escape_attempt_messages_prey), user))
	var/escape_attempt_owner_message = span_warning(format_message(pick(GLOB.escape_attempt_messages_owner), user))
	var/escape_fail_prey_message = span_warning(format_message(pick(GLOB.escape_fail_messages_prey), user))
	var/escape_fail_owner_message = span_notice(format_message(pick(GLOB.escape_fail_messages_owner), user))

	if(living_parent.stat) // If owner is dead, we can actually escape
		to_chat(user, escape_attempt_prey_message)
		to_chat(living_parent, escape_attempt_owner_message)

		if(do_after(user, escape_time, living_parent, timed_action_flags = IGNORE_TARGET_LOC_CHANGE))
			if(user.loc != src) // ignore if they're not in the belly
				return
			else if(escapable(user))
				release(user)
			else
				to_chat(user, escape_fail_prey_message)
				to_chat(living_parent, escape_fail_owner_message)
			return

	var/struggle_outer_message = span_warning(format_message(pick(GLOB.struggle_messages_outside), user))
	var/struggle_user_message = span_warning(format_message(pick(GLOB.struggle_messages_inside), user))

	// Only show the owner the outside message
	to_chat(living_parent, struggle_outer_message)

	if(is_wet)
		owner.play_vore_sound(fancy_sounds ? "vore_sounds_struggle_fancy" : "vore_sounds_struggle_classic", 75, vary = TRUE, pref = /datum/vore_pref/toggle/digestion_noises)
	else
		owner.play_vore_sound("rustle", 75, vary = TRUE, pref = /datum/vore_pref/toggle/digestion_noises)

	if(escapable(user))
		if(prob(escape_chance))
			to_chat(user, escape_attempt_prey_message)
			to_chat(living_parent, escape_attempt_owner_message)

			if(do_after(user, escape_time, living_parent, timed_action_flags = IGNORE_TARGET_LOC_CHANGE))
				if(user.loc != src) // ignore if they're not in the belly
					return
				else if(escapable(user)) // Still escapable
					var/escape_owner_message = span_warning(format_message(pick(GLOB.escape_messages_owner), user))
					var/escape_prey_message = span_warning(format_message(pick(GLOB.escape_messages_prey), user))

					to_chat(living_parent, escape_owner_message)
					to_chat(user, escape_prey_message)
					// If you want others to see this happen, this is where you'd put it
					release(user)
				else // Belly became unescapable
					to_chat(user, escape_fail_prey_message)
					to_chat(living_parent, escape_fail_owner_message)
				return // don't print struggle message
		else
			to_chat(living_parent, span_warning("Your prey appears to be unable to make any progress in escaping your [lowertext(name)]."))

	to_chat(user, struggle_user_message)


/// Do NOT do cleanup in here, clean up in /Exited
/// This is just a helper proc for showing a message
/obj/vore_belly/proc/release(atom/movable/AM)
	var/mob/living/living_parent = owner.parent
	AM.forceMove(living_parent.loc)
	AM.visible_message(span_warning("[living_parent] [lowertext(release_verb)] [AM] from their [lowertext(name)]."), pref_to_check = /datum/preference/toggle/erp/vore_enable)

/// Formats a vore message
/obj/vore_belly/proc/format_message(message, mob/prey)
	message = replacetext(message, "%pred", owner.parent)
	message = replacetext(message, "%prey", prey)
	message = replacetext(message, "%belly", src)
	message = replacetext(message, "%count", LAZYLEN(contents))
	return message


/// Serializes this belly to store in savefile data.
/obj/vore_belly/proc/serialize()
	return list(
		VORE_BELLY_KEY = VORE_BELLY_VERSION,
		"name" = name,
		"desc" = desc,
		"digest_mode" = digest_mode?.name,
		"can_taste" = can_taste,
		"insert_verb" = insert_verb,
		"release_verb" = release_verb,
		"brute_damage" = brute_damage,
		"burn_damage" = burn_damage,
		"muffles_radio" = muffles_radio,
		"escape_chance" = escape_chance,
		"escape_time" = escape_time,
		"is_wet" = is_wet,
		"wet_loop" = wet_loop,
		"fancy_sounds" = fancy_sounds,
		"insert_sound" = insert_sound,
		"release_sound" = release_sound,
	)

// Called when a savefile passed to us does not match our expected version
/obj/vore_belly/proc/apply_migrations(list/data)
	data[VORE_BELLY_KEY] = VORE_BELLY_VERSION

/// Deserializes this belly from savefile data
/obj/vore_belly/proc/deserialize(list/data)
	if(!(VORE_BELLY_KEY in data)) // We've been passed invalid data, probably VRDB
		var/maybe_name = data["name"]
		if(maybe_name)
			deserialize_vrdb(data)
		else
			to_chat(usr, span_warning("Unable to load belly, missing '[VORE_BELLY_KEY]' signature and cannot detect VRBD"))
		return
	if(data[VORE_BELLY_KEY] != VORE_BELLY_VERSION)
		apply_migrations(data)
	name = permissive_sanitize_name(data["name"]) || "(Bad Name)"
	desc = STRIP_HTML_SIMPLE(data["desc"], MAX_FLAVOR_LEN) || "(Bad Desc)"
	digest_mode = GLOB.digest_modes[sanitize_text(data["digest_mode"])] || GLOB.digest_modes["None"]

	can_taste = sanitize_integer(data["can_taste"], FALSE, TRUE, TRUE)
	insert_verb = STRIP_HTML_SIMPLE(data["insert_verb"], MAX_VERB_LENGTH) || "ingest"
	release_verb = STRIP_HTML_SIMPLE(data["release_verb"], MAX_VERB_LENGTH) || "expels"

	brute_damage = sanitize_integer(data["brute_damage"], 0, MAX_BRUTE_DAMAGE, 0)
	burn_damage = sanitize_integer(data["burn_damage"], 0, MAX_BURN_DAMAGE, 1)

	muffles_radio = isnum(data["muffles_radio"]) ? !!data["muffles_radio"] : TRUE // make false by default
	escape_chance = sanitize_integer(data["escape_chance"], 0, 100, 100)
	escape_time = sanitize_integer(data["escape_time"], MIN_ESCAPE_TIME, MAX_ESCAPE_TIME, DEFAULT_ESCAPE_TIME)

	is_wet = sanitize_integer(data["is_wet"], FALSE, TRUE, TRUE) // make true by default
	wet_loop = sanitize_integer(data["wet_loop"], FALSE, TRUE, TRUE) // make true by default
	fancy_sounds = sanitize_integer(data["fancy_sounds"], FALSE, TRUE, TRUE) // if there's no data, make it true by default

	if(istext(data["insert_sound"]))
		var/new_insert_sound = trim(sanitize(data["insert_sound"]), MAX_MESSAGE_LEN)
		if(new_insert_sound)
			if(fancy_sounds && (new_insert_sound in GLOB.vore_sounds_insert_fancy))
				insert_sound = new_insert_sound
			if(!fancy_sounds && (new_insert_sound in GLOB.vore_sounds_insert_classic))
				insert_sound = new_insert_sound

	if(istext(data["release_sound"]))
		var/new_release_sound = trim(sanitize(data["release_sound"]), MAX_MESSAGE_LEN)
		if(new_release_sound)
			if(fancy_sounds && (new_release_sound in GLOB.vore_sounds_release_fancy))
				release_sound = new_release_sound
			if(!fancy_sounds && (new_release_sound in GLOB.vore_sounds_release_classic))
				release_sound = new_release_sound

/// Special handler that tries to deserialize as much of a VRDB save as it can
/obj/vore_belly/proc/deserialize_vrdb(list/data)
	var/maybe_name = data["name"]
	to_chat(usr, span_warning("Attempting to load VRDB belly '[maybe_name]'..."))
	name = permissive_sanitize_name(maybe_name) || "(Bad Name)"
	desc = STRIP_HTML_SIMPLE(data["desc"], MAX_FLAVOR_LEN) || "(Bad Desc)"
	digest_mode = GLOB.digest_modes[sanitize_text(data["mode"])] || GLOB.digest_modes["None"]

	can_taste = sanitize_integer(data["can_taste"], FALSE, TRUE, TRUE)
	insert_verb = STRIP_HTML_SIMPLE(data["vore_verb"], MAX_VERB_LENGTH) || "ingest"
	release_verb = STRIP_HTML_SIMPLE(data["release_verb"], MAX_VERB_LENGTH) || "expels"

	escape_chance = sanitize_integer(data["escapechance"], 0, 100, 100)
	escape_time = sanitize_integer(data["escapetime"], MIN_ESCAPE_TIME, MAX_ESCAPE_TIME, DEFAULT_ESCAPE_TIME)

	is_wet = sanitize_integer(data["is_wet"], FALSE, TRUE, TRUE) // make true by default
	wet_loop = sanitize_integer(data["wet_loop"], FALSE, TRUE, TRUE) // make true by default
	fancy_sounds = sanitize_integer(data["fancy_vore"], FALSE, TRUE, TRUE) // if there's no data, make it true by default

	if(istext(data["vore_sound"]))
		var/new_insert_sound = trim(sanitize(data["vore_sound"]), MAX_MESSAGE_LEN)
		if(new_insert_sound)
			if(fancy_sounds && (new_insert_sound in GLOB.vore_sounds_insert_fancy))
				insert_sound = new_insert_sound
			if(!fancy_sounds && (new_insert_sound in GLOB.vore_sounds_insert_classic))
				insert_sound = new_insert_sound

	if(istext(data["release_sound"]))
		var/new_release_sound = trim(sanitize(data["release_sound"]), MAX_MESSAGE_LEN)
		if(new_release_sound)
			if(fancy_sounds && (new_release_sound in GLOB.vore_sounds_release_fancy))
				release_sound = new_release_sound
			if(!fancy_sounds && (new_release_sound in GLOB.vore_sounds_release_classic))
				release_sound = new_release_sound

/// Plays sound just to pred and prey in this stomach
/obj/vore_belly/proc/play_vore_sound_preypred(preysound, predsound, volume = 100, range = 2, vary = FALSE, pref = /datum/vore_pref/toggle/eating_noises)
	var/turf/turf_source = get_turf(owner.parent)
	var/sound/prey_sound = isdatum(preysound) ? preysound : sound(get_vore_sfx(preysound))
	var/sound/pred_sound = isdatum(predsound) ? predsound : sound(get_vore_sfx(predsound))

	// Needed because playsound_local runtimes at range = 1
	var/range_to_use = range
	if(range_to_use < 2)
		range_to_use = 0

	for(var/mob/living/listening_mob in src)
		var/datum/vore_preferences/listener_vore_prefs = listening_mob.get_vore_prefs()
		if(!listener_vore_prefs)
			continue
		var/pref_enabled = listener_vore_prefs.read_preference(pref)
		if(!pref_enabled)
			continue

		listening_mob.playsound_local(
			turf_source, preysound, volume, vary,
			sound_to_use = prey_sound,
			max_distance = range,
		)

	var/mob/living/living_parent = owner.parent
	var/datum/vore_preferences/owner_prefs = living_parent.get_vore_prefs()
	if(!owner_prefs)
		return
	var/pref_enabled = owner_prefs.read_preference(pref)
	if(!pref_enabled)
		return

	living_parent.playsound_local(
		turf_source, predsound, volume, vary,
		sound_to_use = pred_sound,
		max_distance = range,
	)
