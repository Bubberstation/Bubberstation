/// Durable ambush mob with an EMP ability
/mob/living/basic/heretic_summon/stalker
	name = "\improper Flesh Stalker"
	real_name = "Flesh Stalker"
	desc = "An abomination cobbled together from varied remains. Its appearance changes slightly every time you blink."
	icon_state = "stalker"
	icon_living = "stalker"
	maxHealth = 150
	health = 150
	melee_damage_lower = 15
	melee_damage_upper = 20
	sight = SEE_MOBS
	ai_controller = /datum/ai_controller/basic_controller/stalker
	/// Actions to grant on spawn
	var/static/list/actions_to_add = list(
		/datum/action/cooldown/spell/emp/eldritch = BB_GENERIC_ACTION,
		/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash = null,
//		/datum/action/cooldown/spell/shapeshift/eldritch = BB_SHAPESHIFT_ACTION, //BUBBER EDIT - Remove the shapeshift, instead having morph-esque shapeshifting, as seen below.
		/datum/action/cooldown/mob_cooldown/assume_form = null, //The below to be seen
	)

/mob/living/basic/heretic_summon/stalker/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_target_timer)
	grant_actions_by_list(actions_to_add)
	RegisterSignal(src, COMSIG_ACTION_DISGUISED_APPEARANCE, PROC_REF(on_disguise)) //BUBBER EDIT - add a signal for the disguise, to be used in modular_zubbers
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_DISGUISED), PROC_REF(on_undisguise)) //and another

/// Changes shape and lies in wait when it has no target, uses EMP and attacks once it does
/datum/ai_controller/basic_controller/stalker
	ai_traits = CAN_ACT_IN_STASIS
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
//		/datum/ai_planning_subtree/shapechange_ambush, //BUBBER EDIT - Doesn't work with morph shapechanging
		/datum/ai_planning_subtree/use_mob_ability,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
