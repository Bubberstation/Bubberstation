/datum/heretic_knowledge/chaotic_flask_purchase
	name = "Chaotic Auto-Alchemical Creation"
	desc = "Allows you to transmute a bluespace beaker, a heart, 3 maintenance pills, and a chaotic orb into a \
	magical flask that refills with with an absolutely random reagent. Only for the brave. Or insane."
	gain_text = "Lets go gambling!"
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/reagent_containers/cup/beaker/bluespace = 1,
		/obj/item/organ/internal/heart = 1,
		/obj/item/heretic_currency/chaotic = 1,
		/obj/item/reagent_containers/pill/maintenance = 3
	)
	result_atoms = list(
		/obj/item/reagent_containers/cup/endless_flask/random
	)

	cost = 3
	depth = 6
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "flask_chaos"
