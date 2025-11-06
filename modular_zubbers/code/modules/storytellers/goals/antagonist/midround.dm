#define ROLE_BLACKLIST_SECLIKE list( \
		JOB_CYBORG, \
		JOB_AI, \
		JOB_SECURITY_OFFICER, \
		JOB_WARDEN, \
		JOB_DETECTIVE, \
		JOB_HEAD_OF_SECURITY, \
		JOB_CAPTAIN, \
		JOB_CORRECTIONS_OFFICER, \
		JOB_NT_REP, \
		JOB_BLUESHIELD, \
		JOB_ORDERLY, \
		JOB_BOUNCER, \
		JOB_CUSTOMS_AGENT, \
		JOB_ENGINEERING_GUARD, \
		JOB_SCIENCE_GUARD, \
	)

#define ROLE_BLACKLIST_HEAD list( \
		JOB_CAPTAIN, \
		JOB_HEAD_OF_SECURITY, \
		JOB_RESEARCH_DIRECTOR, \
		JOB_CHIEF_ENGINEER, \
		JOB_CHIEF_MEDICAL_OFFICER, \
		JOB_HEAD_OF_PERSONNEL, \
	)

#define ROLE_BLACKLIST_SECHEAD list( \
		JOB_CAPTAIN, \
		JOB_HEAD_OF_SECURITY, \
		JOB_WARDEN, \
		JOB_DETECTIVE, \
		JOB_CHIEF_ENGINEER, \
		JOB_CHIEF_MEDICAL_OFFICER, \
		JOB_RESEARCH_DIRECTOR, \
		JOB_HEAD_OF_PERSONNEL, \
		JOB_CYBORG, \
		JOB_AI, \
		JOB_SECURITY_OFFICER, \
		JOB_WARDEN, \
		JOB_CORRECTIONS_OFFICER, \
		JOB_NT_REP, \
		JOB_BLUESHIELD, \
		JOB_ORDERLY, \
		JOB_BOUNCER, \
		JOB_CUSTOMS_AGENT, \
		JOB_ENGINEERING_GUARD, \
		JOB_SCIENCE_GUARD, \
	)

/datum/round_event_control/antagonist/from_living/midround_traitor
	id = "storyteller_midround_traitor"
	name = "Midround Traitor"
	description = "A crew member is converted to a traitor midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_INDIVIDUALS | STORY_TAG_AFFECTS_SECURITY

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/traitor
	antag_name = "Traitor"
	role_flag = ROLE_TRAITOR
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	min_players = 15



/datum/round_event_control/antagonist/from_ghosts/midround_loneop
	id = "storyteller_midround_loneop"
	name = "Midround Lone Operative"
	description = "A lone operative is spawned to infiltrate the station capture nuclear disk and explode the nuke."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST * 0.8
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/nukeop/lone
	antag_name = "Lone Operative"
	role_flag = ROLE_TRAITOR
	max_candidates = 1
	min_candidates = 1

	min_players = 20
	signup_atom_appearance = /obj/item/disk/nuclear


/datum/round_event_control/antagonist/from_ghosts/midround_loneop/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/human(find_space_spawn())

/datum/round_event_control/antagonist/from_ghosts/midround_loneop/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	for(var/mob/living/carbon/human/loneop in spawned_antags)
		var/datum/antagonist/nukeop/lone/loneop_antag = locate() in loneop.mind.antag_datums
		if(!loneop_antag)
			continue
		var/security_count = inputs.get_entry(STORY_VAULT_SECURITY_COUNT) || 0
		if(security_count >= 5)
			var/datum/component/uplink/uplink = loneop_antag.owner.find_syndicate_uplink()
			if(uplink)
				uplink.uplink_handler.add_telecrystals(20 + security_count * 2)
				to_chat(loneop_antag, span_notice("Due to the high security on the nuclear disk vault, you have been granted extra telecrystals to help you complete your mission."))

/datum/round_event_control/antagonist/from_ghosts/midround_loneop/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return 0
	var/weight = .
	var/obj/item/disk/nuclear/real_disk = get_disk()
	if(real_disk && real_disk.is_secure())
		weight *= 0.5
	else
		weight *= 2
	return weight

/datum/round_event_control/antagonist/from_ghosts/midround_loneop/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/disk/nuclear/real_disk = get_disk()
	if(!real_disk)
		return FALSE
	if(real_disk.is_secure() && storyteller.get_effective_threat() < STORY_GOAL_THREAT_EXTREME)
		return FALSE
	return TRUE

