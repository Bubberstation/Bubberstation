/datum/controller/subsystem/storytellers
	var/list/currently_polling = list()

/datum/controller/subsystem/storytellers/proc/ask_crew_for_goals(
	question_text,
	list/goal_list,
	poll_time = 30 SECONDS,
	list/group = null,
	ignore_category = null
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

	var/datum/storyteller_poll/new_poll = new(question_text, poll_time, ignore_category)
	new_poll.goal_options = goal_list.Copy()
	for(var/goal in new_poll.goal_options)
		new_poll.votes[goal] = list()
	LAZYADD(currently_polling, new_poll)

	for(var/mob/candidate_mob as anything in group)
		if(!candidate_mob.client)
			continue
		if(ignore_category && (candidate_mob.ckey in GLOB.poll_ignore[ignore_category]))
			continue
		if(!is_eligible(candidate_mob, null, null, ignore_category))
			continue


		var/custom_link_style_start = "<style>a:visited{color:Crimson !important}</style>"
		var/custom_link_style_end = "style='color:DodgerBlue;font-weight:bold;-dm-text-outline: 1px black'"

		var/act_choices = ""
		for(var/goal in goal_list)
			act_choices += "[custom_link_style_start]<a href='byond://?src=[REF(new_poll)];select_goal=[goal];mob_ref=[REF(candidate_mob)]'[custom_link_style_end]>\[[goal]\]</a> "

		var/act_never = ""
		if(ignore_category)
			act_never = "[custom_link_style_start]<a href='byond://?src=[REF(new_poll)];never=1;mob_ref=[REF(candidate_mob)]'[custom_link_style_end]>\[Never For This Round\]</a>"

		if(!duplicate_message_check(new_poll))
			var/final_message = "<span style='font-size:1.2em'>[span_ooc(question_text)]</span>\n[act_choices][act_never]"
			to_chat(candidate_mob, final_message)
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

/datum/storyteller_poll/New(question, poll_time, ignore_category)
	src.question = question
	src.duration = poll_time
	src.start_time = world.time
	src.ignore_category = ignore_category
	poll_key = "storyteller_[ckey(question)]_poll"

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
