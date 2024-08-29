/datum/heretic_knowledge/limited_amount/real_mirror_trading
	name = "Real Mirror Trading"
	desc = "Allows you to transmute the rare and elusive orb of mirroring into 5000 credits. This can be performed up to 5 times."
	gain_text = "When you have more, sell the more you don't need for even more."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/heretic_currency/mirroring = 1
	)
	result_atoms = list(
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000
	)

	cost = 1
	depth = 2

	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "barter_mirror"

	limit = 5