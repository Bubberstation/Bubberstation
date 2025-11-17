/datum/ai_controller/basic_controller/coded_moonsnake

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = FALSE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_STOP_FLEEING = TRUE, //We only flee from scary fishermen
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/no_fisherman,
		/datum/ai_planning_subtree/flee_target/from_fisherman,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/go_for_swim,
		/datum/ai_planning_subtree/random_speech/snake
	)

/mob/living/basic/mining/moonsnake

	name = "venomous coded moonsnake"
	desc = "The serpens lunaeprogramma, or venomous coded moonsnake, is a species of territorial watersnake endemic to the hotter regions of this moon. \
	Their diet includes the eggs of cazadors, which are devoured whole in its special stomach that carefully extracts the venom and uses it for its own purposes. \
	It is said that the meat from this snake tastes just like chicken."

	icon = 'modular_zubbers/icons/mob/simple/snake.dmi'
	icon_state = "moonsnake"
	icon_living = "moonsnake"
	icon_dead = "moonsnake_dead"

	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	speed = 2
	movement_type = GROUND
	move_force = MOVE_FORCE_VERY_WEAK
	move_resist = MOVE_FORCE_VERY_WEAK
	pull_force = MOVE_FORCE_VERY_WEAK

	health = 20
	maxHealth = 20
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0.25, STAMINA = 1, OXY = 1)
	mob_biotypes = MOB_ORGANIC|MOB_REPTILE|MOB_AQUATIC|MOB_BEAST
	basic_mob_flags = IMMUNE_TO_GETTING_WET
	status_flags = NONE

	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 10, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = T0C + 120
	unsuitable_atmos_damage = 3
	unsuitable_cold_damage = 3
	unsuitable_heat_damage = 3

	friendly_verb_continuous = "hisses at"
	friendly_verb_simple = "hiss at"
	response_help_continuous = "strokes"
	response_help_simple = "stroke"
	response_disarm_continuous = "gently shoos aside"
	response_disarm_simple = "gently shoo aside"
	speak_emote = list("hisses")

	combat_mode = TRUE
	melee_attack_cooldown = 1 SECONDS
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	melee_damage_lower = 5
	melee_damage_upper = 6

	attack_vis_effect = ATTACK_EFFECT_MECHTOXIN
	attack_sound = 'sound/items/weapons/pierce.ogg'
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"

	throw_blocked_message = "does nothing to the evasive nature of"

	ai_controller = /datum/ai_controller/basic_controller/coded_moonsnake

	butcher_results = list(/obj/item/reagent_containers/cup/tube/cazador_venom = 1)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/chicken = 1)

	var/static/list/edibles = list(
		/obj/item/food/egg
	)

	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/basic/mining/moonsnake/Initialize(mapload)

	. = ..()

	add_traits(list(TRAIT_NODROWN, TRAIT_SWIMMER, TRAIT_RESISTHEAT, TRAIT_RADIMMUNE, TRAIT_VENTCRAWLER_ALWAYS), INNATE_TRAIT)

	AddElement(/datum/element/basic_eating, heal_amt = 2, food_types = edibles)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/cazador, 1, injection_flags = INJECT_CHECK_PENETRATE_THICK)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SNAKE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(edibles))
