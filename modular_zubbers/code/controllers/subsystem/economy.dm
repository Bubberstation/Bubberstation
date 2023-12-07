/datum/controller/subsystem/economy/
	var/list/contributor_guidelines_blacklisted_words = list()
	var/contributor_guidelines_blacklisted_words_formatted


/datum/controller/subsystem/economy/Initialize()

	//Add 6 to 12 things we don't want to remove.
	for(var/i in 12 to 24)
		contributor_guidelines_blacklisted_words[lowertext(pick_list_replacements(ION_FILE, "ionobjects"))] = TRUE

	contributor_guidelines_blacklisted_words_formatted = english_list(
		contributor_guidelines_blacklisted_words,
		nothing_text = "hamburger",
		and_text = " and ",
		comma_text = ", ",
		final_comma_text = ""
	)


	. = ..()