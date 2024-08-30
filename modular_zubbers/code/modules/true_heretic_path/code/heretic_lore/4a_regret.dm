/datum/heretic_knowledge/regret

	name = "Regretable Change"
	desc = "Allows you to sacrifice a bar of soap to clear fantasy modifiers on all items on the center of the ritual circle. Because the Mansus is generous, the bar of soap is not consumed in this ritual! Yay!"
	gain_text = "Oh fuck go back"

	required_atoms = list(
		/obj/item/soap = 1
	)

	cost = 1
	depth = 5
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "regret"

/datum/heretic_knowledge/regret/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	for(var/atom/A as anything in loc)
		var/datum/component/fantasy/found_component = A.GetComponent(/datum/component/fantasy)
		if(!found_component)
			continue
		qdel(found_component)