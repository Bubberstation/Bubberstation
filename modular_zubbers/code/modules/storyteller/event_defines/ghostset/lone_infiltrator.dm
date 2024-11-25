/datum/round_event_control/lone_infiltrator
	name = "Spawn Lone Infiltrator"
	typepath = /datum/round_event/ghost_role/lone_infiltrator
	max_occurrences = 2
	min_players = 10
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_ENTITIES
	description = "Spawns a lone infiltrator, a non-crew syndicate agent."
	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	weight = 10

	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT)

/datum/round_event/ghost_role/lone_infiltrator
	minimum_required = 1
	role_name = ROLE_LONE_INFILTRATOR
	fakeable = FALSE

/datum/round_event/ghost_role/lone_infiltrator/spawn_role()
	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/carpspawn/carp in GLOB.landmarks_list)
		spawn_locs += carp.loc
	if(!length(spawn_locs))
		return MAP_ERROR
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_LONE_INFILTRATOR, role = ROLE_LONE_INFILTRATOR, role_name_text = role_name, amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS

	var/datum/mind/player_mind = new /datum/mind(chosen_one.key)
	player_mind.active = TRUE

	var/mob/living/carbon/human/operative = new(pick(spawn_locs))
	chosen_one.client.prefs.safe_transfer_prefs_to(operative)
	operative.dna.update_dna_identity()
	operative.dna.species.pre_equip_species_outfit(null, operative)
	SSquirks.AssignQuirks(operative, chosen_one.client, TRUE, TRUE, null, FALSE, operative)

	player_mind.transfer_to(operative)
	player_mind.set_assigned_role(SSjob.get_job_type(/datum/job/lone_operative))
	player_mind.special_role = "Lone Infiltrator"
	player_mind.add_antag_datum(/datum/antagonist/traitor/lone_infiltrator)

	message_admins("[ADMIN_LOOKUPFLW(operative)] has been made into lone infiltrator.")
	log_game("[key_name(operative)] was spawned as a lone infiltrator")
	return SUCCESSFUL_SPAWN
