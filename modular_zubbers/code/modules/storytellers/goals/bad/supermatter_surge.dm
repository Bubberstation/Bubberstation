/datum/round_event_control/supermatter_surge
	id = "supermatter_surge"
	typepath = /datum/round_event/supermatter_surge
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_TARGETS_SYSTEMS
	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.4

/datum/round_event/supermatter_surge
	STORYTELLER_EVENT

/datum/round_event/supermatter_surge/__setup_for_storyteller(threat_points, ...)
	. = ..()
	setup()

	// Determine surge severity based on threat points
	if(threat_points < STORY_THREAT_LOW)
		surge_class = 1
	else if(threat_points < STORY_THREAT_MODERATE)
		surge_class = 2
	else if(threat_points < STORY_THREAT_HIGH)
		surge_class = 3
	else if(threat_points < STORY_THREAT_EXTREME)
		surge_class = 4
	else
		surge_class = 5 // Overopowered surge for extreme threat levels

/datum/round_event/supermatter_surge/__announce_for_storyteller()
	priority_announce("The Crystal Integrity Monitoring System has detected unusual atmospheric properties in the supermatter chamber, energy output from the supermatter crystal has increased significantly. Engineering intervention is required to stabilize the engine.", "Class [surge_class] Supermatter Surge Alert", 'sound/machines/engine_alert/engine_alert3.ogg')

/datum/round_event/supermatter_surge/__start_for_storyteller()
	start()
