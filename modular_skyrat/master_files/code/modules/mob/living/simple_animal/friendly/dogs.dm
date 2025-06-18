/mob/living/basic/pet/dog/dobermann
	name = "\improper dobermann"
	desc = "A larger breed of dog."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "dobber"
	icon_dead = "dobbydead"
	icon_living = "dobber"

/mob/living/basic/pet/dog/pitbull
	name = "\improper pitbull"
	desc = "Lover of Blood. Hater of Toddlers"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "pitbull"
	icon_dead = "pitbull_dead"
	icon_living = "pitbull"
	ai_controller = /datum/ai_controller/basic_controller/pitbull
	can_be_held = FALSE //He's too big.

/datum/ai_controller/basic_controller/pitbull
	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/of_size/smaller,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/dumb
	idle_behavior = /datum/idle_behavior/idle_dog
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/to_flee,
		/datum/ai_planning_subtree/flee_target/from_flee_key,
		/datum/ai_planning_subtree/dog_harassment,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/dog,
	)


/mob/living/basic/pet/dog/pitbull/Initialize(mapload)
	. = ..()
	if(prob(1))
		name = pick("Crayon", "Pimpy", "Staypuft", "Bape", "BLOODSKULL", "Baby G")
	AddElement(/datum/element/tiny_mob_hunter, MOB_SIZE_SMALL) //He eats anything that he sees as a toddler.
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)


