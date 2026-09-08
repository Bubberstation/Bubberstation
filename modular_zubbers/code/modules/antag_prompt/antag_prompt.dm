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
		log_antag_tickets("Antag prompt for [cast_control.name] showed [length(decoy_candidates)] candidate(s) a decoy [decoy_flag] prompt.")
		INVOKE_ASYNC(src, PROC_REF(run_prompt), decoy_candidates, decoy_flag, poll_time)

	var/list/accepted = run_prompt(real_candidates, cast_control.antag_flag, poll_time)
	log_antag_tickets("Antag prompt for [cast_control.name]: [length(real_candidates)] prompted, [length(accepted)] accepted.")
	return accepted

/// Runs a single prompt and returns everyone who signed up. The decoy prompt throws its result away.
/datum/round_event/antagonist/proc/run_prompt(list/group, role_flag, poll_time)
	if(!length(group))
		return list()
	// Worded off the antag flag so a real and a decoy prompt read identically.
	var/list/signed_up = SSpolling.poll_candidates(
		role = role_flag,
		check_jobban = role_flag,
		poll_time = poll_time,
		ignore_category = ANTAG_PROMPT_IGNORE_CATEGORY,
		group = group,
		role_name_text = LOWER_TEXT(role_flag),
		announce_chosen = FALSE,
		show_candidate_amount = FALSE,
	)
	return signed_up || list()

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
		// A decoy nobody in the pool could have been polled for gives itself away.
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

/// Prompt only once the round is live; cast_control.roundstart only marks roundstart eligibility, and such events still fire midround.
/datum/round_event/antagonist/proc/should_prompt_candidates(datum/round_event_control/antagonist/cast_control)
	return CONFIG_GET(flag/antag_prompt_enabled) && SSticker.HasRoundStarted()
