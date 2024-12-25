/datum/round_event_control/antagonist/team/revolution
	name = "Revolution"
	roundstart = TRUE

	antag_flag = ROLE_REV_HEAD
	antag_datum = /datum/antagonist/rev/head

	weight = 0
	tags = list(TAG_CREW_ANTAG, TAG_CHAOTIC)

	base_antags = 1
	maximum_antags = 3

/datum/round_event/antagonist/team/revolution
	var/required_role = ROLE_REV_HEAD

	var/datum/team/revolution/rev_team

/datum/round_event/antagonist/team/revolution/candidate_roles_setup(mob/candidate)
	candidate.mind.special_role = required_role