/datum/round_event_control/antagonist/from_ghosts/midround_loneop/proc/get_disk()
	var/obj/item/disk/nuclear/real_disk
	for(var/obj/item/disk/nuclear/disk in SSpoints_of_interest.real_nuclear_disks)
		if(!disk.fake)
			continue
		if(!is_station_level(get_turf(disk)))
			continue
		real_disk = disk
		break
	return real_disk

/datum/round_event_control/antagonist/from_living/midround_heretic
	id = "storyteller_midround_heretic"
	name = "Midround Heretic"
	description = "A crew member is converted to a heretic midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/heretic
	antag_name = "Heretic"
	role_flag = ROLE_HERETIC
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 2
	min_candidates = 1
	min_players = 15

/datum/round_event_control/antagonist/from_living/midround_changeling
	id = "storyteller_midround_changeling"
	name = "Midround Changeling"
	description = "A crew member is converted to a changeling midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID


	antag_datum_type = /datum/antagonist/changeling
	antag_name = "Changeling"
	role_flag = ROLE_CHANGELING
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 2
	min_candidates = 1
	min_players = 15

/datum/round_event_control/antagonist/from_living/midround_revolution
	id = "storyteller_midround_revolution"
	name = "Midround Provocateur"
	description = "A joining player becomes a dormant head revolutionary midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_POLITICS | STORY_TAG_WIDE_IMPACT
	enabled = FALSE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID


	antag_datum_type = /datum/antagonist/rev/head
	antag_name = "Provocateur"
	role_flag = ROLE_REV_HEAD
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	min_players = 30

/datum/round_event_control/antagonist/from_living/midround_revolution/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	for(var/datum/mind/candidate in spawned_antags)
		candidate.special_roles += "Dormant Head Revolutionary"
	addtimer(CALLBACK(src, PROC_REF(reveal_head), spawned_antags), 1 MINUTES)

/datum/round_event_control/antagonist/from_living/midround_revolution/proc/reveal_head(list/spawned_antags)
	for(var/datum/mind/candidate in spawned_antags)
		if(candidate && candidate.assigned_role == ROLE_REV_HEAD)
			candidate.special_roles -= "Dormant Head Revolutionary"


/datum/round_event_control/antagonist/from_living/midround_malf_ai
	id = "storyteller_midround_malf_ai"
	name = "Midround Malfunctioning AI"
	description = "The station AI becomes malfunctioning midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_TECHNOLOGY | STORY_TAG_WIDE_IMPACT

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	preferred_roles = list(/datum/job/ai)
	antag_datum_type = /datum/antagonist/malf_ai
	antag_name = "Malfunctioning AI"
	role_flag = ROLE_MALF
	max_candidates = 1
	min_candidates = 1

	min_players = 30

/datum/round_event_control/antagonist/from_living/midround_malf_ai/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE
	return !HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI)


/datum/round_event_control/antagonist/from_living/midround_obsessed
	id = "storyteller_midround_obsessed"
	name = "Midround Obsessed"
	description = "A crew member becomes obsessed midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_TARGETS_INDIVIDUALS | STORY_TAG_AFFECTS_CREW_MIND

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/obsessed
	antag_name = "Obsessed"
	role_flag = ROLE_OBSESSED
	max_candidates = 1
	min_candidates = 1
	min_players = 5


/datum/round_event_control/antagonist/from_living/midround_blob_infection
	id = "storyteller_midround_blob_infection"
	name = "Midround Blob Infection"
	description = "A crew member becomes a blob host midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES | STORY_TAG_WIDE_IMPACT

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/blob/infection
	antag_name = "Blob Infection"
	role_flag = ROLE_BLOB_INFECTION
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	min_players = 25


/datum/round_event_control/antagonist/from_ghosts/midround_wizard
	id = "storyteller_midround_wizard"
	name = "Midround Wizard"
	description = "A wizard is spawned to invade the station midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/wizard
	antag_name = "Wizard"
	role_flag = ROLE_WIZARD
	max_candidates = 1
	min_candidates = 1

	min_players = 20
	signup_atom_appearance = /obj/structure/sign/poster/contraband/space_cube


/datum/round_event_control/antagonist/from_ghosts/midround_blob
	id = "storyteller_midround_blob"
	name = "Midround Blob"
	description = "A blob is spawned on the station midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_EXTREME
	required_round_progress = STORY_ROUND_PROGRESSION_LATE

	antag_datum_type = /datum/antagonist/blob
	antag_name = "Blob"
	role_flag = ROLE_BLOB
	max_candidates = 1
	min_candidates = 1
	min_players = 25
	signup_atom_appearance = /obj/structure/blob/normal

