/// The max amount of options someone can have in a custom vote.
#define MAX_CUSTOM_VOTE_OPTIONS 10

/datum/vote/custom_vote
	name = "Custom"
	default_message = "Click here to start a custom vote."

// Custom votes ares always accessible.
/datum/vote/custom_vote/is_accessible_vote()
	return TRUE

/datum/vote/custom_vote/reset()
	default_choices = null
	override_question = null
	count_method = VOTE_COUNT_METHOD_SINGLE
	return ..()

/datum/vote/custom_vote/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .
	if(forced)
		return .

	// Custom votes can only be created if they're forced to be made.
	// (Either an admin makes it, or otherwise.)
	return "Only admins can create custom votes."

/datum/vote/custom_vote/create_vote(mob/vote_creator)
	var/custom_count_method = tgui_input_list(
		user = vote_creator,
		message = "Single, multiple, or ranked choice?", // BUBBER EDIT CHANGE - Ranked Choice Voting - Original: "Single or multiple choice?"
		title = "Choice Method",
		items = list("Single", "Multiple", "Ranked"), // BUBBER EDIT CHANGE - Ranked Choice Voting - Original: ("Single", "Multiple")
		default = "Single",
	)
	switch(custom_count_method)
		if("Single")
			count_method = VOTE_COUNT_METHOD_SINGLE
		if("Multiple")
			count_method = VOTE_COUNT_METHOD_MULTI
		// BUBBER EDIT ADDITION BEGIN - Ranked Choice Voting
		if("Ranked")
			count_method = VOTE_COUNT_METHOD_RANKED
			// Ask for the threshold if it's ranked voting
			var/threshold = tgui_input_number(
				user = vote_creator,
				message = "Set the victory threshold percentage (1-100)",
				title = "Ranked Choice Threshold",
				default = 50,
				min_value = 1,
				max_value = 100
			)
			if(isnull(threshold))
				return FALSE
			ranked_winner_threshold = threshold
		// BUBBER EDIT ADDITION END
		if(null)
			return FALSE
		else
			stack_trace("Got '[custom_count_method]' in create_vote() for custom voting.")
			to_chat(vote_creator, span_boldwarning("Unknown choice method. Contact a coder."))
			return FALSE

	var/custom_win_method = tgui_input_list(
		user = vote_creator,
		message = "How should the vote winner be determined?",
		title = "Winner Method",
		items = list("Simple", "Weighted Random", "Ranked", "No Winner"), // BUBBER EDIT CHANGE - Ranked Choice Voting - Original: ("Simple", "Weighted Random", "No Winner")
		default = "Simple",
	)
	switch(custom_win_method)
		if("Simple")
			winner_method = VOTE_WINNER_METHOD_SIMPLE
		if("Weighted Random")
			winner_method = VOTE_WINNER_METHOD_WEIGHTED_RANDOM
		// BUBBER EDIT ADDITION BEGIN - Ranked Choice Voting
		if("Ranked")
			winner_method = VOTE_WINNER_METHOD_RANKED
		// BUBBER EDIT ADDITION END
		if("No Winner")
			winner_method = VOTE_WINNER_METHOD_NONE
		if(null)
			return FALSE
		else
			stack_trace("Got '[custom_win_method]' in create_vote() for custom voting.")
			to_chat(vote_creator, span_boldwarning("Unknown winner method. Contact a coder."))
			return FALSE

	var/display_stats = tgui_alert(
		vote_creator,
		"Should voting statistics be public?",
		"Show voting stats?",
		list("Yes", "No"),
	)

	if(isnull(display_stats))
		return FALSE
	display_statistics = display_stats == "Yes"

	override_question = tgui_input_text(vote_creator, "What is the vote for?", "Custom Vote")
	if(!override_question)
		return FALSE

	default_choices = list()
	for(var/i in 1 to MAX_CUSTOM_VOTE_OPTIONS)
		var/option = tgui_input_text(vote_creator, "Please enter an option, or hit cancel to finish. [MAX_CUSTOM_VOTE_OPTIONS] max.", "Options", max_length = MAX_NAME_LEN)
		if(!vote_creator?.client)
			return FALSE
		if(!option)
			break

		default_choices += capitalize(option)

	if(!length(default_choices))
		return FALSE
	// Sanity for all the tgui input stalling we are doing
	if(isnull(vote_creator.client?.holder))
		return FALSE

	return ..()

/datum/vote/custom_vote/initiate_vote(initiator, duration)
	. = ..()
	. += "\n[override_question]"

#undef MAX_CUSTOM_VOTE_OPTIONS
