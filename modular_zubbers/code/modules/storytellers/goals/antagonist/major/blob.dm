/datum/round_event_control/antagonist/from_ghosts/blob
	id = "storyteller_blob"
	name = "Spawn blob"
	description = "A sentient blob entity that consumes all in its path."
	story_category = STORY_GOAL_ANTAGONIST
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/blob
	antag_name = "Blob Overmind"
	role_flag = ROLE_BLOB
	max_candidates = 1
	signup_atom_appearance = /obj/structure/blob/normal


/datum/round_event_control/antagonist/from_ghosts/blob/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/turf/spawn_turf = get_blobspawn()
	return new /mob/eye/blob(spawn_turf, OVERMIND_STARTING_POINTS)

/datum/round_event_control/antagonist/from_ghosts/blob/proc/get_blobspawn()
	if(length(GLOB.blobstart))
		return pick(GLOB.blobstart)
	var/obj/effect/landmark/observer_start/default = locate() in GLOB.landmarks_list
	return get_turf(default)
