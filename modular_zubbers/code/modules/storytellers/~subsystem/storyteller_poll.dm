/datum/controller/subsystem/storytellers
	var/list/currently_polling = list()

/datum/controller/subsystem/storytellers/proc/ask_crew_for_goals(
	question_text,
	list/goal_list,
	poll_time = 30 SECONDS,
	list/group = null,
	ignore_category = null,
	alert_pic
)
	if(!question_text || !length(goal_list))
		return list()

	if(isnull(group))
		group = list()
		for(var/mob/living/L in GLOB.alive_player_list)
			if(!L.client || !L.mind || L.stat == DEAD)
				continue
			group += L

	if(!length(group))
		return list()

	log_ghost_poll("Storyteller goal poll started.", data = list(
		"poll question" = question_text,
		"poll duration" = DisplayTimeText(poll_time),
	))

	var/datum/storyteller_poll/new_poll = new(question_text, poll_time, ignore_category)
	new_poll.goal_options = goal_list.Copy()
	for(var/goal in new_poll.goal_options)
		new_poll.votes[goal] = list()
	LAZYADD(currently_polling, new_poll)

	var/category = "[new_poll.poll_key]_poll_alert"

	for(var/mob/candidate_mob as anything in group)
		if(!candidate_mob.client)
			continue
		// Skip ghost_roles pref check since this is for alive crew, not ghosts.
		// if(!candidate_mob.client.prefs.read_preference(/datum/preference/toggle/ghost_roles))
		// 	continue
		// Skip admin opt-out since this is for crew.
		// if((!candidate_mob.client.prefs.read_preference(/datum/preference/toggle/ghost_roles_as_admin)) && candidate_mob.client.holder)
		// 	continue
		if(!is_eligible(candidate_mob, null, null, ignore_category))
			continue

		window_flash(candidate_mob.client)

		// If we somehow send two polls for the same type, but with a duration on the second one shorter than the time left on the first one,
		// we need to keep the first one's timeout rather than use the shorter one
		var/atom/movable/screen/alert/poll_alert/current_alert = LAZYACCESS(candidate_mob.alerts, category)
		var/alert_time = poll_time
		var/datum/storyteller_poll/alert_poll = new_poll
		if(current_alert && current_alert.timeout > (world.time + poll_time - world.tick_lag))
			alert_time = current_alert.timeout - world.time + world.tick_lag
			alert_poll = current_alert.poll

		// Send them an on-screen alert
		var/atom/movable/screen/alert/poll_alert/storyteller/poll_alert_button = candidate_mob.throw_alert(category, /atom/movable/screen/alert/poll_alert/storyteller, timeout_override = alert_time, no_anim = TRUE)
		if(!poll_alert_button)
			continue

		new_poll.alert_buttons += poll_alert_button
		new_poll.RegisterSignal(poll_alert_button, COMSIG_QDELETING, TYPE_PROC_REF(/datum/storyteller_poll, clear_alert_ref))

		poll_alert_button.icon = ui_style2icon(candidate_mob.client?.prefs?.read_preference(/datum/preference/choiced/ui_style))
		poll_alert_button.desc = "[question_text]"
		poll_alert_button.show_time_left = TRUE
		poll_alert_button.storyteller_poll = alert_poll
		poll_alert_button.set_role_overlay()
		poll_alert_button.update_stacks_overlay()
		poll_alert_button.update_candidates_number_overlay()
		poll_alert_button.update_signed_up_overlay()

		// Image to display (optional, set to null or provide an alert_pic if needed)
		var/image/poll_image
		if(ispath(alert_pic, /atom) || isatom(alert_pic))
			poll_image = new /mutable_appearance(alert_pic)
			poll_image.pixel_z = 0
		else if(!isnull(alert_pic))
			poll_image = null
		else
			poll_image = image('icons/effects/effects.dmi', icon_state = "static")

		if(poll_image)
			poll_image.layer = FLOAT_LAYER
			poll_image.plane = poll_alert_button.plane
			poll_alert_button.add_overlay(poll_image)

		// Chat message
		var/act_jump = ""
		var/custom_link_style_start = "<style>a:visited{color:Crimson !important}</style>"
		var/custom_link_style_end = "style='color:DodgerBlue;font-weight:bold;-dm-text-outline: 1px black'"
		var/act_choices = ""
		for(var/goal in goal_list)
			act_choices += "[custom_link_style_start]<a href='byond://?src=[REF(new_poll)];select_goal=[goal];mob_ref=[REF(candidate_mob)]'[custom_link_style_end]>\[[goal]\]</a> "
		var/act_never = ""
		if(ignore_category)
			act_never = "[custom_link_style_start]<a href='byond://?src=[REF(new_poll)];never=1;mob_ref=[REF(candidate_mob)]'[custom_link_style_end]>\[Never For This Round\]</a>"

		if(!duplicate_message_check(alert_poll)) //Only notify people once. They'll notice if there are multiple and we don't want to spam people.

			// ghost poll prompt sound handling (adapted for crew, enable if desired)
			var/polling_sound_pref = candidate_mob.client?.prefs.read_preference(/datum/preference/choiced/sound_ghost_poll_prompt)
			var/polling_sound_volume = candidate_mob.client?.prefs.read_preference(/datum/preference/numeric/sound_ghost_poll_prompt_volume)
			if(polling_sound_pref != GHOST_POLL_PROMPT_DISABLED && polling_sound_volume)
				var/polling_sound
				if(polling_sound_pref == GHOST_POLL_PROMPT_1)
					polling_sound = 'sound/misc/prompt1.ogg'
				else
					polling_sound = 'sound/misc/prompt2.ogg'
				SEND_SOUND(candidate_mob, sound(polling_sound, volume = polling_sound_volume))

			var/surrounding_icon
			// if(chat_text_border_icon) // Add if a border icon is desired
			//	var/image/surrounding_image
			//	if(!ispath(chat_text_border_icon))
			//		var/mutable_appearance/border_image = chat_text_border_icon
			//		surrounding_image = border_image
			//	else
			//		surrounding_image = image(chat_text_border_icon)
			//	surrounding_icon = icon2html(surrounding_image, candidate_mob, extra_classes = "bigicon")
			var/final_message =  boxed_message("<span style='text-align:center;display:block'>[surrounding_icon] <span style='font-size:1.2em'>[span_ooc(question_text)]</span> [surrounding_icon]\n[act_jump]      [act_choices]      [act_never]</span>")
			to_chat(candidate_mob, final_message)

		// Start processing it so it updates visually the timer
		START_PROCESSING(SSprocessing, poll_alert_button)

	// Sleep until the time is up
	UNTIL(new_poll.finished)
	new_poll.trim_votes()

	return new_poll.votes


