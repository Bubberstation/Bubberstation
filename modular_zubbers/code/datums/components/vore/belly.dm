/obj/vore_belly
	name = "Default Belly"
	desc = "It's very bland!"

	// Internal state
	var/datum/component/vore/owner
	var/datum/digest_mode/digest_mode
	var/noise_cooldown = 0

	// Settings
	var/can_taste = TRUE
	var/insert_verb = "ingest"
	var/release_verb = "expels"

	var/brute_damage = 0
	var/burn_damage = 1

	// Mean things
	var/muffles_radio = TRUE // muffles radios used inside it
	var/escape_chance = 100
	var/escape_time = DEFAULT_ESCAPE_TIME
	var/overlay_path = null
	var/overlay_color = "#ffffff"

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
	digest_mode = GLOB.digest_modes[DIGEST_MODE_SAFE]
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
			"absorbed" = HAS_TRAIT_FROM(A, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE),
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
	data["overlay_path"] = overlay_path
	data["overlay_color"] = overlay_color

	data["is_wet"] = is_wet
	data["wet_loop"] = wet_loop

	data["fancy_sounds"] = fancy_sounds
	data["insert_sound"] = insert_sound
	data["release_sound"] = release_sound

	// Messages
	data["messages"] = list(
		"digest_messages_pred" = digest_messages_pred || GLOB.digest_messages_pred,
		"digest_messages_prey" = digest_messages_prey || GLOB.digest_messages_prey,
		"absorb_messages_owner" = absorb_messages_owner || GLOB.absorb_messages_owner,
		"absorb_messages_prey" = absorb_messages_prey || GLOB.absorb_messages_prey,
		"unabsorb_messages_owner" = unabsorb_messages_owner || GLOB.unabsorb_messages_owner,
		"unabsorb_messages_prey" = unabsorb_messages_prey || GLOB.unabsorb_messages_prey,
		"struggle_messages_outside" = struggle_messages_outside || GLOB.struggle_messages_outside,
		"struggle_messages_inside" = struggle_messages_inside || GLOB.struggle_messages_inside,
		"absorbed_struggle_messages_outside" = absorbed_struggle_messages_outside || GLOB.absorbed_struggle_messages_outside,
		"absorbed_struggle_messages_inside" = absorbed_struggle_messages_inside || GLOB.absorbed_struggle_messages_inside,
		"escape_attempt_messages_owner" = escape_attempt_messages_owner || GLOB.escape_attempt_messages_owner,
		"escape_attempt_messages_prey" = escape_attempt_messages_prey || GLOB.escape_attempt_messages_prey,
		"escape_messages_owner" = escape_messages_owner || GLOB.escape_messages_owner,
		"escape_messages_prey" = escape_messages_prey || GLOB.escape_messages_prey,
		"escape_messages_outside" = escape_messages_outside || GLOB.escape_messages_outside,
		"escape_fail_messages_owner" = escape_fail_messages_owner || GLOB.escape_fail_messages_owner,
		"escape_fail_messages_prey" = escape_fail_messages_prey || GLOB.escape_fail_messages_prey,
	)

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
		if("overlay_path")
			if(value == null)
				overlay_path = null
			else
				var/maybe_path = text2path(value)
				if(ispath(maybe_path, /atom/movable/screen/fullscreen/carrier/vore))
					overlay_path = maybe_path
			for(var/mob/living/prey in src)
				prey.clear_fullscreen("vore", FALSE)
				show_fullscreen(prey)
		if("overlay_color")
			var/new_color = input(usr, "Pick a belly color", "Belly Color", overlay_color) as color|null
			if(new_color)
				overlay_color = new_color
			for(var/mob/living/prey in src)
				prey.clear_fullscreen("vore", FALSE)
				show_fullscreen(prey)
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
		// Messages
		if("digest_messages_pred")
			set_messages("digest_messages_pred", value)
		if("digest_messages_prey")
			set_messages("digest_messages_prey", value)
		if("absorb_messages_owner")
			set_messages("absorb_messages_owner", value)
		if("absorb_messages_prey")
			set_messages("absorb_messages_prey", value)
		if("unabsorb_messages_owner")
			set_messages("unabsorb_messages_owner", value)
		if("unabsorb_messages_prey")
			set_messages("unabsorb_messages_prey", value)
		if("struggle_messages_outside")
			set_messages("struggle_messages_outside", value)
		if("struggle_messages_inside")
			set_messages("struggle_messages_inside", value)
		if("absorbed_struggle_messages_outside")
			set_messages("absorbed_struggle_messages_outside", value)
		if("absorbed_struggle_messages_inside")
			set_messages("absorbed_struggle_messages_inside", value)
		if("escape_attempt_messages_owner")
			set_messages("escape_attempt_messages_owner", value)
		if("escape_attempt_messages_prey")
			set_messages("escape_attempt_messages_prey", value)
		if("escape_messages_owner")
			set_messages("escape_messages_owner", value)
		if("escape_messages_prey")
			set_messages("escape_messages_prey", value)
		if("escape_messages_outside")
			set_messages("escape_messages_outside", value)
		if("escape_fail_messages_owner")
			set_messages("escape_fail_messages_owner", value)
		if("escape_fail_messages_prey")
			set_messages("escape_fail_messages_prey", value)

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
			listening_mob.playsound_local(get_turf(src), preyloop, PREYLOOP_VOLUME, 0, channel = CHANNEL_PREYLOOP)
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
		show_fullscreen(M)
		RegisterSignal(M, COMSIG_MOVABLE_USING_RADIO, PROC_REF(try_deny_radio))
		ADD_TRAIT(M, TRAIT_SOFTSPOKEN, TRAIT_SOURCE_VORE)
		deep_search_prey(M)
		to_chat(M, examine_block("You slide into [span_notice("[owner.parent]")]'s [span_green(lowertext(name))]!\n[EXAMINE_SECTION_BREAK][format_message(desc, M)]"))
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
			sensor_clothing.sensor_mode = SENSOR_OFF
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
		M.clear_fullscreen("vore")
		M.reset_perspective()
		UnregisterSignal(M, COMSIG_MOVABLE_USING_RADIO)
		REMOVE_TRAIT(M, TRAIT_SOFTSPOKEN, TRAIT_SOURCE_VORE)
		// Unabsorb if they leave by any method
		REMOVE_TRAIT(M, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE)
		REMOVE_TRAIT(M, TRAIT_STASIS, TRAIT_SOURCE_VORE)
		// Absorb control handles deleting itself with binding to COMSIG_MOVABLE_MOVED
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
	// Cannot escape on their own if absorbed
	if(HAS_TRAIT_FROM(user, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		return FALSE
	var/mob/living/living_parent = owner.parent
	if(!escape_chance && !living_parent.stat)
		return FALSE
	return TRUE

/obj/vore_belly/container_resist_act(mob/living/user)
	// This sets a hard limit on how often the user can try to escape or squirm
	if(!TIMER_COOLDOWN_FINISHED(user, COOLDOWN_ESCAPE))
		return
	TIMER_COOLDOWN_START(user, COOLDOWN_ESCAPE, COOLDOWN_ESCAPE_TIME)

	var/mob/living/living_parent = owner.parent

	var/escape_attempt_prey_message = span_warning(get_escape_attempt_messages_prey(user))
	var/escape_attempt_owner_message = span_warning(get_escape_attempt_messages_owner(user))
	var/escape_fail_prey_message = span_warning(get_escape_fail_messages_prey(user))
	var/escape_fail_owner_message = span_notice(get_escape_fail_messages_owner(user))

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

	var/struggle_outer_message = span_warning(get_struggle_messages_outside(user))
	var/struggle_user_message = span_warning(get_struggle_messages_inside(user))
	if(HAS_TRAIT_FROM(user, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		struggle_outer_message = span_warning(get_absorbed_struggle_messages_outside(user))
		struggle_user_message = span_warning(get_absorbed_struggle_messages_inside(user))

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
					var/escape_owner_message = span_warning(get_escape_messages_owner(user))
					var/escape_prey_message = span_warning(get_escape_messages_prey(user))

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

/// Plays sound just to pred and prey in this stomach
/obj/vore_belly/proc/play_vore_sound_preypred(preysound, predsound, volume = VORE_SOUND_VOLUME, range = 2, vary = FALSE, pref = /datum/vore_pref/toggle/eating_noises)
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

// Driven by /datum/digest_mode but put here for reusablity
/obj/vore_belly/proc/try_play_gurgle_sound()
	if(COOLDOWN_FINISHED(src, noise_cooldown))
		if(LAZYLEN(contents) && prob(50))
			var/prey_sound = null
			var/pred_sound = null
			if(fancy_sounds)
				prey_sound = "vore_sounds_digestion_fancy_prey"
				pred_sound = "vore_sounds_digestion_fancy"
			else
				prey_sound = "vore_sounds_digestion_classic"
				pred_sound = "vore_sounds_digestion_classic"
			play_vore_sound_preypred(prey_sound, pred_sound, pref = /datum/vore_pref/toggle/digestion_noises)
			COOLDOWN_START(src, noise_cooldown, DIGESTION_NOISE_COOLDOWN)

/mob/proc/wants_vore_fullscreen()
	var/datum/vore_preferences/vore_prefs = get_vore_prefs()
	if(!vore_prefs)
		return FALSE
	if(!vore_prefs.read_preference(/datum/vore_pref/toggle/overlays))
		return FALSE
	return TRUE

/obj/vore_belly/proc/set_fullscreen_overlay(path)
	overlay_path = path

	for(var/mob/M in src)
		M.clear_fullscreen("vore", FALSE)
		show_fullscreen(M)

/obj/vore_belly/proc/show_fullscreen(mob/M)
	if(M.wants_vore_fullscreen() && ispath(overlay_path))
		var/atom/movable/screen/fullscreen/carrier/vore/V = M.overlay_fullscreen("vore", overlay_path)
		if(V.recolorable)
			V.color = overlay_color
