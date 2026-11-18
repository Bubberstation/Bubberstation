GAME_VERB_DESC(/client, clear_poll_ignores, "Clear Poll Ignores", "Undo every \"Never For This Round\" choice you have made.", "OOC")
	var/list/cleared = list()
	for(var/ignore_category in GLOB.poll_ignore)
		var/list/ignored = GLOB.poll_ignore[ignore_category]
		if(!(ckey in ignored))
			continue
		ignored -= ckey
		cleared += GLOB.poll_ignore_desc[ignore_category] || ignore_category

	if(!length(cleared))
		to_chat(src, span_warning("You are not ignoring any polls."))
		return
	to_chat(src, span_notice("No longer ignoring: [english_list(cleared)]. You will be asked about these again."))
