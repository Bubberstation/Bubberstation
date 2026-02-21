/datum/component/infection_attack
	var/chance_on_infection = 10
	var/only_with_wounds = TRUE
	var/disease

/datum/component/infection_attack/Initialize(disease, chance_on_infection = 10, only_with_wounds = TRUE)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	src.chance_on_infection = chance_on_infection
	if(!istype(disease, /datum/disease))
		return COMPONENT_INCOMPATIBLE
	src.disease = disease
	src.only_with_wounds = only_with_wounds
	RegisterSignal(parent, COMSIG_LIVING_ATTACK_ATOM, PROC_REF(on_parent_attack), TRUE)


/datum/component/infection_attack/proc/on_parent_attack(mob/living/attacker, atom/attacked, list/modifiers)
	SIGNAL_HANDLER
	if(!ishuman(attacked))
		return
	var/mob/living/carbon/human/human = attacked
	if(!human.all_wounds && only_with_wounds)
		return
	var/infect_chance = 10
	if(human.all_wounds && islist(human.all_wounds))
		for(var/datum/wound/wound in human.all_wounds)
			if(wound.severity >= WOUND_SEVERITY_SEVERE)
				infect_chance += 10
	infect_chance = clamp(infect_chance, 10, 40)
	if(prob(infect_chance))
		human.ForceContractDisease(new disease, del_on_fail = TRUE)


/proc/is_khara_creature(datum/thing)
	return istype(thing, /mob/living/basic/khara_mutant) || HAS_TRAIT(thing, TRAIT_KHARAMUTANT)

/obj/effect/mob_spawn/ghost_role/flesh_spider
	name = "Flesh cocoon"
	desc = "A large pulsating plant..."
	icon = 'icons/mob/simple/meteor_heart.dmi'
	icon_state = "flesh_pod"
	mob_type = /mob/living/basic/khara_mutant/flesh_spider
	density = FALSE
	uses = 1
	deletes_on_zero_uses_left = FALSE
	prompt_name = "venus human trap"
	you_are_text = "You are a flesh-blood spider."
	flavour_text = "You are a flesh-blood spider!  Protect your nest at all costs, and feast on those who oppose you!"
	important_text = "Do not left your nest in any circumstance!"
	faction = list(FACTION_HOSTILE)
	light_range = 2
	light_power = 3

/obj/effect/mob_spawn/ghost_role/flesh_spider/Initialize(mapload)
	. = ..()
	set_light(light_range, light_power, LIGHT_COLOR_FLARE)

