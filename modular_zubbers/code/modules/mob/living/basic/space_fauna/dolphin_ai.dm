/datum/ai_controller/basic_controller/dolphin
	behavior_tree_json = "modular_zubbers/code/modules/mob/living/basic/space_fauna/dolphin.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/dolphin,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/// Like the basic strategy, but exclusively attacks shitlisted people and space carp
/datum/targeting_strategy/basic/dolphin
	custom_faction_check = TRUE

/datum/targeting_strategy/basic/dolphin/faction_check(datum/ai_controller/controller, mob/living/living_mob, mob/living/the_target)
	if (controller.blackboard[BB_ALWAYS_IGNORE_FACTION] || controller.blackboard[BB_TEMPORARILY_IGNORE_FACTION])
		return FALSE
	if (the_target in controller.blackboard[BB_BASIC_MOB_RETALIATE_LIST])
		return FALSE
	if (the_target.has_faction(FACTION_CARP))
		return FALSE
	return TRUE
