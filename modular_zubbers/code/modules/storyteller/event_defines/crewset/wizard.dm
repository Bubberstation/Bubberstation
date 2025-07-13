/datum/round_event_control/antagonist/wizard
	name = "Wizard"
	roundstart = TRUE

	antag_flag = ROLE_WIZARD
	antag_datum = /datum/antagonist/wizard

	weight = 1 // This should be rare enough, lower this if it turns out to roll too frequently.
	tags = list(TAG_CREW_ANTAG, TAG_CHAOTIC)

	base_antags = 1
	maximum_antags = 1

	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_WIZARDDEN)
