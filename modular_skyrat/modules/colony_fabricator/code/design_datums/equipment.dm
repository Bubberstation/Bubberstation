/datum/design/survival_knife
	name = "Survival Knife"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6,
	)
	build_path = /obj/item/knife/combat/survival
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

// Soup pot
/datum/design/colony_soup_pot
	name = "Soup Pot"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/reagent_containers/cup/soup_pot
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

// Autolathe contraband for hacked fabricators. Designs owned by other nodes are left out
/datum/techweb_node/colony_fabricator_contraband
	display_name = "Colony Fabricator Contraband Designs"
	description = "Contains all of the colony fabricator's hidden designs."
	unlocked_designs = list(
		/datum/design/a357,
		/datum/design/c357/peacemaker,
		/datum/design/c10mm,
		/datum/design/c45,
		/datum/design/c45_lethal,
		/datum/design/c46x30mm,
		/datum/design/c9mm,
		/datum/design/c9mm_sec,
		/datum/design/cleaver,
		/datum/design/paper_biscuit_confidential,
		/datum/design/flamethrower,
		/datum/design/handcuffs,
		/datum/design/incendiary_slug,
		/datum/design/receiver,
		/datum/design/riot_dart,
		/datum/design/riot_darts,
		/datum/design/electropack/shockcollar,
		/datum/design/shotgun_dart,
		/datum/design/strilka310_surplus,
		/datum/design/foilhat,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY)
	node_flags = TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

/datum/design/frontier_radio_headset
	name = "Frontier Radio Headset"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.75,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5,
	)
	transfered_materials = list(
		/obj/item/radio/headset/headset_frontier_colonist = /obj/item/radio/headset/headset_frontier_colonist::custom_materials,
		/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell::custom_materials,
	)
	build_path = /obj/item/radio/headset/headset_frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
