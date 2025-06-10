/datum/techweb_node/basic_arms/New()
	id = TECHWEB_NODE_BASIC_ARMS
	starting_node = TRUE
	display_name = "Basic Arms"
	description = "Ballistics can be unpredictable in space."
	design_ids = list(
		"toy_armblade",
		"toygun",
		"c38_rubber",
		"c38_rubber_mag",
		"c38_sec",
		"c38_mag",
		"capbox",
		"foam_dart",
		"sec_beanbag_slug",
		"sec_dart",
		"sec_Islug",
		"sec_rshot",
		"c9mm_sec",
		"m9mm_sec",
		)

/datum/techweb_node/exotic_ammo/New()
	id = TECHWEB_NODE_EXOTIC_AMMO
	display_name = "Exotic Ammunition"
	description = "Specialized bullets designed to ignite, freeze, and inflict various other effects on targets, expanding combat capabilities."
	prereq_ids = list(TECHWEB_NODE_EXPLOSIVES)
	design_ids = list(
		"c38_hotshot",
		"c38_hotshot_mag",
		"c38_iceblox",
		"c38_iceblox_mag",
		"c38_trac",
		"c38_trac_mag",
		"c38_true_strike",
		"c38_true_strike_mag",
		"techshotshell",
		"flechetteshell",
		"m9mm_sec_rocket",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/explosive/highyieldbomb = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)