/obj/effect/mob_spawn/ghost_role/flesh_spider/pre_ghost_take(mob/dead/observer/user)
	icon_state = "flesh_pod_open"
	for(var/turf/blood_turf in view(src, 2))
		new /obj/effect/decal/cleanable/blood(blood_turf)
		for(var/mob/living/mob_in_turf in blood_turf)
			mob_in_turf.visible_message(span_danger("[mob_in_turf] is splattered with blood!"), span_userdanger("You're splattered with blood!"))
			mob_in_turf.add_blood_DNA(list("Non-human DNA" = random_human_blood_type()))
			playsound(mob_in_turf, 'sound/effects/splat.ogg', 50, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	return ..()


/mob/living/basic/khara_mutant
	name = "Khara mutant"
	desc = "A vile, bloody abomination..."
	mob_biotypes = MOB_ORGANIC|MOB_BUG|MOB_SPECIAL
	speak_emote = list("roars")
	damage_coeff = list(BRUTE = 1.5, BURN = 0.5, TOX = 0, STAMINA = 1, OXY = 0)
	basic_mob_flags = FLAMMABLE_MOB|IMMUNE_TO_FISTS|REMAIN_DENSE_WHILE_DEAD
	status_flags = CANSTUN
	speed = 1
	maxHealth = 250
	health = 250
	armour_penetration = 30
	melee_damage_lower = 20
	melee_damage_upper = 20
	obj_damage = 50
	melee_attack_cooldown = CLICK_CD_MELEE
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	unsuitable_cold_damage = 10
	unsuitable_heat_damage = 0
	maximum_survivable_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	minimum_survivable_temperature = T0C - 25
	combat_mode = TRUE
	faction = list(FACTION_KHARA)
	pass_flags = PASSTABLE
	unique_name = TRUE
	lighting_cutoff_red = 22
	lighting_cutoff_green = 5
	lighting_cutoff_blue = 5
	butcher_results = list(/obj/item/food/meat/slab/spider = 2, /obj/item/food/spiderleg = 8)
	max_stamina = 250
	stamina_crit_threshold = 90
	stamina_recovery = 5
	max_stamina_slowdown = 12
	habitable_atmos = null

	var/spread_miasma_chance = 5
	var/spreads_miasma = FALSE
	var/regeneration_delay = 4 SECONDS
	var/health_regen_per_second = 4
	var/list/innate_actions

	var/spread_minimal_cooldown = 5 SECONDS
	COOLDOWN_DECLARE(spread_cd)

/mob/living/basic/khara_mutant/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_NO_TELEPORT, TRAIT_LAVA_IMMUNE,TRAIT_ASHSTORM_IMMUNE, TRAIT_NO_FLOATING_ANIM, TRAIT_THERMAL_VISION, TRAIT_KHARAMUTANT), MEGAFAUNA_TRAIT)
	AddElement(/datum/element/prevent_attacking_of_types, GLOB.typecache_general_bad_hostile_attack_targets, "that doesn't make sense!")
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/ai_retaliate)


	AddComponent(/datum/component/seethrough_mob)
	AddComponent(\
		/datum/component/blood_walk,\
		blood_type = /obj/effect/decal/cleanable/blood/bubblegum,\
		blood_spawn_chance = 15,\
	)
	AddComponent(\
		/datum/component/regenerator,\
		regeneration_delay = regeneration_delay,\
		brute_per_second = health_regen_per_second,\
		outline_colour = COLOR_PINK,\
	)
	AddComponent(\
		/datum/component/infection_attack, \
		disease = /datum/disease/khara,\
		chance_on_infection = 10, \
		only_with_wounds = TRUE, \
	)
	apply_wibbly_filters(src)

	if(innate_actions && islist(innate_actions))
		grant_actions_by_list(innate_actions)
	update_sight()


/mob/living/basic/khara_mutant/Life(seconds_per_tick, times_fired)
	. = ..()
	if(spreads_miasma && SPT_PROB_RATE(spread_miasma_chance, seconds_per_tick) && COOLDOWN_FINISHED(src, spread_cd))
		COOLDOWN_START(src, spread_cd, spread_minimal_cooldown)
		spread_miasma()

/mob/living/basic/khara_mutant/proc/spread_miasma()
	var/datum/reagents/R = new(12)
	R.my_atom = src
	R.add_reagent(/datum/reagent/toxin/khara, 5)

	var/datum/effect_system/fluid_spread/smoke/chem/S = new()
	S.set_up(1.4, holder = src, location = get_turf(src), carry = R)
	S.start()

/mob/living/basic/khara_mutant/death(gibbed)
	inflate_gib()
	. = ..()

/mob/living/basic/khara_mutant/gib()
	for(var/turf/blood_turf in view(src, 3))
		new /obj/effect/decal/cleanable/blood(blood_turf)
		for(var/mob/living/mob_in_turf in blood_turf)
			mob_in_turf.visible_message(span_danger("[mob_in_turf] is splattered with blood!"), span_userdanger("You're splattered with blood!"))
			mob_in_turf.add_blood_DNA(list("Non-human DNA" = random_human_blood_type()))
			playsound(mob_in_turf, 'sound/effects/splat.ogg', 50, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE)
	return ..()


/mob/living/basic/khara_mutant/flesh_spider
	name = "flesh spider"
	desc = "A odd fleshy creature in the shape of a spider. Its eyes are pitch black and soulless."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "flesh"
	icon_living = "flesh"
	icon_dead = "flesh_dead"
	speak_emote = list("chitters")
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	ai_controller = /datum/ai_controller/basic_controller/giant_spider

	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/boss_bone_shard = BB_MOB_ABILITY_BONESHARD
	)

