/datum/round_event_control/antagonist/team/nuke_ops
	name = "Nuclear Operatives"
	roundstart = TRUE

	antag_flag = ROLE_OPERATIVE
	antag_datum = /datum/antagonist/nukeop
	antag_leader_datum = /datum/antagonist/nukeop/leader

	weight = 0
	tags = list(TAG_CREW_ANTAG, TAG_CHAOTIC)

	base_antags = 2
	maximum_antags = 5
	maximum_antags_global = 5

	typepath = /datum/round_event/antagonist/team/nukie

	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_NUKIEBASE)

/datum/round_event/antagonist/team/nukie
	var/datum/job/job_type = /datum/job/nuclear_operative
	var/required_role = ROLE_NUCLEAR_OPERATIVE

	var/datum/team/nuclear/nuke_team

/datum/round_event/antagonist/team/nukie/candidate_roles_setup(mob/candidate)
	candidate.mind.set_assigned_role(SSjob.get_job_type(job_type))
	candidate.mind.special_role = required_role

/datum/round_event/antagonist/team/nukie/start()
	// Get our nukie leader
	var/datum/mind/most_experienced = get_most_experienced(setup_minds, required_role)
	if(!most_experienced)
		most_experienced = setup_minds[1]
	var/datum/antagonist/nukeop/leader/leader = most_experienced.add_antag_datum(antag_leader_datum)
	nuke_team = leader.nuke_team

	// Setup everyone else
	for(var/datum/mind/assigned_player in setup_minds)
		if(assigned_player == most_experienced)
			continue
		add_datum_to_mind(assigned_player)
	return TRUE
