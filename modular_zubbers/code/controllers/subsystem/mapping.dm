//This is for Moonstation.

/datum/controller/subsystem/mapping/setup_rivers()
	. = ..()
	// Generate mining ruins
	var/list/lava_ruins = levels_by_trait(ZTRAIT_MOONSTATION_RUINS)
	for (var/lava_z in lava_ruins)
		spawn_rivers(lava_z, 4, /turf/open/lava/smooth/lava_land_surface, /area/lavaland/underground/unexplored)

/datum/controller/subsystem/mapping/setup_ruins()
	. = ..()
	var/list/lava_ruins = levels_by_trait(ZTRAIT_MOONSTATION_RUINS)
	if (lava_ruins.len)
		seedRuins(lava_ruins, CONFIG_GET(number/lavaland_budget), list(/area/lavaland/underground/unexplored), themed_ruins[ZTRAIT_LAVA_RUINS], clear_below = TRUE)
