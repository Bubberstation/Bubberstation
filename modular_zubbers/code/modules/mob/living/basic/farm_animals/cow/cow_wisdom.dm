/mob/living/basic/cow/wisdom/dril
	icon = 'modular_zubbers/icons/mob/dril_cow.dmi'
	ai_controller = /datum/ai_controller/basic_controller/cow/wisdom/dril


/datum/ai_controller/basic_controller/cow/wisdom/dril
	planning_subtrees = list(
		/datum/ai_planning_subtree/tip_reaction,
		/datum/ai_planning_subtree/random_speech/cow/wisdom_dril,
	)
