/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/lavaland/bubberstation
	prefix = "_maps/RandomRuins/LavaRuins/bubberstation/"
/*------*/

/datum/map_template/ruin/lavaland/bubberstation/geovent
	name = "Lava-Ruin Geological site"
	id = "lava_geovent"
	description = "A legion encounter during geological site extraction costed everyone their lives. Even the dwarf."
	suffix = "lavaland_surface_geovent.dmm"
	allow_duplicates = FALSE
	cost = 0 // We'll steal ore vent costs, since this provides 2 vents on lavaland in a public manner
	mineral_cost = 2
