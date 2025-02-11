/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/bubberstation
	prefix = "_maps/RandomRuins/IceRuins/bubberstation/"
/*------*/

/datum/map_template/ruin/icemoon/bubberstation/geovent
	name = "Ice-ruin Surface Geological Site"
	id = "snow_geovent"
	description = "A mishap during geological site testing ended a poor man's life. Anyways, Roll a d10 to loot the body."
	suffix = "icemoon_surface_geovent.dmm"
	allow_duplicates = FALSE
	cost = 1 // has a miner body and BSC. thats about it.
	mineral_cost = 1 // has 1 vent. Sure its one of the reseting ones but its a vent.
