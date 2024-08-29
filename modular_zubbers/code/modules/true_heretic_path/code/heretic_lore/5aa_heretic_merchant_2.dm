/datum/heretic_knowledge/limited_amount/heretic_merchant_part_2
	name = "Wizardblood Trading"
	desc = "Allows you to transmute a wizardblood and an orb of diviniation into a researchable heretical influence. This can be performed up to 5 times."
	gain_text = "When you have more, sell the more you don't need for even more."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/heretic_currency/divination = 1
		/obj/item/storage/belt/wizardblood = 1
	)
	result_atoms = list(/obj/effect/heretic_influence)

	cost = 2
	depth = 6
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "barter_wizardblood"

	limit = 5

/datum/heretic_knowledge/limited_amount/heretic_merchant_part_2/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)

	if(locate(/obj/effect/heretic_influence/) in loc)
		user.balloon_alert(user, "anomaly already on the ritual circle!")
		return FALSE

	return TRUE