/datum/storyteller_poll
	var/poll_key = "storyteller_goal"
	var/question
	var/start_time
	var/duration
	var/finished = FALSE
	var/ignore_category
	var/list/goal_options = list()
	var/list/votes = list()
	var/list/alert_buttons = list()

/datum/storyteller_poll/New(question, poll_time, ignore_category)
	src.question = question
	src.duration = poll_time
	src.start_time = world.time
	src.ignore_category = ignore_category
	poll_key = "storyteller_[ckey(question)]_poll"
	addtimer(CALLBACK(SSstorytellers, PROC_REF(polling_finished), src), duration)

/datum/storyteller_poll/proc/time_left()
	return max(0, start_time + duration - world.time)

/datum/storyteller_poll/proc/trim_votes()
	// Trim ineligible voters.
	for(var/goal in votes)
		var/list/voters = votes[goal]
		if(!islist(voters))
			continue
		for(var/mob/M in voters.Copy())
			if(!SSstorytellers.is_eligible(M, null, null, ignore_category))
				voters -= M

/datum/storyteller_poll/proc/clear_alert_ref(datum/source)
	alert_buttons -= source

/datum/storyteller_poll/proc/polling_finished()

/datum/storyteller_poll/Topic(href, list/href_list)
	. = ..()
	var/mob/usr_mob = locate(href_list["mob_ref"])
	if(!usr_mob || !usr_mob.client || time_left() <= 0)
		return

	if(href_list["select_goal"])
		var/goal = href_list["select_goal"]
		if(!(goal in goal_options))
			return
		// Prevent duplicate votes but allow changing vote
		for(var/other_goal in votes)
			votes[other_goal] -= usr_mob
		votes[goal] += usr_mob
		to_chat(usr_mob, span_notice("You voted for [goal]."))
		for(var/atom/movable/screen/alert/poll_alert/linked_button as anything in alert_buttons)
			linked_button.update_candidates_number_overlay()

	if(href_list["never"])
		if(ignore_category)
			GLOB.poll_ignore[ignore_category] |= usr_mob.ckey
		to_chat(usr_mob, span_notice("You will no longer be considered for this poll category this round."))

/datum/controller/subsystem/storytellers/proc/polling_finished(datum/storyteller_poll/finishing_poll)
	currently_polling -= finishing_poll
	finishing_poll.finished = TRUE
	QDEL_IN(finishing_poll, 0.5 SECONDS)

/datum/controller/subsystem/storytellers/proc/duplicate_message_check(datum/storyteller_poll/poll_to_check)
	for(var/datum/storyteller_poll/running_poll as anything in currently_polling)
		if((running_poll.poll_key == poll_to_check.poll_key && running_poll != poll_to_check) && running_poll.time_left() > 0)
			return TRUE
	return FALSE

