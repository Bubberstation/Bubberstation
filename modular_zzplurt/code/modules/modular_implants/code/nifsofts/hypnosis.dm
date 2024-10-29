#define HYPNOEYES_COOLDOWN_NORMAL 3 SECONDS
#define HYPNOEYES_COOLDOWN_BRAINWASH 30 SECONDS

/datum/nifsoft/action_granter/hypnosis
	// Keep this between shifts
	able_to_keep = TRUE

	// Disable use cost
	active_cost = 0

	// Replace action
	action_to_grant = /datum/action/cooldown/hypnotize
