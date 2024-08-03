// A point is added every 2 seconds, adjust new track threshold overrides accordingly

/// Storyteller track data, for easy overriding of tracks without having to copypaste
/// thresholds - Used to show how many points the track has to collect before it triggers, lower means faster
/datum/storyteller_data/tracks
	var/threshold_mundane = 300
	var/threshold_moderate = 800
	var/threshold_major = 2800
	var/threshold_crewset = 800
	var/threshold_ghostset = 2800
