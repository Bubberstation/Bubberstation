/datum/round_event_control/antagonist/from_ghosts/loneop
	id = "storyteller_loneop"
	name = "Lone Operative"
	description = "A lone operative is spawned to infiltrate the station capture nuclear disk and explode the nuke."
	story_category = STORY_GOAL_ANTAGONIST
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_MIDROUND,
		STORY_TAG_COMBAT,
		STORY_TAG_REQUIRES_SECURITY,
	)
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

/datum/round_event_control/antagonist/from_ghosts/loneop/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/human(find_space_spawn())

/datum/round_event_control/antagonist/from_ghosts/loneop/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
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

/datum/round_event_control/antagonist/from_ghosts/loneop/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
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

/datum/round_event_control/antagonist/from_ghosts/loneop/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/disk/nuclear/real_disk = get_disk()
	if(!real_disk)
		return FALSE
	if(real_disk.is_secure() && storyteller.get_effective_threat() < STORY_GOAL_THREAT_EXTREME)
		return FALSE
	return TRUE

/datum/round_event_control/antagonist/from_ghosts/loneop/proc/get_disk()
	var/obj/item/disk/nuclear/real_disk
	for(var/obj/item/disk/nuclear/disk in SSpoints_of_interest.real_nuclear_disks)
		if(!disk.fake)
			continue
		if(!is_station_level(get_turf(disk)))
			continue
		real_disk = disk
		break
	return real_disk

/datum/round_event_control/antagonist/from_living/revolution
	id = "storyteller_revolution"
	name = "Revolution"
	description = "A joining player becomes a dormant head revolutionary."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_WIDE_IMPACT,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_COMBAT,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_SOCIAL,
	)
	enabled = FALSE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/rev/head
	antag_name = "Provocateur"
	role_flag = ROLE_REV_HEAD
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 1
	min_candidates = 1
	min_players = 30

/datum/round_event_control/antagonist/from_living/revolution/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	for(var/datum/mind/candidate in spawned_antags)
		candidate.special_roles += "Dormant Head Revolutionary"
	addtimer(CALLBACK(src, PROC_REF(reveal_head), spawned_antags), 1 MINUTES)

/datum/round_event_control/antagonist/from_living/revolution/proc/reveal_head(list/spawned_antags)
	var/heads_necessary = 2
	var/head_check = 0
	for(var/mob/player as anything in get_active_player_list(alive_check = TRUE, afk_check = TRUE))
		if(player.mind?.assigned_role.job_flags & JOB_HEAD_OF_STAFF)
			head_check++

	if(head_check < heads_necessary)
		message_admins("Revolution canceled: Not enough heads of staff.")
		return

	for(var/datum/mind/candidate in spawned_antags)
		candidate.special_roles -= "Dormant Head Revolutionary"
		if(!can_be_headrev(candidate))
			message_admins("Revolution: Ineligible headrev, attempting replacement.")
			find_another_headrev()
			return
		GLOB.revolution_handler ||= new()
		var/datum/antagonist/rev/head/new_head = new()
		new_head.give_flash = TRUE
		new_head.give_hud = TRUE
		new_head.remove_clumsy = TRUE
		candidate.add_antag_datum(new_head, GLOB.revolution_handler.revs)
		GLOB.revolution_handler.start_revolution()

/datum/round_event_control/antagonist/from_living/revolution/proc/find_another_headrev()
	return

/datum/round_event_control/antagonist/from_living/malf_ai
	id = "storyteller_malf_ai"
	name = "Malfunctioning AI"
	description = "The station AI becomes malfunctioning."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_WIDE_IMPACT,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_COMBAT,
		STORY_TAG_REQUIRES_SECURITY,
		STORY_TAG_REQUIRES_ENGINEERING,
	)
	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	preferred_roles = list(/datum/job/ai)
	antag_datum_type = /datum/antagonist/malf_ai
	antag_name = "Malfunctioning AI"
	role_flag = ROLE_MALF
	max_candidates = 1
	min_candidates = 1

	min_players = 30

/datum/round_event_control/antagonist/from_living/malf_ai/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!.)
		return FALSE
	return !HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI)

/datum/round_event_control/antagonist/from_living/blob_infection
	id = "storyteller_blob_infection"
	name = "Blob Infection"
	description = "A crew member becomes a blob host."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_MIDROUND,
		STORY_TAG_COMBAT,
		STORY_TAG_EPIC,
	)
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

