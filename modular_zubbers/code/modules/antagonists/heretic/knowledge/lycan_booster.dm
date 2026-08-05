/datum/heretic_knowledge/lycan_booster
	name = "Lycanthropy Awakening"
	desc = "Sacrifice a heart, a slab of meat, and a dead mouse to massively improve the combat performance of a cursekin's lycan form, including \
	significant health regeneration, extremely sharp claws, and more."
	gain_text = "The Light grants Luna's blessing to those that would seek it out."
	research_tree_icon_path = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	research_tree_icon_state = "wolverine"
	drafting_tier = 4
	drafting_cost = 7
	required_atoms = list(/obj/item/organ/heart = 1, /obj/item/food/meat/slab = 1, /obj/item/food/deadmouse = 1)

/datum/heretic_knowledge/lycan_booster/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if (!.)
		return FALSE

	var/mob/living/carbon/human/found_human = locate() in range(loc, 1)
	if (!iscursekin(found_human))
		loc.balloon_alert(user, "target must be a cursekin!")
		return FALSE
	return TRUE

/datum/heretic_knowledge/lycan_booster/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/found_human = locate() in range(loc, 1)
	if (!iscursekin(found_human))
		loc.balloon_alert(user, "target must be a cursekin!")
		return FALSE

	found_human.add_gaian_physique()
	return TRUE
