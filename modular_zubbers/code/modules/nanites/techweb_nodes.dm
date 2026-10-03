/datum/techweb_node/nanite_base
	display_name = "Basic Nanite Programming"
	description = "The basics of nanite construction and programming. Nanites will passively generate science points based on how many are hosting them."
	prerequisite_nodes = list(/datum/techweb_node/bci)
	unlocked_designs = list(
		// /datum/design/nanites/access,
		/datum/design/nanites/nanite_debugging,
		/datum/design/nanites/monitoring,
		/datum/design/board/nanite_chamber,
		/datum/design/board/nanite_chamber_control,
		/datum/design/board/nanite_cloud_control,
		/datum/design/nanite_comm_remote,
		/datum/design/nanite_disk,
		/datum/design/board/nanite_program_hub,
		/datum/design/board/nanite_programmer,
		/datum/design/nanite_remote,
		/datum/design/nanite_scanner,
		/datum/design/board/public_nanite_chamber,
		/datum/design/nanites/relay,
		/datum/design/nanites/relay_repeater,
		/datum/design/nanites/repairing,
		/datum/design/nanites/repeater,
		/datum/design/nanites/sensor_nanite_volume,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_smart
	display_name = "Smart Nanite Programming"
	description = "Nanite programs that require nanites to perform complex actions, act independently, roam or seek targets."
	prerequisite_nodes = list(/datum/techweb_node/nanite_base, /datum/techweb_node/programming)
	unlocked_designs = list(
		/datum/design/nanites/memory_leak,
		/datum/design/nanites/metabolic_synthesis,
		/datum/design/nanites/purging,
		/datum/design/nanites/sensor_voice,
		/datum/design/nanites/stealth,
		/datum/design/nanites/voice,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_mesh
	display_name = "Mesh Nanite Programming"
	description = "Nanite programs that require static structures and membranes."
	prerequisite_nodes = list(/datum/techweb_node/nanite_base, /datum/techweb_node/mod_engi_adv)
	unlocked_designs = list(
		/datum/design/nanites/conductive,
		/datum/design/nanites/cryo,
		/datum/design/nanites/dermal_button,
		/datum/design/nanites/emp,
		/datum/design/nanites/hardening,
		/datum/design/nanites/refractive,
		/datum/design/nanites/shock,
		/datum/design/nanites/temperature,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_bio
	display_name = "Biological Nanite Programming"
	description = "Nanite programs that require complex biological interaction."
	prerequisite_nodes = list(/datum/techweb_node/nanite_base, /datum/techweb_node/mod_medical_adv)
	unlocked_designs = list(
		/datum/design/nanites/blood_restoring,
		/datum/design/nanites/coagulating,
		/datum/design/nanites/flesh_eating,
		/datum/design/nanites/poison,
		/datum/design/nanites/sensor_crit,
		/datum/design/nanites/sensor_damage,
		/datum/design/nanites/sensor_death,
		/datum/design/nanites/sensor_health,
		/datum/design/nanites/sensor_species,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/nanite_neural
	display_name = "Neural Nanite Programming"
	description = "Nanite programs affecting nerves and brain matter."
	prerequisite_nodes = list(/datum/techweb_node/nanite_bio)
	unlocked_designs = list(
		/datum/design/nanites/bad_mood,
		/datum/design/nanites/brain_heal,
		/datum/design/nanites/good_mood,
		/datum/design/nanites/nervous,
		/datum/design/nanites/paralyzing,
		/datum/design/nanites/self_scan,
		/datum/design/nanites/stun,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_synaptic
	display_name = "Synaptic Nanite Programming"
	description = "Nanite programs affecting mind and thoughts."
	prerequisite_nodes = list(/datum/techweb_node/nanite_neural, /datum/techweb_node/surgery_exp)
	unlocked_designs = list(
		/datum/design/nanites/blinding,
		/datum/design/nanites/hallucination,
		/datum/design/nanites/mindshield,
		/datum/design/nanites/mute,
		/datum/design/nanites/pacifying,
		/datum/design/nanites/sleepy,
		// /datum/design/nanites/speech,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_harmonic
	display_name = "Harmonic Nanite Programming"
	description = "Nanite programs that require seamless integration between nanites and biology. Passively increases nanite regeneration rate for all clouds upon researching."
	prerequisite_nodes = list(/datum/techweb_node/nanite_bio, /datum/techweb_node/nanite_smart, /datum/techweb_node/nanite_mesh)
	unlocked_designs = list(
		/datum/design/nanites/regenerative,
		/datum/design/nanites/aggressive_replication,
		/datum/design/nanites/brain_heal_advanced,
		/datum/design/nanites/defib,
		/datum/design/nanites/fake_death,
		/datum/design/nanites/purging_advanced,
		// /datum/design/nanites/regenerative_advanced,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_combat
	display_name = "Military Nanite Programming"
	description = "Nanite programs that perform military-grade functions."
	prerequisite_nodes = list(/datum/techweb_node/nanite_harmonic, /datum/techweb_node/syndicate_basic)
	unlocked_designs = list(
		// /datum/design/nanites/explosive,
		/datum/design/nanites/meltdown,
		/datum/design/nanites/nanite_sting,
		/datum/design/nanites/pyro,
		/datum/design/nanites/viral,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/nanite_hazard
	display_name = "Hazard Nanite Programs"
	description = "Extremely advanced Nanite programs with the potential of being extremely dangerous."
	prerequisite_nodes = list(/datum/techweb_node/nanite_harmonic, /datum/techweb_node/alien/base)
	unlocked_designs = list(
		/datum/design/nanites/mind_control,
		/datum/design/nanites/mitosis,
		// /datum/design/nanites/spreading,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_replication_protocols
	display_name = "Nanite Replication Protocols"
	description = "Protocols that overwrite the default nanite replication routine to achieve more efficiency in certain circumstances."
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		/datum/design/nanites/factory,
		/datum/design/nanites/kickstart,
		/datum/design/nanites/offline,
		/datum/design/nanites/pyramid,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

/datum/techweb_node/nanite_storage_protocols
	display_name = "Nanite Storage Protocols"
	description = "Protocols that overwrite the default nanite storage routine to achieve more efficiency or greater capacity."
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		/datum/design/nanites/free_range,
		/datum/design/nanites/hive,
		/datum/design/nanites/unsafe_storage,
		/datum/design/nanites/zip,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL
