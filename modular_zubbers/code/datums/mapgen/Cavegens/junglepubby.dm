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
	fauna_types = list(/mob/living/basic/bee = 1)
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
		/mob/living/basic/snake = 1,
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
		/mob/living/basic/snake/banded/harmless = 6,
		/mob/living/basic/frog = 5,
		/mob/living/basic/chicken = 4,
		/mob/living/basic/leaper = 1,
		/mob/living/basic/mega_arachnid = 1,
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

//Nearstation Jungle Gen
/datum/map_generator/nearstation_jungle_generator
	var/list/possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/plains,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGH_HUMIDITY = /datum/biome/water
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/plains,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/plains,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGH_HUMIDITY = /datum/biome/mudlands
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/plains,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/plains,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGH_HUMIDITY = /datum/biome/mudlands
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/wasteland,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/plains,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGH_HUMIDITY = /datum/biome/mudlands
		)
	)
	var/perlin_zoom = 65

/datum/map_generator/nearstation_jungle_generator/generate_terrain(list/turfs, area/generate_in)
	. = ..()
	var/height_seed = rand(0, 50000)
	var/humidity_seed = rand(0, 50000)
	var/heat_seed = rand(0, 50000)
	var/BIOME_RANDOM_SQUARE_DRIFT = 2

	for(var/t in turfs) //Go through all the turfs and generate them
		var/turf/gen_turf = t
		var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
		var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

		var/height = text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]"))


		var/datum/biome/selected_biome
		if(height <= 1) //If height is less than 0.85, we generate biomes based on the heat and humidity of the area.
			var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
			var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
			var/heat_level //Type of heat zone we're in LOW-MEDIUM-HIGH
			var/humidity_level  //Type of humidity zone we're in LOW-MEDIUM-HIGH

			switch(heat)
				if(0 to 0.25)
					heat_level = BIOME_LOW_HEAT
				if(0.25 to 0.5)
					heat_level = BIOME_LOWMEDIUM_HEAT
				if(0.5 to 0.75)
					heat_level = BIOME_HIGHMEDIUM_HEAT
				if(0.75 to 1)
					heat_level = BIOME_HIGH_HEAT
			switch(humidity)
				if(0 to 0.25)
					humidity_level = BIOME_LOW_HUMIDITY
				if(0.25 to 0.5)
					humidity_level = BIOME_LOWMEDIUM_HUMIDITY
				if(0.5 to 0.75)
					humidity_level = BIOME_HIGHMEDIUM_HUMIDITY
				if(0.75 to 1)
					humidity_level = BIOME_HIGH_HUMIDITY
			selected_biome = possible_biomes[heat_level][humidity_level]
		selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping
		selected_biome.generate_turf(gen_turf)
		CHECK_TICK