/mob/living/basic/khara_mutant/flesh_spider/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_WEB_SURFER, INNATE_TRAIT)
	AddElement(/datum/element/cliff_walking)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/hunterspider, 5, injection_flags = INJECT_CHECK_PENETRATE_THICK)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/fast_web)
	AddElement(/datum/element/nerfed_pulling, GLOB.typecache_general_bad_things_to_easily_move)


/mob/living/basic/khara_mutant/arachnid
	name = "Corrupted arachnid"
	desc = "Though physically imposing, it prefers to ambush its prey, and it will only engage with an already crippled opponent."
	icon = 'icons/mob/simple/jungle/arachnid.dmi'
	icon_state = "arachnid"
	icon_living = "arachnid"
	icon_dead = "arachnid_dead"
	color = COLOR_RED
	armour_penetration = 50
	melee_damage_lower = 25
	melee_damage_upper = 35
	maxHealth = 350
	health = 350

	regeneration_delay = 7 SECONDS
	health_regen_per_second = 10

	pixel_x = -16
	base_pixel_x = -16
	mob_size = MOB_SIZE_HUGE

	speak_emote = list("roarss")
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	ai_controller = /datum/ai_controller/basic_controller/corrupted_arachnid

	innate_actions = list(
		/datum/action/cooldown/spell/pointed/projectile/flesh_restraints = BB_ARACHNID_RESTRAIN,
		/datum/action/cooldown/mob_cooldown/boss_leap = BB_MOB_ABILITY_LEAP,
	)


// Don't be afraid of reaper!
/mob/living/basic/khara_mutant/reaper
	name = "Reaper"
	desc = "A terrifying abomination on thin, bloodied legs. Its limbs move chaotically."
	icon = 'modular_zvents/icons/mob/64x64.dmi'
	icon_state = "reaper"
	icon_living = "reaper"
	icon_dead = "reaper_dead"
	armour_penetration = 20
	melee_damage_lower = 30
	melee_damage_upper = 30
	maxHealth = 300
	health = 300

	regeneration_delay = 15 SECONDS
	health_regen_per_second = 10

	pixel_x = -16
	base_pixel_x = -16
	mob_size = MOB_SIZE_HUGE

	speak_emote = list("roarss")
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	ai_controller = /datum/ai_controller/basic_controller/corrupted_arachnid

	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/aoe_slash = BB_MOB_AILITY_SLASH,
		/datum/action/cooldown/mob_cooldown/boss_charge/weak = BB_MOB_ABILITY_FAST_CHARGE,
	)




/mob/living/basic/khara_mutant/spreader
	name = "Spreader"
	desc = "A massive abomination resembling a living lung, it spews forth enormous volumes of infected mist filled with the miasma of Khara."
	icon = 'modular_zvents/icons/mob/256x256.dmi'
	icon_state = "spreader"
	icon_living = "spreader"
	icon_dead = "spreader"

	speed = 12
	maxHealth = 3000
	health = 3000

	regeneration_delay = 30 SECONDS
	health_regen_per_second = 10

	pixel_x = -112
	base_pixel_x = -112
	pixel_y = -16
	base_pixel_y = -16

	mob_size = MOB_SIZE_HUGE
	plane = MASSIVE_OBJ_PLANE
	ai_controller = null

	spread_miasma_chance = 100
	spread_minimal_cooldown = 6 SECONDS

	ai_controller = /datum/ai_controller/basic_controller/boss_spreader
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/boss_bone_shard = BB_MOB_ABILITY_BONESHARD,
		/datum/action/cooldown/mob_cooldown/throw_spider = BB_MOB_ABILITY_MEAT_BALL,
		/datum/action/cooldown/mob_cooldown/rumble = BB_MOB_ABILITY_RUMBLE,
	)

/mob/living/basic/khara_mutant/spreader/Initialize(mapload)
	. = ..()
	SSweather.run_weather(/datum/weather/khara_infection)

/mob/living/basic/khara_mutant/spreader/death(gibbed)
	for(var/datum/weather/weather in SSweather.processing)
		if(istype(weather, /datum/weather/khara_infection) && (z in weather.impacted_z_levels))
			weather.wind_down()
			break
	. = ..()
