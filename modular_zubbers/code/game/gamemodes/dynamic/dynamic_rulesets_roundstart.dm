
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

//////////////////////////////////////////
//                                      //
//           BLOOD BROTHERS             //
//                                      //
//////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/traitorbro
	name = "Blood Brothers"
	antag_flag = ROLE_BROTHER
	antag_datum = /datum/antagonist/brother
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
	required_candidates = 2
	weight = 2
	cost = 12
	scaling_cost = 15
	requirements = list(40,30,30,20,20,15,15,15,10,10)
	antag_cap = 2 // Can pick 3 per team, but rare enough it doesn't matter.
	var/list/datum/team/brother_team/pre_brother_teams = list()
	var/const/min_team_size = 2

/datum/dynamic_ruleset/roundstart/traitorbro/forget_startup()
	pre_brother_teams = list()
	return ..()

/datum/dynamic_ruleset/roundstart/traitorbro/pre_execute(population)
	. = ..()
	var/num_teams = (get_antag_cap(population)/min_team_size) * (scaled_times + 1) // 1 team per scaling
	for(var/j = 1 to num_teams)
		if(candidates.len < min_team_size || candidates.len < required_candidates)
			break
		var/datum/team/brother_team/team = new
		var/team_size = prob(10) ? min(3, candidates.len) : 2
		for(var/k = 1 to team_size)
			var/mob/bro = pick_n_take(candidates)
			assigned += bro.mind
			team.add_member(bro.mind)
			bro.mind.special_role = "brother"
			bro.mind.restricted_roles = restricted_roles
			GLOB.pre_setup_antags += bro.mind
		pre_brother_teams += team
	return TRUE

/datum/dynamic_ruleset/roundstart/traitorbro/execute()
	for(var/datum/team/brother_team/team in pre_brother_teams)
		team.pick_meeting_area()
		team.forge_brother_objectives()
		for(var/datum/mind/M in team.members)
			M.add_antag_datum(/datum/antagonist/brother, team)
			GLOB.pre_setup_antags -= M
		team.update_name()
	return TRUE
