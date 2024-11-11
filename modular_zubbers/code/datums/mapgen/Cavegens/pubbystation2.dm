// JUNGLE CAVES

/datum/map_generator/cave_generator/jungleplanet
	weighted_open_turf_types = list(/turf/open/misc/dirt/jungle = 10, /turf/open/misc/dirt/jungle/dark = 10)
	closed_turf_types = list(/turf/closed/mineral/random/jungle = 1)
	flora_spawn_chance = 5
	initial_closed_chance = 53
	weighted_flora_spawn_list = list(
		/obj/structure/flora/rock/pile = 1,
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
	)
	mob_spawn_chance = 1
	weighted_mob_spawn_list = list(
		/mob/living/basic/mining/wolf = 1,
		/mob/living/basic/bat = 1,
		/mob/living/basic/snake/banded = 1,
		/mob/living/basic/gorilla = 1,
		/mob/living/basic/leaper = 1,
		/mob/living/basic/venus_human_trap = 1,
		/mob/living/basic/mega_arachnid = 1
	)
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

// BIOMES TAKEN FROM _biome.dm
/datum/biome/mudlands
	turf_type = /turf/open/misc/dirt/jungle/dark
	flora_types = list(
		/obj/structure/flora/grass/jungle/a/style_random = 1,
		/obj/structure/flora/grass/jungle/b/style_random = 1,
		/obj/structure/flora/rock/pile/jungle/style_random = 1,
		/obj/structure/flora/rock/pile/jungle/large/style_random = 1,
	)
	flora_density = 3
	fauna_types = list(/mob/living/basic/spider/giant/tarantula = 1)
	fauna_density = 1

/datum/biome/plains
	turf_type = /turf/open/misc/grass/jungle
	flora_types = list(
		/obj/structure/flora/grass/jungle/a/style_random = 1,
		/obj/structure/flora/grass/jungle/b/style_random = 1,
		/obj/structure/flora/tree/jungle/style_random = 1,
		/obj/structure/flora/rock/pile/jungle/style_random = 1,
		/obj/structure/flora/bush/jungle/a/style_random = 1,
		/obj/structure/flora/bush/jungle/b/style_random = 1,
		/obj/structure/flora/bush/jungle/c/style_random = 1,
		/obj/structure/flora/bush/large/style_random = 1,
		/obj/structure/flora/rock/pile/jungle/large/style_random = 1,
	)
	flora_density = 1
	fauna_types = list(
		/mob/living/carbon/human/species/monkey = 1,
		/mob/living/basic/chicken = 1
	)
	fauna_density = 1

/datum/biome/jungle
	turf_type = /turf/open/misc/grass/jungle
	flora_types = list(
		/obj/structure/flora/grass/jungle/a/style_random = 1,
		/obj/structure/flora/grass/jungle/b/style_random = 1,
		/obj/structure/flora/tree/jungle/style_random = 1,
		/obj/structure/flora/rock/pile/jungle/style_random = 1,
		/obj/structure/flora/bush/jungle/a/style_random = 1,
		/obj/structure/flora/bush/jungle/b/style_random = 1,
		/obj/structure/flora/bush/jungle/c/style_random = 1,
		/obj/structure/flora/bush/large/style_random = 1,
		/obj/structure/flora/rock/pile/jungle/large/style_random = 1,
		/obj/structure/spacevine = 5
	)
	flora_density = 40

/datum/biome/jungle/deep
	flora_density = 65
	fauna_types = list(
		/mob/living/basic/gorilla = 1,
		/mob/living/carbon/human/species/monkey = 6,
		/mob/living/basic/chicken = 4,
		)
	fauna_density = 1

/datum/biome/wasteland
	turf_type = /turf/open/misc/dirt/jungle/wasteland
	fauna_types = list(/mob/living/simple_animal/hostile/scorpion)
	fauna_density = 1

/datum/biome/water
	turf_type = /turf/open/water/jungle
	fauna_types = list(/mob/living/basic/carp = 1)
	fauna_density = 1

/datum/biome/mountain
	turf_type = /turf/closed/mineral/random/jungle
