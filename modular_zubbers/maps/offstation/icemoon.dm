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

/datum/map_template/ruin/icemoon/underground/bubberstation/ice_boss_vent
	name = "Ice-ruin Frozen Rite Location"
	id = "ice_r_boss_vent"
	description = "They believed sacrifices could give more rewards. They were not prepared for the felling of their hubris."
	suffix = "icemoon_underground_boss_vent.dmm"
	allow_duplicates = FALSE
	cost = 0
	mineral_cost = 1

/datum/map_template/ruin/icemoon/underground/bubberstation/ice_elite_vent
	name = "Ice-Ruin Frozen Well Location"
	id = "ice_r_elite_vent"
	description = "Jimmy never fell in the well. But it wasn't Jimmy that walked away"
	suffix = "icemoon_underground_elite_vent.dmm"
	allow_duplicates = FALSE
	cost = 0
	mineral_cost = 1
