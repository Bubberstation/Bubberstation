/datum/full_round_event
	var/name = "A global event"
	var/short_desc
	var/extended_desc
	var/round_start_massage
	var/start_time
	var/current_time
	var/disable_dynamic
	var/lock_respawn
	var/only_related_observe = TRUE
	var/force_dnr = FALSE
	var/delay_round_start = FALSE
	var/custom_round_delay_time
	var/list/supressed_subsystems = list()
	var/list/blackboard = list()
	var/disable_ai = FALSE
	var/disable_synthetics = FALSE
	var/custom_event_map
	var/custom_map_path


/datum/full_round_event/proc/before_initialization()



/datum/full_round_event/proc/initialize()



/datum/full_round_event/proc/lobby_loaded()



/datum/full_round_event/proc/roundstart(init_time)



/datum/full_round_event/proc/client_joined(client/player_client)



/datum/full_round_event/proc/new_player_spawned(client/player_client, mob/living/player_mob)



/datum/full_round_event/proc/player_dead(mob/living/dead)




/datum/full_round_event/proc/event_process(ticks_per_second)



/datum/full_round_event/proc/get_possible_verbs()



/datum/full_round_event/proc/get_event_description()
	SHOULD_CALL_PARENT(TRUE)

	return "A global event"
