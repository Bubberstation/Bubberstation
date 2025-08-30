
/mob/living/carbon/human/species/monkey/Initialize(mapload, cubespawned, mob/spawner)
	. = ..()
	AddComponent( \
		/datum/component/tameable, \
		food_types = list(/obj/item/food/grown/banana, /obj/item/food/grown/pineapple), \
		tame_chance = 5, \
		bonus_tame_chance = 5, \
		unique = FALSE, \
	)
	RegisterSignal(src, COMSIG_MOB_TRY_TAME, PROC_REF(on_tame_signal))

// happy monke
/mob/living/carbon/human/species/monkey/proc/on_tame_signal(atom/source, obj/item/food, mob/living/attacker)
	SIGNAL_HANDLER
	// ai_controller?.set_blackboard_key(BB_MONKEY_AGGRESSIVE, FALSE)
	if(ai_controller)
		ai_controller.blackboard[BB_MONKEY_ENEMIES] -= attacker
