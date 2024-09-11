/datum/heretic_knowledge/belt_purchase
	name = "Wizardblood"
	desc = "Allows you to transmute an iv drip, an arm, a leg, a storage belt, and a mirroring orb \
	into a powerful and expensive belt that automatically applies the effects of stored flasks to you while worn."
	gain_text = "The desired object of every exile; a belt that fits."
	next_knowledge = list(
		/datum/heretic_knowledge/limited_amount/wizardblood_trading
	)
	required_atoms = list(
		/obj/item/storage/belt = 1,
		/obj/machinery/iv_drip = 1,
		/obj/item/bodypart/arm = 1,
		/obj/item/bodypart/leg = 1,
		/obj/item/heretic_currency/mirroring = 1,
	)
	result_atoms = list(/obj/item/storage/belt/wizardblood)

	cost = 2
	depth = 6
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	research_tree_icon_state = "wizardblood"
