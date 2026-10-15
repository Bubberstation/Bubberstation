/datum/round_event_control/anomaly/anomaly_metacarp
	name = "Anomaly: Metacarp Entity"
	typepath = /datum/round_event/anomaly/anomaly_metacarp

	min_players = 18
	max_occurrences = 5
	weight = 10
	description = "Spawns an anomalous carp that spawns in more carp."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 2
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/anomaly/anomaly_metacarp
	start_when = ANOMALY_START_MEDIUM_TIME
	announce_when = ANOMALY_ANNOUNCE_MEDIUM_TIME

	//metacarp are not technically anomalies, so this needs custom make_anomaly logic
	anomaly_path = null

/datum/round_event/anomaly/anomaly_metacarp/make_anomaly(turf/anomaly_turf)
	return new /mob/living/basic/carp/metacarp(anomaly_turf)

/datum/round_event/anomaly/anomaly_metacarp/announce(fake)
	if(isnull(impact_area))
		impact_area = placer.findValidArea()
	priority_announce("Anomalous cross-dimensional entity detected on [ANOMALY_ANNOUNCE_MEDIUM_TEXT] [impact_area.name]. \n\nSecurity intervention recommended to destabilize the anomaly.\nScience intervention recommended to neutralize the anomaly, post-destabilization.", "Anomaly Alert", ANNOUNCER_ANOMALIES)
