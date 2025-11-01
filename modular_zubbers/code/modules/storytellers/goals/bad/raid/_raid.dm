
/datum/round_event_control/perform_raid
	id = "raid"
	name = "Perform Raid"
	description = "Sends a coordinated raid from a hostile faction on the station"
	story_category = STORY_GOAL_BAD | STORY_GOAL_GLOBAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_ENTITIES | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_AFFECTS_INFRASTRUCTURE

	min_players = 15
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	story_weight = STORY_GOAL_BASE_WEIGHT * 1.2

	typepath = /datum/round_event/storyteller_raid


/datum/round_event_control/perform_raid/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE
	if(inputs.vault[STORY_VAULT_SECURITY_COUNT < 1] && !(storyteller.get_effective_threat() > STORY_GOAL_THREAT_HIGH))
		. = FALSE
	return .


/datum/round_event/storyteller_raid
	allow_random = FALSE

	end_when = 30
	start_when = 15
	announce_when = 1
	var/datum/raider_team/selected_team
	var/turf/selected_turf

/datum/round_event/storyteller_raid/__setup_for_storyteller(threat_points, ...)
	. = ..()
	selected_team = /datum/raider_team/syndicate
	selected_turf = get_safe_random_station_turf()

/datum/round_event/storyteller_raid/__announce_for_storyteller()
	priority_announce("A group of hostile individuals has been spotted near your station. \
		According to our observations, they are preparing to land in [get_area(selected_turf)]. Stop them at all costs.", "[command_name()]")

/datum/round_event/storyteller_raid/__start_for_storyteller()
	var/datum/raider_team/team = new selected_team
	team.deploy(selected_turf)
