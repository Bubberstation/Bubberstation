/datum/ai_behavior/targeted_mob_ability/proc/get_ability_to_use(datum/ai_controller/controller, ability_key)
	return controller.blackboard[ability_key]
