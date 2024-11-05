/mob/living/basic/mining/scorpion

	name = "giant scorpion"
	desc = "A giant mutated scorpion with a tough external carapace. Watch that stinger!"

	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "scorpion"
	icon_living = "scorpion"
	icon_dead = "scorpion_d"

	mob_biotypes = MOB_ORGANIC|MOB_BUG
	maxHealth = 75
	health = 75
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0.5, STAMINA = 1, OXY = 1)
	basic_mob_flags = FLAMMABLE_MOB
	status_flags = NONE

	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 10, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = T0C + 120
	unsuitable_atmos_damage = 4
	unsuitable_cold_damage = 4
	unsuitable_heat_damage = 4

	friendly_verb_continuous = "chitters at"
	friendly_verb_simple = "chitter at"
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speak_emote = list("chitters")

	combat_mode = TRUE
	melee_attack_cooldown = 2 SECONDS
	obj_damage = 25
	melee_damage_lower = 10
	melee_damage_upper = 20

	attack_vis_effect = ATTACK_EFFECT_MECHTOXIN
	attack_sound = 'sound/items/weapons/pierce_slow.ogg'
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"

	throw_blocked_message = "does nothing to the tough carapace of"

	speed = 5
	movement_type = GROUND
	move_force = MOVE_FORCE_STRONG
	move_resist = MOVE_FORCE_STRONG
	pull_force = MOVE_FORCE_STRONG

	ai_controller = /datum/ai_controller/basic_controller/simple_hostile

	butcher_results = list(/obj/item/reagent_containers/cup/tube/scorpion_venom = 1)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/bugmeat = 4)

/mob/living/basic/mining/cazador/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_RESISTHEAT, TRAIT_RADIMMUNE), INNATE_TRAIT)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/scorpion, 3, injection_flags = INJECT_CHECK_PENETRATE_THICK)

/datum/reagent/toxin/scorpion
	name = "Scorpion Venom"
	toxpwr = 2
	description = "A toxic chemical produced by giant scorpions. Makes you feel woozy."
	health_required = 20
	liver_damage_multiplier = 0

/datum/reagent/toxin/scorpion/on_mob_add(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_danger("You feel a little woozy..."))

/obj/item/reagent_containers/cup/tube/scorpion_venom
	name = "scorpion venom vial"
	desc = "A small vial. Contains cazador venom."
	list_reagents = list(/datum/reagent/toxin/scorpion = 15)

/mob/living/simple_animal/hostile/scorpion
	gold_core_spawnable = NO_SPAWN

