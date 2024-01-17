/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/lavaland/bubberstation
	prefix = "_maps/RandomRuins/LavaRuins/bubberstation/"

/datum/map_template/ruin/icemoon/bubberstation
	prefix = "_maps/RandomRuins/IceRuins/bubberstation/"

/*------*/

/datum/map_template/ruin/lavaland/bubberstation/dauntless
	name = "SSV Dauntless"
	id = "lava-ship"
	description = "Highly secretive syndicate spy vessel hidden behind rolling storms of ash. It's assigned to observe NanoTrasen activities after the destruction of DS-2"
	suffix = "lavaland_dauntless.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/icemoon/underground/skyrat/syndicate_base, /datum/map_template/ruin/icemoon/bubberstation/dauntless)
	always_place = TRUE

/datum/map_template/ruin/icemoon/bubberstation/dauntless
	name = "SSV Dauntless"
	id = "ice-ship"
	description = "Highly secretive syndicate spy vessel hidden within a deep crater underground. It's assigned to observe NanoTrasen activities after the destruction of DS-2"
	suffix = "icemoon_underground_dauntless.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/skyrat/syndicate_base, /datum/map_template/ruin/lavaland/bubberstation/dauntless)
	always_place = TRUE
