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
	minimum_required = 1
	role_name = "Derelict AI"
	announce_when = 5

/datum/round_event/ghost_role/derelict_ai/announce(fake)
	priority_announce("We're getting some strange readings from your station. It seems a foreign intelligence has landed in your vicinity.", "NanoTrasen Silicon Detection")

/datum/round_event/ghost_role/derelict_ai/spawn_role()
	var/mob/chosen_candidate = SSpolling.poll_ghost_candidates(check_jobban = ROLE_DERELICT_MODSUIT, role = ROLE_DERELICT_MODSUIT, alert_pic = /obj/item/mod/control/pre_equipped, amount_to_pick = 1)
	if(isnull(chosen_candidate))
		return NOT_ENOUGH_PLAYERS

	var/mob/living/carbon/human/host_candidate
	for(var/mob/living/carbon/human/host in shuffle(GLOB.player_list))
		if(!host.client || !(ROLE_DERELICT_HOST))
			continue
		if(host.stat == DEAD)
			continue
		if(!(host.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
			continue
		if(!(ROLE_DERELICT_HOST in host.client?.prefs?.be_special))
			continue
		host_candidate = host
		break

	if(isnull(host_candidate))
		return NOT_ENOUGH_PLAYERS

	host_candidate.equipOutfit(/datum/outfit/derelict_host)
	var/obj/item/mod/control/pre_equipped/derelict/created_modsuit = host_candidate.back
	var/mob/living/silicon/ai/suitai = new /mob/living/silicon/ai(get_turf(created_modsuit), new /datum/ai_laws/derelict_laws, chosen_candidate)
	suitai.mind.add_antag_datum(/datum/antagonist/derelict_modsuit)
	suitai.mind.special_role = ROLE_DERELICT_MODSUIT

	created_modsuit.ai_enter_mod(suitai)
	var/obj/structure/ai_core/deactivated/left_over_core = locate() in get_turf(created_modsuit)
	qdel(left_over_core)

	message_admins("[ADMIN_LOOKUPFLW(suitai)] has been made into a Derelict AI by an event.")
	suitai.log_message("was spawned as a Derelict AI by an event.", LOG_GAME)
	spawned_mobs += suitai
	return SUCCESSFUL_SPAWN



