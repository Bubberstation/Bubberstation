/datum/heretic_knowledge/boots_purchase
	name = "Boots of Speed"
	desc = "Allows you to transmute a pair of workboots, a red crayon, and a flask of stimulants into a pair of Boots of Speed."
	gain_text = "The red crayon makes it go faster."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/clothing/shoes/workboots = 1,
		/obj/item/toy/crayon/red = 1,
		/obj/item/reagent_containers/cup/endless_flask/stimulants = 1
	)
	result_atoms = list(/obj/item/clothing/shoes/workboots/speed)

	cost = 1
	depth = 6
	route = PATH_EXILE

	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"