/datum/controller/subsystem/storytellers/proc/is_eligible(mob/potential_candidate, role, check_jobban, the_ignore_category)
	if(isnull(potential_candidate.key) || isnull(potential_candidate.client))
		return FALSE
	if(the_ignore_category)
		if(potential_candidate.ckey in GLOB.poll_ignore[the_ignore_category])
			return FALSE
	return TRUE

/atom/movable/screen/alert/poll_alert/storyteller
	name = "Storyteller Poll Alert"
	var/datum/storyteller_poll/storyteller_poll = null

/atom/movable/screen/alert/poll_alert/storyteller/Initialize(mapload)
	. = ..()

/atom/movable/screen/alert/poll_alert/storyteller/set_role_overlay()
	var/role_or_only_question = storyteller_poll?.question ? copytext(storyteller_poll.question, 1, 25) : "Vote?"
	role_overlay = new
	role_overlay.screen_loc = screen_loc
	role_overlay.maptext = MAPTEXT("<span style='text-align: right; color: #B3E3FC'>[full_capitalize(role_or_only_question)]</span>")
	role_overlay.maptext_width = 128
	role_overlay.transform = role_overlay.transform.Translate(-128, 0)
	add_overlay(role_overlay)

/atom/movable/screen/alert/poll_alert/storyteller/Click(location, control, params)
	SHOULD_CALL_PARENT(FALSE)
	if(!usr || !GET_CLIENT(usr) || usr != owner)
		return FALSE
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		to_chat(usr, boxed_message(jointext(examine(usr), "\n")))
		return FALSE
	if(!storyteller_poll)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK) && storyteller_poll.ignore_category)
		set_never_round()
		return
	handle_vote()

/atom/movable/screen/alert/poll_alert/storyteller/proc/handle_vote()
	if(!storyteller_poll || storyteller_poll.time_left() <= 0)
		to_chat(owner, span_danger("Sorry, the poll has ended!"))
		SEND_SOUND(owner, 'sound/machines/buzz/buzz-sigh.ogg')
		return FALSE

	var/list/options = storyteller_poll.goal_options.Copy()
	if(storyteller_poll.ignore_category)
		options += "Never for this round"

	var/goal = tgui_input_list(owner, "Choose a goal to vote for", "Storyteller Poll", options)
	if(!goal)
		return

	if(goal == "Never for this round")
		if(storyteller_poll.ignore_category)
			GLOB.poll_ignore[storyteller_poll.ignore_category] |= owner.ckey
			to_chat(owner, span_notice("You will no longer be considered for this poll category this round."))
		return

	// Change vote or set new
	for(var/other_goal in storyteller_poll.votes)
		storyteller_poll.votes[other_goal] -= owner
	storyteller_poll.votes[goal] += owner
	to_chat(owner, span_notice("You voted for [goal]."))
	update_voted_overlay()

/atom/movable/screen/alert/poll_alert/storyteller/set_never_round()
	if(!storyteller_poll?.ignore_category)
		return
	var/category = storyteller_poll.ignore_category
	if(!(owner.ckey in GLOB.poll_ignore[category]))
		GLOB.poll_ignore[category] |= owner.ckey
		color = "red"
		to_chat(owner, span_notice("You will no longer be considered for [category] polls this round."))
	else
		GLOB.poll_ignore[category] -= owner.ckey
		color = initial(color)
		to_chat(owner, span_notice("You will again be considered for [category] polls this round."))
	update_voted_overlay()

/atom/movable/screen/alert/poll_alert/storyteller/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_LMB] = "Vote Poll"
	if(storyteller_poll?.ignore_category)
		var/selected_never = (owner.ckey in GLOB.poll_ignore[storyteller_poll.ignore_category])
		context[SCREENTIP_CONTEXT_ALT_LMB] = selected_never ? "Cancel Never" : "Never For This Round"
	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/alert/poll_alert/storyteller/update_signed_up_overlay()
	update_voted_overlay()

/atom/movable/screen/alert/poll_alert/storyteller/proc/update_voted_overlay()
	cut_overlay(signed_up_overlay)
	if(storyteller_poll && has_voted(owner))
		add_overlay(signed_up_overlay)

/atom/movable/screen/alert/poll_alert/storyteller/proc/has_voted(mob/check_mob)
	if(!storyteller_poll)
		return FALSE
	for(var/goal in storyteller_poll.votes)
		var/list/voters = storyteller_poll.votes[goal]
		if(check_mob in voters)
			return TRUE
	return FALSE

/atom/movable/screen/alert/poll_alert/storyteller/update_candidates_number_overlay()
	return

/atom/movable/screen/alert/poll_alert/storyteller/update_stacks_overlay()
	return

/atom/movable/screen/alert/poll_alert/storyteller/handle_sign_up()
	handle_vote()

/atom/movable/screen/alert/poll_alert/storyteller/jump_to_jump_target()
	return

/atom/movable/screen/alert/poll_alert/storyteller/Topic(href, href_list)
	return
