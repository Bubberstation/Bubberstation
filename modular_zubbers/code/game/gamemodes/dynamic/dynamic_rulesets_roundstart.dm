
//////////////////////////////////////////////
//                                          //
//        ROUNDSTART BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////



/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	protected_roles = BLOODSUCKER_PROTECTED_ROLES
	restricted_roles = BLOODSUCKER_RESTRICTED_ROLES
	restricted_species = BLOODSUCKER_RESTRICTED_SPECIES
	required_candidates = 1
	weight = 5
	cost = 10
	scaling_cost = 9
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	antag_cap = list("denominator" = 24)

/datum/dynamic_ruleset/roundstart/bloodsucker/pre_execute(population)
	. = ..()
	var/num_bloodsuckers = get_antag_cap(population) * (scaled_times + 1)

	for(var/i = 1 to num_bloodsuckers)
		if(candidates.len <= 0)
			break
		var/mob/selected_mobs = pick_n_take(candidates)
		assigned += selected_mobs.mind
		selected_mobs.mind.special_role = ROLE_BLOODSUCKER
		selected_mobs.mind.restricted_roles = restricted_roles
		GLOB.pre_setup_antags += selected_mobs.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/bloodsucker/execute()
	for(var/datum/mind/candidate_minds as anything in assigned)
		if(!candidate_minds.make_bloodsucker())
			candidate_minds.special_role = null
			candidate_minds.restricted_roles = null
			message_admins("[ADMIN_LOOKUPFLW(candidate_minds)] was selected by the [name] ruleset, but couldn't be made into a Bloodsucker.")
			assigned -= candidate_minds
			continue
		GLOB.pre_setup_antags -= candidate_minds
	return TRUE
