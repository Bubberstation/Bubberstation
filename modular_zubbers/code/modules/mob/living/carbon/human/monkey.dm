
/mob/living/carbon/human/species/monkey
	var/static/list/monkey_food = list(
		/obj/item/food/bread/banana,
		/obj/item/food/breadslice/banana,
		/obj/item/food/cnds/banana_honk,
		/obj/item/food/grown/banana,
		/obj/item/food/popsicle/topsicle/banana,
		/obj/item/food/salad/fruit,
		/obj/item/food/salad/jungle,
		/obj/item/food/sundae,
		/obj/item/food/grown/pineapple,
	)

/mob/living/carbon/human/species/monkey/Initialize(mapload, cubespawned, mob/spawner)
	. = ..()
	AddComponent( \
		/datum/component/tameable, \
		food_types = monkey_food, \
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
