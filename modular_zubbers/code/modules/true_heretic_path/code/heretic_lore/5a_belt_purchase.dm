/datum/heretic_knowledge/belt_purchase
	name = "Wizardblood"
	desc = "Allows you to transmute any belt, an iv drip, an arm, and a leg into a powerful and expensive belt that automatically applies the effects of stored flasks to you while worn."
	gain_text = "The result of having more is that you can have more."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/storage/belt = 1,
		/obj/machinery/iv_drip = 1,
		/obj/item/bodypart/arm = 1,
		/obj/item/bodypart/leg = 1
	)
	result_atoms = list(/obj/item/storage/belt/wizardblood)

	cost = 1
	depth = 6
	route = PATH_EXILE

	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
