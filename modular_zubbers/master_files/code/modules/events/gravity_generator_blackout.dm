/datum/round_event/gravity_generator_blackout
	announce_when = 3
	start_when = 1
	announce_chance = 100

/datum/round_event/gravity_generator_blackout/announce(fake)
	priority_announce("Feedback surge detected in [station_name()] mass distribution systems. Artificial gravity has been disabled while the system reinitializes. Manual reset of the gravity generator is required.", "[command_name()] Engineering Division", ANNOUNCER_GRAVGENBLACKOUT)
