/* Disabled because linters complain.
/datum/heretic_knowledge/limited_amount/skullhunter_trading
	name = "Skullhunter Trading"
	desc = "Allows you to transmute a skullhunter with at least 5 different access names stolen and an orb of diviniation into a \
	researchable heretical influence. This can be performed up to 3 times."
	gain_text = "Trading is essential to the Path of Exile. Without it, it would be nothing."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/heretic_currency/divination = 1,
		/obj/item/storage/belt/skullhunter = 1,
	)
	result_atoms = list(/obj/effect/heretic_influence)

	cost = 1
	depth = 4
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "barter_skullhunter"

	limit = 3

/datum/heretic_knowledge/limited_amount/skullhunter_trading/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)

	if(locate(/obj/effect/heretic_influence/) in loc)
		user.balloon_alert(user, "anomaly already on the ritual circle!")
		return FALSE

	for(var/obj/item/storage/belt/skullhunter/found_skull in atoms)
		if(length(found_skull.stolen_id_names) < 5)
			atoms -= found_skull //not good enough
			continue

	return TRUE
*/