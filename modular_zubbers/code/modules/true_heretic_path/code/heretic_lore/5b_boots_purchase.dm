/datum/heretic_knowledge/boots_purchase
	name = "Boots of Speed"
	desc = "Allows you to transmute an igniter, a wooden log, and a sheet of plasma into a low-charge wand that shoots lesser fireballs."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/clothing/shoes/workboots = 1,
		/obj/item/toy/crayon/red = 1,
		/obj/item/reagent_containers/cup/endless_flask/stimulants = 1
	)
	result_atoms = list(/obj/item/clothing/shoes/workboots/speed)
	cost = 1
	route = PATH_EXILE
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8




