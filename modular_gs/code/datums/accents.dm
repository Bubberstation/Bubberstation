/datum/accent/kitty/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/taja_purr = new("r+", "g")
	var/static/regex/taja_puRR = new("R+", "g")
	if(message[1] != "*")
		message = taja_purr.Replace(message, "rrr")
		message = taja_puRR.Replace(message, "Rrr")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args
