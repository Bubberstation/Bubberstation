GLOBAL_LIST_INIT(observer_role_ban_exceptions,list(
	ROLE_FUGITIVE,
	ROLE_PARADOX_CLONE,
	ROLE_ANOMALY_GHOST,
	ROLE_DEATHSQUAD,
	ROLE_DRONE,
	ROLE_LAVALAND,
	ROLE_LAZARUS_BAD,
	ROLE_LAZARUS_GOOD,
	ROLE_MIND_TRANSFER,
	ROLE_MONKEY_HELMET,
	ROLE_PAI,
	ROLE_POSIBRAIN,
	ROLE_SENTIENCE
	ROLE_POSITRONIC_BRAIN,
	ROLE_SANTA,
	ROLE_SERVANT_GOLEM
	ROLE_BOT,
	ROLE_MAINTENANCE_DRONE
	ROLE_GLITCH,
	ROLE_CYBER_POLICE,
	ROLE_CYBER_TAC
))

/datum/controller/subsystem/polling/is_eligible(mob/potential_candidate, role, check_jobban, the_ignore_category)

	. = ..()

	if(!.)
		return .

	if(check_jobban && is_observer(potential_candidate)) //If a role has a jobban flag, it is a very high chance it's important enough to exclude potential fishers.
		var/mob/dead/observer/observing_mob = potential_candidate
		if(observing_mob.started_as_observer) //This doesn't solve the issue 100% but it sure is obvious if someone joins then immediately cryos, much like how people do this if they don't get antag roundstart.
			return !(role in observer_role_ban_exceptions) //If we're not in the exceptions list, then you can't spawn as this.
