// A point is added every second, adjust new track threshold overrides accordingly

/// Storyteller track data, for easy overriding of tracks without having to copypaste
/// thresholds - Used to show how many points the track has to collect before it triggers, lower means faster
/datum/storyteller_data/tracks
	var/threshold_mundane = 1200
	var/threshold_moderate = 1800
	var/threshold_major = 8000
	var/threshold_crewset = 1200
	var/threshold_ghostset = 7000
