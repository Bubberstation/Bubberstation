/datum/heretic_knowledge/portal_making
	name = "Town Portal Scroll Fabrication"
	desc = "Allows you to transmute a sheet of paper, a roll of cloth, a pen, and an alchemical orb into a Town Portal Scroll; \
	a special single-use piece of scroll that allows you to create a portal to the station's \"town\" (Usually the Bar) when used."
	gain_text = "There is no shame in escaping further into the abyss when in exile."

	next_knowledge = list(
		/datum/heretic_knowledge/resistance_helmet,
		/datum/heretic_knowledge/fire_resist_ring,
		/datum/heretic_knowledge/boots_purchase,
		/datum/heretic_knowledge/blade_upgrade/exile
	)

	required_atoms = list(
		/obj/item/paper = 1,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/pen = 1,
		/obj/item/heretic_currency/alchemical = 1
	)

	result_atoms = list(/obj/item/heretical_portal_scroll)

	cost = 1
	depth = 3

	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_portal.dmi'
	research_tree_icon_state = "scroll"
