/datum/ai_controller/basic_controller/bear/guard
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/bear,
	)

/mob/living/basic/bear/russian/boris
	name = "Boris"
	real_name = "Boris"
	desc = "A hulking brown bear in a battered Vítězství Arms harness. A brass tag identifies him as BORIS, SENIOR MORALE OFFICER. He smells faintly of gun oil and strongly of bear, making him the best-smelling member of the company."
	maxHealth = 500
	health = 500
	melee_damage_lower = 30
	melee_damage_upper = 40
	obj_damage = 100
	faction = list(FACTION_VITEZSTVI, FACTION_RUSSIAN, FACTION_BEAR)
	ai_controller = /datum/ai_controller/basic_controller/bear/guard
