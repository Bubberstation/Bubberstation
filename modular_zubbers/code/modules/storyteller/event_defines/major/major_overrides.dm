/datum/round_event_control/earthquake
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/meteor_wave
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL, TAG_SPACE, TAG_DESTRUCTIVE, TAG_CHAOTIC)
	weight = 10
	max_occurrences = 1

/datum/round_event_control/meteor_wave/meaty
	weight = 15
	max_occurrences = 1

/datum/round_event_control/meteor_wave/threatening
	weight = 3

/datum/round_event_control/meteor_wave/catastrophic
	weight = 0

/datum/round_event_control/immovable_rod
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)
	weight = 20

/datum/round_event_control/stray_cargo/changeling_zombie
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_CHAOTIC, TAG_SPOOKY)

/datum/round_event_control/cortical_borer
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_TARGETED, TAG_SPOOKY)
	min_players = 20
