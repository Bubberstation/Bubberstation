/*Code to enable spawning of persistence on icemoon. Unlike the lava map, we let this one be random to avoid issues with
missing roofs*/

/datum/map_template/ruin/icemoon/bubberstation/syndicate_crawler
	name = "Syndicate Ice Moon Land Crawler"
	id = "ice-crawler"
	description = "A syndicate mining operation used to mine materials in spite of NT claims. Also setup to provide agent support and comms monitoring"
	suffix = "icemoon_persistence.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/bubberstation/syndicate_crawler
	always_place = TRUE
	ruin_type = ZTRAIT_ICE_RUINS_UNDERGROUND

