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
	// Retaliate-only: Boris defends himself and his handlers but will not charge off
	// to hunt boarding crew, so a friendly evac does not turn into a bear attack.
	ai_controller = /datum/ai_controller/basic_controller/simple/simple_retaliate
