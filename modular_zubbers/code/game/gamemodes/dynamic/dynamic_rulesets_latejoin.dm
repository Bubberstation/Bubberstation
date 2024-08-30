
//////////////////////////////////////////////
//                                          //
//          LATEJOIN BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	antag_datum = /datum/antagonist/bloodsucker
	antag_flag = ROLE_BLOODSUCKERBREAKOUT
	antag_flag_override = ROLE_BLOODSUCKER
	protected_roles = BLOODSUCKER_PROTECTED_ROLES
	restricted_roles = BLOODSUCKER_RESTRICTED_ROLES
	restricted_species = BLOODSUCKER_RESTRICTED_SPECIES
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	repeatable = FALSE

/datum/dynamic_ruleset/latejoin/bloodsucker/execute()
	if(!length(candidates))
		return FALSE
	var/mob/latejoiner = pick(candidates) // This should contain a single player, but in case.
	assigned += latejoiner.mind

	for(var/datum/mind/candidate_mind as anything in assigned)
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = candidate_mind.make_bloodsucker()
		if(!bloodsuckerdatum)
			assigned -= candidate_mind
			message_admins("[ADMIN_LOOKUPFLW(candidate_mind)] was selected by the [name] ruleset, but couldn't be made into a Bloodsucker.")
			continue
		bloodsuckerdatum.AdjustUnspentRank(rand(2, 3))
		message_admins("[ADMIN_LOOKUPFLW(candidate_mind)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
		log_game("DYNAMIC: [key_name(candidate_mind)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	return TRUE
