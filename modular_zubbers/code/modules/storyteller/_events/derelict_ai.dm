/datum/round_event_control/derelict_ai
	name = "Derelict AI"
	typepath = /datum/round_event/ghost_role/derelict_ai
	category = EVENT_CATEGORY_SPACE
	description = "A drifting modsuit with a foreign AI lands on the station, putting the modsuit on links the wearer's and the AI's desires"

	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS

	min_players = 30
	max_occurrences = 1
	weight = 10
	earliest_start = 20 MINUTES

	track = EVENT_TRACK_ROLESET
	tags = list(
		TAG_TEAM_ANTAG,
		TAG_SPOOKY,
		TAG_COMBAT,
	)

/datum/round_event/ghost_role/derelict_ai

/datum/round_event/ghost_role/derelict_ai/announce(fake)
	priority_announce("We're getting some strange readings from your station. It seems a foreign intelligence has landed in your vicinity.", "NanoTrasen Silicon Detection")

/datum/round_event/ghost_role/derelict_ai/spawn_role()
	var/mob/chosen_candidate = SSpolling.poll_ghost_candidates(check_jobban = ROLE_DERELICT_MODSUIT, role = ROLE_DERELICT_MODSUIT, alert_pic = /obj/item/mod/control/pre_equipped, amount_to_pick = 1)
	if(isnull(chosen_candidate))
		return NOT_ENOUGH_PLAYERS
	var/turf/spawn_turf = get_safe_random_station_turf()
	if(!spawn_turf)
		return
	var/obj/item/mod/control/pre_equipped/derelict/created_modsuit = new(spawn_turf)
	created_modsuit.ai_assistant.key = chosen_candidate.key
	created_modsuit.ai_assistant.mind.add_antag_datum(/datum/antagonist/derelict_modsuit)
	message_admins("[ADMIN_LOOKUPFLW(created_modsuit.ai_assistant)] has been made into a Derelict AI by an event.")
	created_modsuit.ai_assistant.log_message("was spawned as a Derelict AI by an event.", LOG_GAME)
	spawned_mobs += created_modsuit.ai_assistant
	return SUCCESSFUL_SPAWN



