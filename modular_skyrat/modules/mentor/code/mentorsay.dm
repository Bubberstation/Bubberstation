GAME_VERB_PROC(/client, cmd_mentor_say, "Msay", "Mentor", msg as text)
	if(!is_mentor())
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	msg = emoji_parse(msg)
	log_mentor("MSAY: [key_name(src)] : [msg]")

	if(check_rights_for(src, R_ADMIN,0))
		msg = span_mentor("<b><font color ='#8A2BE2'><span class='prefix'>MENTOR:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>")
	else
		msg = span_mentor("<b><font color ='#E236D8'><span class='prefix'>MENTOR:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>")
	to_chat(GLOB.admins | GLOB.mentors, msg)
