/datum/controller/subsystem/mapping/setup_rivers()
	var/list/jungle_caves_ruins = levels_by_trait(ZTRAIT_JUNGLE_CAVE_RUINS)
	for (var/junglecaves_z in jungle_caves_ruins)
		spawn_rivers(junglecaves_z, 4, /turf/open/water/jungle, /area/taeloth/underground/unexplored)
	return ..()

/datum/controller/subsystem/mapping/setup_ruins()
	// Taeloth / Jungle Ruins, Rimpoint
	var/list/jungle_ruins = levels_by_trait(ZTRAIT_JUNGLE_RUINS)
	if(jungle_ruins.len)
		seedRuins(jungle_ruins, CONFIG_GET(number/jungle_budget), list(/area/taeloth/unexplored), themed_ruins[ZTRAIT_JUNGLE_RUINS], clear_below = TRUE)

	// Taeloth Caves / Jungle Cave Ruins, Rimpoint
	var/list/jungle_cave_ruins = levels_by_trait(ZTRAIT_JUNGLE_CAVE_RUINS)
	if(jungle_cave_ruins.len)
		seedRuins(jungle_ruins, CONFIG_GET(number/jungle_cave_budget), list(/area/taeloth/underground/unexplored), themed_ruins[ZTRAIT_JUNGLE_CAVE_RUINS], clear_below = TRUE)

	// Ocean Ruins, Sigma Octantis
	var/list/ocean_ruins = levels_by_trait(ZTRAIT_OCEAN_RUINS)
	if(ocean_ruins.len)
		seedRuins(ocean_ruins, CONFIG_GET(number/ocean_budget), list(/area/ocean/generated), themed_ruins[ZTRAIT_OCEAN_RUINS], clear_below = TRUE)

	// Trench Ruins, Sigma Octantis
	var/list/trench_ruins = levels_by_trait(ZTRAIT_TRENCH_RUINS)
	if(trench_ruins.len)
		seedRuins(trench_ruins, CONFIG_GET(number/trench_budget), list(/area/ocean/trench/generated), themed_ruins[ZTRAIT_TRENCH_RUINS], clear_below = TRUE)
	return ..()
