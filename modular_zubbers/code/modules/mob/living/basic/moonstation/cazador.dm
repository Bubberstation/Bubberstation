/mob/living/basic/mining/cazador

	name = "cazador"
	desc = "You feel a little woozy..."

	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "cazador"
	icon_living = "cazador"
	icon_dead = "cazador_dead"

	mob_biotypes = MOB_ORGANIC|MOB_BUG
	maxHealth = 50
	health = 50
	damage_coeff = list(BRUTE = 1.25, BURN = 0.75, TOX = 0.5, STAMINA = 1, OXY = 1)
	basic_mob_flags = FLAMMABLE_MOB
	status_flags = NONE

	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 10, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = T0C + 120
	unsuitable_atmos_damage = 4
	unsuitable_cold_damage = 4
	unsuitable_heat_damage = 4

	friendly_verb_continuous = "buzzes at"
	friendly_verb_simple = "buzz at"
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently shoos aside"
	response_disarm_simple = "gently shoo aside"
	speak_emote = list("buzzes")

	combat_mode = TRUE
	melee_attack_cooldown = 2 SECONDS
	obj_damage = 0
	melee_damage_lower = 5
	melee_damage_upper = 15

	attack_vis_effect = ATTACK_EFFECT_MECHTOXIN
	attack_sound = 'sound/items/weapons/pierce.ogg'
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"

	throw_blocked_message = "does nothing to the tough carapace of"

	speed = 1
	movement_type = FLYING
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK

	ai_controller = /datum/ai_controller/basic_controller/simple_hostile

	butcher_results = list(/obj/item/reagent_containers/cup/tube/cazador_venom = 1)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/bugmeat = 2)

/mob/living/basic/mining/cazador/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_RESISTHEAT, TRAIT_RADIMMUNE), INNATE_TRAIT)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/cazador, 2, injection_flags = INJECT_CHECK_PENETRATE_THICK)

/datum/reagent/toxin/cazador
	name = "Cazador Venom"
	toxpwr = 4
	description = "An extremely toxic chemical produced by the rare cazador. Makes you feel woozy."
	health_required = 10
	liver_damage_multiplier = 0

/datum/reagent/toxin/cazador/on_mob_add(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_danger("You feel a little woozy..."))

/obj/item/reagent_containers/cup/tube/cazador_venom
	name = "cazador venom vial"
	desc = "A small vial. Contains cazador venom."
	list_reagents = list(/datum/reagent/toxin/cazador = 10)

/mob/living/simple_animal/hostile/cazador
	gold_core_spawnable = NO_SPAWN

