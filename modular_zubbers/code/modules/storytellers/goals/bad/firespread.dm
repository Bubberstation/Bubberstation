#define BB_ABILITY_RING_OF_FIRE "BB_ability_ring_of_fire"

/datum/round_event_control/fire_spread
	id = "fire_spread"
	name = "Fire Spread"
	description = "A fire has broken out and is spreading rapidly through the station.\
			This event can cause significant damage to station infrastructure and pose a threat to crew safety if not contained quickly."
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_ENVIRONMENT | STORY_TAG_ENTITIES
	typepath = /datum/round_event/fire_spread

	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_BASIC

/datum/round_event/fire_spread
	STORYTELLER_EVENT

	var/waves_count = 1
	var/wave_delay = 1 MINUTES
	var/hot_spots = 1
	end_when = INFINITY
	COOLDOWN_DECLARE(wave_cooldown)


/datum/round_event/fire_spread/__setup_for_storyteller(threat_points, ...)
	. = ..()
	if(threat_points < STORY_THREAT_LOW)
		waves_count = 1
		wave_delay = 2 MINUTES
		hot_spots = 1
	else if(threat_points < STORY_THREAT_MODERATE)
		waves_count = 2
		wave_delay = 90 SECONDS
		hot_spots = 2
	else if(threat_points < STORY_THREAT_HIGH)
		waves_count = 3
		wave_delay = 1 MINUTES
		hot_spots = 4
	else if(threat_points < STORY_THREAT_EXTREME)
		waves_count = 4
		wave_delay = 45 SECONDS
		hot_spots = 6
	else
		waves_count = 5
		wave_delay = 30 SECONDS
		hot_spots = 8

	end_when = wave_delay * waves_count


/datum/round_event/fire_spread/__announce_for_storyteller()
	priority_announce()


/datum/round_event/fire_spread/__start_for_storyteller()
	COOLDOWN_START(src, wave_cooldown, wave_delay)


/datum/round_event/fire_spread/__storyteller_tick(seconds_per_tick)
	if(COOLDOWN_FINISHED(src, wave_cooldown))
		COOLDOWN_START(src, wave_cooldown, wave_delay)
		waves_count--
		if(waves_count <= 0)
			__kill_for_storyteller()
		spread_fire()

/datum/round_event/fire_spread/proc/spread_fire()
	for(var/i = 0 to hot_spots)
		var/turf/target_turf = get_safe_random_station_turf_equal_weight()
		if(!isturf(target_turf))
			continue
		var/mob/living/basic/fire_burst/fire = new /mob/living/basic/fire_burst(target_turf)
		notify_ghosts("A fire has started at [target_turf]!", fire, "Fire Spread")

/mob/living/basic/fire_burst
	name = "Fire burst"
	desc = "A sudden burst of flame."
	icon = 'icons/effects/fire.dmi'
	icon_state = "light"
	health = 1
	maxHealth = 1
	max_stamina = BASIC_MOB_NO_STAMCRIT
	basic_mob_flags = DEL_ON_DEATH
	gender = PLURAL
	living_flags = MOVES_ON_ITS_OWN
	status_flags = NONE
	fire_stack_decay_rate = 100 // It's fire it self
	faction = list()

	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	attack_verb_continuous = "is burned by"
	damage_coeff = list(BRUTE = 1, BURN = 0, TOX = 0, STAMINA = 0, OXY = 0)
	habitable_atmos = null

	ai_controller = /datum/ai_controller/basic_controller/fire_burst
	var/life_time = 30 SECONDS

/mob/living/basic/fire_burst/Initialize(mapload)
	. = ..()
	var/static/list/other_innate_actions = list(
		/datum/action/cooldown/mob_cooldown/a_ring_of_fire_fire_fire = BB_ABILITY_RING_OF_FIRE,
	)
	grant_actions_by_list(other_innate_actions)

/mob/living/basic/fire_burst/Life(seconds_per_tick, times_fired)
	. = ..()
	life_time -= 1 SECONDS * seconds_per_tick
	if(life_time <= 0)
		death()
	new /obj/effect/hotspot(loc)

/mob/living/basic/fire_burst/death(gibbed)
	for(var/turf/T in RANGE_TURFS(1, src))
		if(isturf(T))
			for(var/mob/living/living in T.contents)
				new /obj/effect/hotspot(T)
				living.apply_damage(4, BURN, TRUE, src)
	return ..()

/mob/living/basic/fire_burst/extinguish()
	. = ..()
	death()

/datum/ai_controller/basic_controller/fire_burst
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity/pacifist,
		/datum/ai_planning_subtree/use_mob_ability/ring_of_fire,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/flee_target,
	)

/datum/ai_planning_subtree/use_mob_ability/ring_of_fire
	ability_key = BB_ABILITY_RING_OF_FIRE


/datum/action/cooldown/mob_cooldown/a_ring_of_fire_fire_fire
	name = "Ring of Fire"
	desc = "Create a ring of fire around yourself."
	cooldown_time = 10 SECONDS
	shared_cooldown = MOB_SHARED_COOLDOWN_1 | MOB_SHARED_COOLDOWN_2
	var/maximum_range = 7

/datum/action/cooldown/mob_cooldown/a_ring_of_fire_fire_fire/Trigger(mob/clicker, trigger_flags, atom/target)
	. = ..()
	if(!isturf(owner.loc))
		return
	INVOKE_ASYNC(src, PROC_REF(room_of_fire), owner)

/datum/action/cooldown/mob_cooldown/a_ring_of_fire_fire_fire/proc/room_of_fire(mob/clicker)
	set waitfor = FALSE

	if(!isturf(clicker.loc))
		return
	var/area/my_area = get_area(clicker)
	var/list/area_turfs = get_area_turfs(my_area)
	for(var/turf/fire_turf in area_turfs)
		if(get_dist(clicker, fire_turf) <= maximum_range)
			new /obj/effect/hotspot(fire_turf)
			fire_turf.hotspot_expose( 1000, 100)
			for(var/mob/living/living in fire_turf.contents)
				living.apply_damage(4, BURN, TRUE, clicker)
			CHECK_TICK

#undef BB_ABILITY_RING_OF_FIRE
