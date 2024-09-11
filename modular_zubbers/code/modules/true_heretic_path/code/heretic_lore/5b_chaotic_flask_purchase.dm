/datum/heretic_knowledge/chaotic_flask_purchase
	name = "Chaotic Auto-Alchemical Creation"
	desc = "Allows you to transmute two endless flasks, a maintenance pill, and a chaotic orb into a \
	magical flask self-refilling that refills with with an absolutely random reagent. Only for the brave. Or insane."
	gain_text = "Lets go gambling!"
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/reagent_containers/cup/endless_flask = 2,
		/obj/item/reagent_containers/pill/maintenance = 1,
		/obj/item/heretic_currency/chaotic = 1
	)
	result_atoms = list(
		/obj/item/reagent_containers/cup/endless_flask/random
	)

	cost = 1
	depth = 6
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "flask_chaos"
