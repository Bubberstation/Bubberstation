//This is for Moonstation.
/datum/controller/subsystem/mapping/setup_rivers()
	. = ..()
	// Generate mining ruins
	var/list/moonstation_ruins = levels_by_trait(ZTRAIT_MOONSTATION_RUINS)
	for (var/moon_z in moonstation_ruins)
		spawn_rivers(moon_z, 4, /turf/open/lava/smooth/lava_land_surface, /area/lavaland/surface/outdoors/unexplored)
		spawn_rivers(moon_z, 8, /turf/open/water/moonstation, /area/moonstation/underground/unexplored)
		spawn_rivers(moon_z, 8, /turf/open/water/moonstation/surface, /area/moonstation/surface/unexplored)

/datum/controller/subsystem/mapping/setup_ruins()
	. = ..()
	var/list/moonstation_ruins = levels_by_trait(ZTRAIT_MOONSTATION_RUINS)
	if (moonstation_ruins.len)
		seedRuins(moonstation_ruins, CONFIG_GET(number/lavaland_budget), list(/area/lavaland/surface/outdoors/unexplored), themed_ruins[ZTRAIT_LAVA_RUINS], clear_below = TRUE, mineral_budget = 15, mineral_budget_update = OREGEN_PRESET_LAVALAND)
	var/list/loopstation_level = levels_by_trait(ZTRAIT_LOOPSTATION)
	if(loopstation_level.len) //We just need at least 1 to place it.
		var/datum/space_level/empty_level = add_new_zlevel("Loop Station", ZTRAITS_SPACE, contain_turfs = FALSE)
		load_map(
			file("_maps/loopstation/loopstation.dmm"),
			0,
			0,
			empty_level.z_value,
			no_changeturf = TRUE,
			new_z = TRUE,
			place_on_top  = TRUE,
			no_changeturf = (SSatoms.initialized == INITIALIZATION_INSSATOMS)
		)
