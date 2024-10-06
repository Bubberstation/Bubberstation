/datum/round_event/gravity_generator_blackout
	announce_when = 3
	start_when = 1
	announce_chance = 100

/datum/round_event/gravity_generator_blackout/announce(fake)
	priority_announce("Feedback surge detected in [station_name()] mass distribution systems. Manual reset of the gravity generator is required.", "Anomaly Alert", ANNOUNCER_GRAVGENBLACKOUT)
