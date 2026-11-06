GAME_VERB_PROC(/client, cmd_mentor_dementor, "Dementor", "Mentor")
	if(!is_mentor())
		return
	remove_mentor_verbs()
	if (/client/proc/mentor_unfollow in verbs)
		mentor_unfollow()
	GLOB.mentors -= src
	to_chat(src, span_interface("You are no longer a mentor."))
	log_mentor("MENTOR: [src] dementored.")
	ASSIGN_GAME_VERB(src, /client, cmd_mentor_rementor)

GAME_VERB_PROC(/client, cmd_mentor_rementor, "Rementor", "Mentor")
	if(!is_mentor())
		return
	add_mentor_verbs()
	GLOB.mentors[src] = TRUE
	to_chat(src, span_interface("You are now a mentor."))
	log_mentor("MENTOR: [src] rementored.")
	UNASSIGN_GAME_VERB(src, /client, cmd_mentor_rementor)