/datum/round_event_control/antagonist/from_ghosts/midround_blob/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/turf/spawn_turf = get_blobspawn()
	return new /mob/eye/blob(spawn_turf, OVERMIND_STARTING_POINTS)

/datum/round_event_control/antagonist/from_ghosts/midround_blob/proc/get_blobspawn()
	if(length(GLOB.blobstart))
		return pick(GLOB.blobstart)
	var/obj/effect/landmark/observer_start/default = locate() in GLOB.landmarks_list
	return get_turf(default)


/datum/round_event_control/antagonist/from_ghosts/midround_xenos
	id = "storyteller_midround_xenos"
	name = "Midround Xenomorphs"
	description = "Xenomorphs are spawned to invade the station midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES | STORY_TAG_WIDE_IMPACT

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/xeno
	antag_name = "Xenomorph"
	role_flag = ROLE_ALIEN
	max_candidates = 3  // Multiple xenos
	min_candidates = 1
	min_players = 30
	signup_atom_appearance = /mob/living/carbon/alien/adult/hunter

/datum/round_event_control/antagonist/from_ghosts/midround_xenos/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/alien/larva(find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE))


/datum/round_event_control/antagonist/from_ghosts/nuke
	id = "storyteller_nuclear"
	name = "Nuclear Operatives"
	description = "A team of nuclear operatives is spawned to assault the station."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_ENTITIES
	enabled = FALSE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST + 3
	story_prioty = STORY_GOAL_CRITICAL_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_EXTREME
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/nukeop
	antag_name = "Nuclear Operative"
	role_flag = ROLE_OPERATIVE
	max_candidates = 5
	min_candidates = 2
	ghost_candidates = TRUE
	crew_candidates = FALSE
	min_players = 25
	signup_atom_appearance = /obj/machinery/nuclearbomb


/datum/round_event_control/antagonist/from_ghosts/midround_nightmare
	id = "storyteller_midround_nightmare"
	name = "Midround Nightmare"
	description = "A nightmare is spawned in maintenance midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_MIND | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/nightmare
	antag_name = "Nightmare"
	role_flag = ROLE_NIGHTMARE
	max_candidates = 1
	min_candidates = 1
	min_players = 10
	signup_atom_appearance = /obj/item/flashlight/lantern

/datum/round_event_control/antagonist/from_ghosts/midround_nightmare/create_ruleset_body()
	var/mob/living/carbon/human/candidate = new(find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE))
	candidate.set_species(/datum/species/shadow/nightmare)
	playsound(candidate, 'sound/effects/magic/ethereal_exit.ogg', 50, TRUE, -1)
	return candidate


/datum/round_event_control/antagonist/from_ghosts/midround_slaughter_demon
	id = "storyteller_midround_slaughter_demon"
	name = "Midround Slaughter Demon"
	description = "A slaughter demon is spawned in space midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/slaughter
	antag_name = "Slaughter Demon"
	role_flag = ROLE_ALIEN
	max_candidates = 1
	min_candidates = 1
	min_players = 15
	signup_atom_appearance = /mob/living/basic/demon/slaughter

/datum/round_event_control/antagonist/from_ghosts/midround_slaughter_demon/create_ruleset_body()
	var/turf/spawnloc = find_space_spawn()
	var/mob/living/basic/demon/slaughter/demon = new(spawnloc)
	new /obj/effect/dummy/phased_mob/blood(spawnloc, demon)
	return demon


/datum/round_event_control/antagonist/from_ghosts/midround_morph
	id = "storyteller_midround_morph"
	name = "Midround Morph"
	description = "A morph is spawned in maintenance midround."
	story_category = STORY_GOAL_ANTAGONIST
	tags = STORY_TAG_ANTAGONIST | STORY_TAG_MIDROUND | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_ENTITIES

	story_weight = STORY_WEIGHT_MINOR_ANTAGONIST
	story_prioty = STORY_GOAL_BASE_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	required_round_progress = STORY_ROUND_PROGRESSION_MID

	antag_datum_type = /datum/antagonist/morph
	antag_name = "Morph"
	role_flag = ROLE_MORPH
	max_candidates = 1
	min_candidates = 1
	min_players = 10
	signup_atom_appearance = /mob/living/basic/morph

/datum/round_event_control/antagonist/from_ghosts/midround_morph/create_ruleset_body()
	return new /mob/living/basic/morph(find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = FALSE))

#undef ROLE_BLACKLIST_SECLIKE
#undef ROLE_BLACKLIST_HEAD
#undef ROLE_BLACKLIST_SECHEAD
