/datum/round_event_control/paradox_clone
	name = "Spawn Paradox Clone"
	typepath = /datum/round_event/ghost_role/paradox_clone
	max_occurrences = 1
	weight = 5
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT)
	earliest_start = 20 MINUTES
	min_players = 10
	category = EVENT_CATEGORY_ENTITIES
	description = "A paradox clone spawns in maintenance, with the goal to overtake the identity of a normal crew member."

/datum/round_event/ghost_role/paradox_clone
	minimum_required = 1
	role_name = "Paradox Clone"

/datum/round_event/ghost_role/paradox_clone/spawn_role()
	var/mob/living/carbon/human/good_version = find_clone()
	if(isnull(good_version))
		return MAP_ERROR
	var/spawn_location = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = FALSE)
	if(isnull(spawn_location))
		return MAP_ERROR

	//selecting a candidate player
	var/mob/candidate = SSpolling.poll_ghost_candidates(check_jobban = ROLE_PARADOX_CLONE, role = ROLE_PARADOX_CLONE, alert_pic = good_version, jump_target = good_version, role_name_text = "paradox clone of [good_version.real_name]", amount_to_pick = 1)
	if(isnull(candidate))
		return NOT_ENOUGH_PLAYERS

	var/mob/living/carbon/human/bad_version = good_version.make_full_human_copy(spawn_location)
	spawned_mobs += bad_version
	bad_version.PossessByPlayer(candidate.ckey)

	var/datum/antagonist/paradox_clone/antag = bad_version.mind.add_antag_datum(/datum/antagonist/paradox_clone)
	antag.original_ref = WEAKREF(good_version.mind)
	antag.setup_clone()

	playsound(bad_version, 'sound/items/weapons/zapbang.ogg', 30, TRUE)
	bad_version.put_in_hands(new /obj/item/storage/toolbox/mechanical()) //so they dont get stuck in maints

	message_admins("[ADMIN_LOOKUPFLW(bad_version)] has been made into a paradox clone by an event.")
	bad_version.log_message("was spawned as a paradox clone by an event.", LOG_GAME)

	return SUCCESSFUL_SPAWN

/datum/round_event/ghost_role/paradox_clone/proc/find_clone()
	var/list/possible_targets = list()

	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(!player.client || !player.mind || player.stat != CONSCIOUS)
			continue
		if(!(player.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
			continue
		// BUBBER EDIT ADDITION BEGIN - only target RR-true people
		if(!player.client.prefs.read_preference(/datum/preference/toggle/be_round_removed))
			continue
		// BUBBER EDIT ADDITION END
		possible_targets += player

	if(length(possible_targets))
		return pick(possible_targets)
	return null
