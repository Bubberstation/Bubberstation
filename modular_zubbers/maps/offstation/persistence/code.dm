/datum/map_template/ruin/icemoon/bubberstation/syndicate_crawler
	name = "Syndicate Ice Moon Land Crawler"
	id = "ice-crawler"
	description = "A syndicate mining operation used to mine materials in spite of NT claims. Also setup to provide agent support and comms monitoring"
	suffix = "icemoon_persistence.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/bubberstation/dauntless,
							/datum/map_template/ruin/lavaland/bubberstation/syndicate_crawler)
	always_place = TRUE
	ruin_type = ZTRAIT_ICE_RUINS_UNDERGROUND

/datum/map_template/ruin/lavaland/bubberstation/syndicate_crawler
	name = "Syndicate Lavaland Land Crawler"
	id = "lava-crawler"
	description = "A syndicate mining operation used to mine materials in spite of NT claims. Also setup to provide agent support and comms monitoring"
	suffix = "lavaland_persistence.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/bubberstation/dauntless,
							/datum/map_template/ruin/icemoon/bubberstation/syndicate_crawler)
	always_place = TRUE
