/datum/map_generator/cave_generator/rimpoint_jungle // The upstream version is so lush it blended too well with the outside. Not what we wanted!
	weighted_open_turf_types = list(/turf/open/misc/rough_stone = 19, /turf/open/misc/dirt/jungle = 2, /turf/open/misc/dirt/jungle/dark = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/jungle = 1)
	weighted_mob_spawn_list = list(
		/mob/living/basic/butterfly = 1,
		/mob/living/basic/bat = 2
	) // Jungle mobs are.. a bit too on the deadcode and strong as hell side to just have spawning.

	weighted_flora_spawn_list = list(
		/obj/structure/flora/grass/jungle/a/style_random = 1,
		/obj/structure/flora/grass/jungle/b/style_random = 2,
		/obj/structure/flora/bush/jungle/a/style_random = 2,
		/obj/structure/flora/bush/jungle/b/style_random = 2,
		/obj/structure/flora/bush/jungle/c/style_random = 2,
		/obj/structure/flora/bush/large/style_random = 2,
		/obj/structure/flora/rock/pile/jungle/style_random = 2,
	)

	weighted_feature_spawn_list = list(
		/obj/structure/geyser/random = 1,
	) // We don't want orevents on-station to prevent cheesy bullshit. Geysers are fine though; gives more than tiders a reason to run out into the jungle

	mob_spawn_chance = 1
	smoothing_iterations = 50
