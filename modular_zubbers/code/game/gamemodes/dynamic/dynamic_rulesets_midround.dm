
//////////////////////////////////////////////
//                                          //
//          MIDROUND BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/bloodsucker
	name = "Vampiric Accident"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	antag_datum = /datum/antagonist/bloodsucker
	antag_flag = ROLE_VAMPIRICACCIDENT
	antag_flag_override = ROLE_BLOODSUCKER
	protected_roles = BLOODSUCKER_PROTECTED_ROLES
	restricted_roles = BLOODSUCKER_RESTRICTED_ROLES
	restricted_species = BLOODSUCKER_RESTRICTED_SPECIES
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(40,30,20,10,10,10,10,10,10,10)
	repeatable = FALSE

/datum/dynamic_ruleset/midround/bloodsucker/trim_candidates()
	..()
	candidates = living_players
	for(var/mob/living/player in candidates)
		if(!is_station_level(player.z))
			candidates.Remove(player)
		else if(player.mind && (player.mind.special_role || length(player.mind.antag_datums) > 0))
			candidates.Remove(player)

/datum/dynamic_ruleset/midround/bloodsucker/execute()
	if(!length(candidates))
		return FALSE
	var/mob/selected_mobs = pick(candidates)
	assigned += selected_mobs.mind
	candidates -= selected_mobs
	var/datum/mind/candidate_mind = selected_mobs.mind
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = candidate_mind.make_bloodsucker()
	if(!bloodsuckerdatum)
		assigned -= selected_mobs.mind
		message_admins("[ADMIN_LOOKUPFLW(selected_mobs)] was selected by the [name] ruleset, but couldn't be made into a Bloodsucker.")
		return FALSE
	bloodsuckerdatum.AdjustUnspentRank(rand(2, 3))
	message_admins("[ADMIN_LOOKUPFLW(selected_mobs)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	log_game("DYNAMIC: [key_name(selected_mobs)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	return TRUE
