/datum/round_event_control/earthquake
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/bureaucratic_error
	track = EVENT_TRACK_MAJOR // Yes, it's annoying.
	tags = list(TAG_COMMUNAL)
	weight = 5

/datum/round_event_control/blob
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT, TAG_CHAOTIC)
	weight = 10
	min_players = 50 //previously 20.

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

/datum/round_event_control/radiation_storm
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL)

/datum/round_event_control/wormholes
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL)

/datum/round_event_control/immovable_rod
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)
	weight = 20

/datum/round_event_control/anomaly/anomaly_vortex
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/anomaly/anomaly_pyro
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/revenant
	min_players = 20
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_SPOOKY)

/datum/round_event_control/abductor
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CHAOTIC)

/datum/round_event_control/fugitives
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMBAT)

/datum/round_event_control/cme
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_COMMUNAL, TAG_CHAOTIC)

/datum/round_event_control/stray_cargo/changeling_zombie
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_CHAOTIC, TAG_SPOOKY)

/datum/round_event_control/pirates
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL, TAG_COMBAT)

/datum/round_event_control/cortical_borer
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_TARGETED, TAG_SPOOKY)
	min_players = 20

/datum/round_event_control/morph
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_SPOOKY)

