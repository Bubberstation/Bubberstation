/datum/design/survival_knife
	name = "Survival Knife"
	id = "survival_knife"
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

// Upstream took the soup pot out of the autolathe, which took it out of the fabricator with it
/datum/design/colony_soup_pot
	name = "Soup Pot"
	id = "colony_soup_pot"
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

// The autolathe's contraband list. A fabricator only shows these once its hack wire has been found.
// Designs another node already owns are left out, since a design can only sit in one node
/datum/techweb_node/colony_fabricator_contraband
	id = TECHWEB_NODE_COLONY_CONTRABAND
	display_name = "Colony Fabricator Contraband Designs"
	description = "Contains all of the colony fabricator's hidden designs."
	design_ids = list(
		"a357",
		"a357PM",
		"c10mm",
		"c45",
		"c45_lethal",
		"c46x30mm",
		"c9mm",
		"c9mm_sec",
		"cleaver",
		"confidential_biscuit",
		"flamethrower",
		"handcuffs",
		"incendiary_slug",
		"receiver",
		"riot_dart",
		"riot_darts",
		"shockcollar",
		"shotgun_dart",
		"strilka310_surplus",
		"tinfoil_hat",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY)
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

/datum/design/frontier_radio_headset
	name = "Frontier Radio Headset"
	id = "frontier_radio_headset"
	build_type = COLONY_FABRICATOR
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.75)
	build_path = /obj/item/radio/headset/headset_frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
