/// Similar to space carp event
/// Has the exact same announcement to mess with the meta of telling it's carps.
/// Dolphins and Manatees however don't path to station, so they will just float harmlessly
/// in the surrounding space
/datum/round_event_control/dolphin_migration
	name = "Dolphin Migration"
	typepath = /datum/round_event/dolphin_migration
	weight = 15
	min_players = 0 // Neutral mobs, no destruction, just spawn whenever
	earliest_start = 10 MINUTES
	max_occurrences = 6
	category = EVENT_CATEGORY_ENTITIES
	description = "Summons a school of harmless space dolphins around the station."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 3

	tags = list(TAG_SPACE, TAG_NEUTRAL)

/datum/round_event/dolphin_migration
	announce_when = 3
	start_when = 50
	/// Most common mob type to spawn
	var/dolphin_type = /mob/living/basic/dolphin
	/// Rarer mob type to spawn
	var/boss_type = /mob/living/basic/dolphin/manatee
	/// What to describe detecting near the station
	var/fluff_signal = /datum/round_event/carp_migration::fluff_signal // Steal directly from the carp event

/datum/round_event/dolphin_migration/announce(fake)
	priority_announce("[fluff_signal] have been detected near [station_name()], please stand-by.", "Lifesign Alert")

/datum/round_event/dolphin_migration/start()
	for(var/obj/effect/landmark/carpspawn/spawn_point in GLOB.landmarks_list)
		if(prob(95))
			new dolphin_type(spawn_point.loc)
		else
			new boss_type(spawn_point.loc)
