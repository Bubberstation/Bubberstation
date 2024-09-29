// Note: This is terrible and permanently disables tts without fixing the underlying issue
// I'm only moving changes to modular en masse, not fixing the lines of shitcode, if you see this and have the 5 minutes:
// FIX THIS PLEASE
// Waterpig~
/datum/controller/subsystem/tts/establish_connection_to_tts()
	message_admins("a naughty admin was prevented from hanging the server sending an external query.")
	return