/datum/round_event_control/antagonist/from_ghosts/wizard
	id = "storyteller_wizard"
	name = "Wizard"
	description = "A wizard is spawned to invade the station."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_WIDE_IMPACT,
		STORY_TAG_MIDROUND,
		STORY_TAG_ROUNDSTART,
		STORY_TAG_COMBAT,
		STORY_TAG_EPIC,
		STORY_TAG_CHAOTIC,
	)
	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/wizard
	antag_name = "Wizard"
	role_flag = ROLE_WIZARD
	max_candidates = 1
	min_candidates = 1

	min_players = 20
	signup_atom_appearance = /obj/structure/sign/poster/contraband/space_cube

/datum/round_event_control/antagonist/from_ghosts/wizard/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/human

/datum/round_event_control/antagonist/from_ghosts/blob
	id = "storyteller_blob"
	name = "Blob"
	description = "A blob is spawned on the station."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_MIDROUND,
		STORY_TAG_COMBAT,
		STORY_TAG_EPIC,
		STORY_TAG_CHAOTIC,
	)
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

/datum/round_event_control/antagonist/from_ghosts/blob/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/turf/spawn_turf = get_blobspawn()
	return new /mob/eye/blob(spawn_turf, OVERMIND_STARTING_POINTS)

/datum/round_event_control/antagonist/from_ghosts/blob/proc/get_blobspawn()
	if(length(GLOB.blobstart))
		return pick(GLOB.blobstart)
	var/obj/effect/landmark/observer_start/default = locate() in GLOB.landmarks_list
	return get_turf(default)

/datum/round_event_control/antagonist/from_ghosts/xenos
	id = "storyteller_xenos"
	name = "Xenomorphs"
	description = "Xenomorphs are spawned to invade the station."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_MIDROUND,
		STORY_TAG_COMBAT,
		STORY_TAG_EPIC,
	)

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

/datum/round_event_control/antagonist/from_ghosts/xenos/create_ruleset_body(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return new /mob/living/carbon/alien/larva(find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE))

/datum/round_event_control/antagonist/from_ghosts/nuke
	id = "storyteller_nuclear"
	name = "Nuclear Operatives"
	description = "A team of nuclear operatives is spawned to assault the station."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_MIDROUND,
		STORY_TAG_COMBAT,
		STORY_TAG_EPIC,
	)
	enabled = TRUE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST + 3
	story_prioty = STORY_GOAL_CRITICAL_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_EXTREME
	required_round_progress = STORY_ROUND_PROGRESSION_START

	antag_datum_type = /datum/antagonist/nukeop
	antag_name = "Nuclear Operative"
	role_flag = ROLE_OPERATIVE
	max_candidates = 5
	min_candidates = 2
	min_players = 25
	signup_atom_appearance = /obj/machinery/nuclearbomb

/datum/round_event_control/antagonist/from_ghosts/nuke/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_NUKIEBASE)
	. = ..()

/datum/round_event_control/antagonist/from_living/blood_cult
	id = "storyteller_blood_cult"
	name = "Blood Cult"
	description = "A group of crew members form a blood cult, with one leader."
	story_category = STORY_GOAL_ANTAGONIST | STORY_GOAL_MAJOR
	tags = list(
		STORY_TAG_ANTAGONIST,
		STORY_TAG_ESCALATION,
		STORY_TAG_AFFECTS_WHOLE_STATION,
		STORY_TAG_MIDROUND,
		STORY_TAG_SOCIAL,
		STORY_TAG_EPIC,
	)
	enabled = FALSE

	story_weight = STORY_WEIGHT_MAJOR_ANTAGONIST
	story_prioty = STORY_GOAL_HIGH_PRIORITY
	requierd_threat_level = STORY_GOAL_THREAT_HIGH
	required_round_progress = STORY_ROUND_PROGRESSION_START

	blacklisted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_CHAPLAIN)
	antag_datum_type = /datum/antagonist/cult
	antag_name = "Cultist"
	role_flag = ROLE_CULTIST
	blacklisted_roles = ROLE_BLACKLIST_SECHEAD
	max_candidates = 4
	min_candidates = 2
	min_players = 30

/datum/round_event_control/antagonist/from_living/blood_cult/after_antagonist_spawn(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, list/spawned_antags)
	var/datum/team/cult/main_cult = new /datum/team/cult()
	main_cult.setup_objectives()
	var/datum/mind/most_experienced = get_most_experienced(spawned_antags, ROLE_CULTIST)
	for(var/datum/mind/candidate in spawned_antags)
		var/datum/antagonist/cult/cultist = locate(/datum/antagonist/cult) in candidate.antag_datums
		if(!cultist)
			continue
		cultist.cult_team = main_cult
		cultist.give_equipment = TRUE
		if(candidate == most_experienced)
			cultist.make_cult_leader()
