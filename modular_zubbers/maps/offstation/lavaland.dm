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

/datum/map_template/ruin/lavaland/bubberstation/boss_vent
	name = "Lava-Ruin Rite Location"
	id = "lava_r_boss_vent"
	description = "A site paved with stones, to disturb it is to fight the fears within."
	suffix = "lavaland_surface_boss_vent.dmm" // 11x11
	allow_duplicates = FALSE
	cost = 0 // We'll steal ore vent costs for vents
	mineral_cost = 1 //One vent
