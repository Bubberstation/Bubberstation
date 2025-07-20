//This is for Moonstation.
/datum/controller/subsystem/mapping/setup_rivers()
	. = ..()
	// Generate mining ruins
	var/list/moonstation_ruins = levels_by_trait(ZTRAIT_MOONSTATION_RUINS)
	for (var/moon_z in moonstation_ruins)
		spawn_rivers(moon_z, 4, /turf/open/lava/smooth/lava_land_surface, /area/lavaland/surface/outdoors/unexplored)
		spawn_rivers(moon_z, 8, /turf/open/water/moonstation, /area/moonstation/underground/unexplored)



/datum/controller/subsystem/mapping/setup_ruins()
	. = ..()
	var/list/moonstation_ruins = levels_by_trait(ZTRAIT_MOONSTATION_RUINS)
	if (moonstation_ruins.len)
		seedRuins(moonstation_ruins, CONFIG_GET(number/lavaland_budget), list(/area/lavaland/surface/outdoors/unexplored), themed_ruins[ZTRAIT_LAVA_RUINS], clear_below = TRUE, mineral_budget = 15, mineral_budget_update = OREGEN_PRESET_LAVALAND)
