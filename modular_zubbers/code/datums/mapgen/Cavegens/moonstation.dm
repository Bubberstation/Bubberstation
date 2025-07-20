//Surface
/datum/map_generator/cave_generator/moonstation

	weighted_open_turf_types = list(/turf/open/misc/moonstation_sand = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/lunar = 1)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/scrap = 10,
		/obj/structure/flora/ash/cacti = 20,
		/obj/structure/flora/bush/ferny = 5,
		/obj/structure/flora/bush/grassy/style_random = 1,
		/obj/structure/flora/bush/leavy/style_random = 1,
		/obj/structure/flora/bush/sparsegrass/style_random = 3,
		/obj/structure/flora/bush/stalky/style_random = 5
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/mining/cazador = 10,
		/mob/living/basic/mining/scorpion = 40,
		/obj/effect/decal/cleanable/ants/fire = 50
	)

	weighted_feature_spawn_list = list(
		/obj/structure/geyser/random = 4,
		/obj/structure/ore_vent/random/moonstation = 1
	)

	flora_spawn_chance = 4
	feature_spawn_chance = 0.1
	mob_spawn_chance = 0.5
	initial_closed_chance = 30
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

//Underground
/datum/map_generator/cave_generator/moonstation/cave

	weighted_open_turf_types = list(
		/turf/open/misc/moonstation_rock = 1
	)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/lunar_cave = 98,
		/turf/closed/mineral/strange_rock/lunar_cave = 2
	)


	weighted_mob_spawn_list = list(
		/mob/living/basic/mining/basilisk = 20,
		/mob/living/basic/mining/bileworm = 30,
		/obj/effect/spawner/random/lavaland_mob/goliath = 10,
		/obj/effect/spawner/random/lavaland_mob/legion = 20,
		/mob/living/basic/mining/watcher = 30,
		/mob/living/basic/mining/goldgrub = 10,
		/mob/living/basic/mining/brimdemon = 10,
		/obj/structure/spawner/mining/goliath = 5
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/rock/style_random = 5,
		/obj/structure/flora/ash/cap_shroom = 10,
		/obj/structure/flora/ash/leaf_shroom = 5,
		/obj/structure/flora/ash/stem_shroom = 5,
		/obj/structure/flora/ash/tall_shroom = 5,
	)

	weighted_feature_spawn_list = list(
		/obj/structure/ore_vein/diamond = 1,
		/obj/structure/ore_vein/gold = 4,
		/obj/structure/ore_vein/iron = 40,
		/obj/structure/ore_vein/plasma = 15,
		/obj/structure/ore_vein/silver = 6,
		/obj/structure/ore_vein/stone = 80,
		/obj/structure/ore_vent/random/moonstation/cave = 100
	)

	flora_spawn_chance = 2
	feature_spawn_chance = 0.8
	mob_spawn_chance = 1.5
	initial_closed_chance = 40
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3


/* Here lies dead code that I wish to get working again. Because of how changeturf works, this cannot work without causing runtimes. Maybe in the future this can be re-added.  ~ Burger
/obj/effect/mapping_helpers/turf_spreader
	name = "turf spreader"
	desc = "Spread the love!"

	var/turf/desired_spread_type

	var/spread_prob_base = 80
	var/spread_prob_loss = 10

/obj/effect/mapping_helpers/turf_spreader/Initialize(mapload)

	. = ..()

	var/turf/our_turf = get_turf(src)

	if(!our_turf) //huh
		return

	if(our_turf.turf_flags & NO_LAVA_GEN)
		return .

	var/area/our_area = our_turf.loc

	if(desired_spread_type && our_turf.type != desired_spread_type)
		our_turf.ChangeTurf(desired_spread_type)

	our_turf.Spread(spread_prob_base,spread_prob_loss,our_area.type)

/obj/effect/mapping_helpers/turf_spreader/moonstation_water
	desired_spread_type = /turf/open/water/moonstation
*/
