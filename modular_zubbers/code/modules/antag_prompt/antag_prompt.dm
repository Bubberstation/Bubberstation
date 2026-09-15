/// Prompts candidates for this antagonist roll and returns the ones who accepted.
/datum/round_event/antagonist/proc/prompt_candidates(datum/round_event_control/antagonist/cast_control, list/candidates)
	if(!length(candidates))
		return list()

	var/list/real_candidates = candidates.Copy()
	if(!CONFIG_GET(flag/antag_prompt_poll_everyone))
		real_candidates = pick_candidates_by_tickets(real_candidates, antag_count)

	var/list/decoy_candidates = list()
	var/list/believable = list()
	var/decoy_flag
	var/fake_chance = CONFIG_GET(number/antag_prompt_fake_chance)
	// Don't want decoys to fuckup things when there's too few people
	var/decoy_headroom = length(real_candidates) - antag_count
	var/datum/round_event_control/antagonist/decoy_control = (fake_chance > 0 && decoy_headroom > 0) ? get_decoy_control(cast_control, real_candidates, believable) : null
	if(decoy_control)
		decoy_flag = decoy_control.antag_flag
		// Split decoys out before the real poll so they can never be picked for it.
		for(var/mob/candidate as anything in believable)
			if(decoy_headroom <= 0)
				break
			if(!prob(fake_chance))
				continue
			real_candidates -= candidate
			decoy_candidates += candidate
			decoy_headroom--

	var/poll_time = CONFIG_GET(number/antag_prompt_time) SECONDS
	if(length(decoy_candidates))
		INVOKE_ASYNC(src, PROC_REF(run_decoy_prompt), decoy_candidates, decoy_flag, poll_time)

	var/prompted = length(real_candidates)
	var/list/accepted = run_prompt(real_candidates, cast_control.antag_flag, poll_time)
	// Both polls start together and last the same time, so this waits a tick at most.
	if(length(decoy_candidates))
		var/deadline = world.time + 10 SECONDS
		UNTIL(decoy_finished || world.time > deadline)

	log_antag_tickets("Antag prompt for [cast_control.name] ([cast_control.antag_flag]): [prompted] prompted, [length(accepted)] accepted, [prompted - length(accepted)] declined. Decoy [decoy_flag || "none"]: [length(decoy_candidates)] prompted, [length(decoy_accepted)] accepted.")
	SSblackbox.record_feedback("associative", "antag_prompt", 1, list(
		"antag" = cast_control.antag_flag,
		"eligible" = length(candidates),
		"needed" = antag_count,
		"prompted" = prompted,
		"accepted" = length(accepted),
		"decoy_antag" = decoy_flag || "none",
		"decoy_prompted" = length(decoy_candidates),
		"decoy_accepted" = length(decoy_accepted),
	))
	return accepted

/// Set by the decoy prompt so the real poll can report both in one log line.
/datum/round_event/antagonist/var/list/decoy_accepted
/datum/round_event/antagonist/var/decoy_finished = FALSE

/datum/round_event/antagonist/proc/run_decoy_prompt(list/group, decoy_flag, poll_time)
	decoy_accepted = run_prompt(group, decoy_flag, poll_time)
	decoy_finished = TRUE

/// Runs a single prompt and returns everyone who signed up.
/datum/round_event/antagonist/proc/run_prompt(list/group, role_flag, poll_time)
	if(!length(group))
		return list()
	var/icon/preview = get_antag_prompt_icon(role_flag)
	var/list/signed_up = SSpolling.poll_candidates(
		role = ignoring_antag_prefs() ? null : role_flag,
		check_jobban = role_flag,
		poll_time = poll_time,
		ignore_category = ANTAG_PROMPT_IGNORE_CATEGORY,
		group = group,
		alert_pic = preview ? image(preview) : null,
		role_name_text = LOWER_TEXT(role_flag),
		chat_text_border_icon = preview,
		announce_chosen = FALSE,
		show_candidate_amount = FALSE,
	)
	return signed_up || list()

/proc/get_antag_prompt_icon(antag_flag)
	RETURN_TYPE(/icon)
	var/static/list/cached_icons = list()
	var/icon/cached = cached_icons[antag_flag]
	if(isnull(cached))
		var/datum/asset/spritesheet_batched/antagonists/sheet = get_asset_datum(/datum/asset/spritesheet_batched/antagonists)
		var/datum/universal_icon/preview = LAZYACCESS(sheet?.antag_icons, serialize_antag_name(antag_flag))
		if(isnull(preview))
			return null
		// Copy first, the sheet's icons are shared with the preferences UI.
		var/datum/universal_icon/scaled = preview.copy()
		scaled.scale(ICON_SIZE_X, ICON_SIZE_Y)
		cached = scaled.to_icon()
		cached_icons[antag_flag] = cached
	return cached

/// Picks an antagonist that could have rolled but isn't the one that did, filling `believable` with the pollees it would really have polled.
/datum/round_event/antagonist/proc/get_decoy_control(datum/round_event_control/antagonist/real_control, list/pool, list/believable)
	var/list/options = list()
	var/list/seen_flags = list()
	for(var/datum/round_event_control/antagonist/possible_control in SSgamemode.event_pools[real_control.track])
		if(isnull(possible_control.antag_flag))
			continue
		if(possible_control.antag_flag == real_control.antag_flag)
			continue
		if(possible_control.antag_datum && possible_control.antag_datum == real_control.antag_datum)
			continue
		if(possible_control.antag_flag in seen_flags)
			continue
		seen_flags += possible_control.antag_flag
		options += possible_control

	while(length(options))
		var/datum/round_event_control/antagonist/decoy = pick_n_take(options)
		var/list/audience = pool & decoy.get_candidates()
		if(!length(audience))
			continue
		believable += audience
		return decoy
	return null

/// Trims a candidate list down to `amount` people, weighted by their antag tickets.
/datum/round_event/antagonist/proc/pick_candidates_by_tickets(list/candidates, amount)
	if(amount <= 0 || length(candidates) <= amount)
		return candidates
	var/list/weighted = candidates_to_tickets(candidates)
	var/list/picked = list()
	while(length(picked) < amount && length(weighted))
		var/mob/candidate = pick_weight(weighted)
		weighted -= candidate
		picked += candidate
	return picked

/datum/round_event/antagonist/proc/should_prompt_candidates(datum/round_event_control/antagonist/cast_control)
	return CONFIG_GET(flag/antag_prompt_enabled) && SSticker.HasRoundStarted()

/proc/ignoring_antag_prefs()
	return CONFIG_GET(flag/antag_prompt_polls_regardless_of_prefs) && CONFIG_GET(flag/antag_prompt_enabled) && SSticker.HasRoundStarted()
