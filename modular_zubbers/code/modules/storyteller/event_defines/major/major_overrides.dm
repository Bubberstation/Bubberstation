/datum/round_event_control/earthquake
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/bureaucratic_error
	track = EVENT_TRACK_MAJOR // Yes, it's annoying.
	tags = list(TAG_COMMUNAL)
	weight = 5

/datum/round_event_control/blob
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT)
	weight = 10

/datum/round_event_control/meteor_wave
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMMUNAL, TAG_SPACE, TAG_DESTRUCTIVE)
	weight = 10

/datum/round_event_control/meteor_wave/meaty
	weight = 15

/datum/round_event_control/meteor_wave/ices
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

/datum/round_event_control/stray_meteor
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_SPACE)
	weight = 25

/datum/round_event_control/anomaly/anomaly_vortex
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/anomaly/anomaly_pyro
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE)

/datum/round_event_control/spider_infestation
	track = EVENT_TRACK_ROLESET
	tags = list(TAG_COMBAT)
