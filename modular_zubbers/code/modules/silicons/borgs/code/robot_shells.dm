///same as /mob/living/silicon/ai/compose_track_href but for shells
/mob/living/silicon/robot/shell/compose_track_href(atom/movable/speaker, namepart)
	var/mob/M = speaker.GetSource()
	if(M)
		return "<a href='?src=[REF(src)];track=[html_encode(namepart)]'>"
	return ""

///same as /mob/living/silicon/ai/compose_job but for shells
/mob/living/silicon/robot/shell/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	//Also includes the </a> for AI shell hrefs, for convenience.
	return "[radio_freq ? " (" + speaker.GetJob() + ")" : ""]" + "[speaker.GetSource() ? "</a>" : ""]"

///actually gives the text button functionality
/mob/living/silicon/robot/shell/Topic(href, href_list)
	. = ..()
	if(href_list["track"])
		if(!isAI(src) && !istype(src, /mob/living/silicon/robot/shell))
			return
		if(!can_track(href_list["track"]))
			to_chat(src, span_info("This person is not currently on cameras."))
			return
		var/mob/living/silicon/ai/AI
		if(!isAI(src))
			AI = src.mainframe
			AI.deployed_shell.undeploy()
		else
			AI = src

		AI.ai_tracking_tool.track_name(src, href_list["track"])
