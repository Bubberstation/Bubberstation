/datum/antagonist
	//Loss multiplier for this antagonist type.
	//Null means not actually an antagonist, and should give points.
	//0 means don't give any points, but don't take any away.
	var/antag_ticket_multiplier


/datum/antagonist/proc/get_antag_ticket_multiplier()
	return antag_ticket_multiplier

// /tg/ antag types
/datum/antagonist/abductor
	antag_ticket_multiplier = 1

/datum/antagonist/battlecruiser
	antag_ticket_multiplier = 1

/datum/antagonist/blob
	antag_ticket_multiplier = 1

/datum/antagonist/blob_minion
	antag_ticket_multiplier = 1

/datum/antagonist/brother
	antag_ticket_multiplier = 1

/datum/antagonist/changeling
	antag_ticket_multiplier = 1

/datum/antagonist/fallen_changeling
	antag_ticket_multiplier = 0.5

/datum/antagonist/cult
	antag_ticket_multiplier = 1

/datum/antagonist/cult/get_antag_ticket_multiplier()
	if(!give_equipment) //This means that converts don't lose tickets.
		return 0
	. = ..()

/datum/antagonist/heretic
	antag_ticket_multiplier = 1

/datum/antagonist/malf_ai
	antag_ticket_multiplier = 1

/datum/antagonist/morph
	antag_ticket_multiplier = 1

/datum/antagonist/nightmare
	antag_ticket_multiplier = 1

/datum/antagonist/nukeop //Also includes nuke op
	antag_ticket_multiplier = 1

/datum/antagonist/pirate
	antag_ticket_multiplier = 1

/datum/antagonist/revenant
	antag_ticket_multiplier = 1

/datum/antagonist/rev/head //This is head revs. Regular revs don't get anything.
	antag_ticket_multiplier = 1

/datum/antagonist/enemy_of_the_state
	antag_ticket_multiplier = 0.5

/datum/antagonist/space_dragon
	antag_ticket_multiplier = 1

/datum/antagonist/space_carp
	antag_ticket_multiplier = 1

/datum/antagonist/space_dragon
	antag_ticket_multiplier = 1

/datum/antagonist/ninja
	antag_ticket_multiplier = 1

/datum/antagonist/spider
	antag_ticket_multiplier = 1

/datum/antagonist/spy
	antag_ticket_multiplier = 1

/datum/antagonist/syndicate_monkey
	antag_ticket_multiplier = 1

/datum/antagonist/traitor
	antag_ticket_multiplier = 1

/datum/antagonist/venus_human_trap
	antag_ticket_multiplier = 1

/datum/antagonist/wishgranter
	antag_ticket_multiplier = 1

/datum/antagonist/wizard
	antag_ticket_multiplier = 1

/datum/antagonist/xeno
	antag_ticket_multiplier = 1

//Skyrat antag types
/datum/antagonist/assault_operative
	antag_ticket_multiplier = 1

/datum/antagonist/clock_cultist //There is actually no easy way to check if this was a convert. Thanks Skyrat. Good thing this is disabled anyways :^)
	antag_ticket_multiplier = 1

/datum/antagonist/cortical_borer
	antag_ticket_multiplier = 1

/datum/antagonist/cop
	antag_ticket_multiplier = 1

/datum/antagonist/ert/request_911/treason_destroyer
	antag_ticket_multiplier = 1

/datum/antagonist/ert/nri
	antag_ticket_multiplier = 1

//Bubberstation Antags
/datum/antagonist/bloodsucker
	antag_ticket_multiplier = 1

/datum/antagonist/shaded_bloodsucker //This is a dead bloodsucker for some bloodsucker types
	antag_ticket_multiplier = 0
