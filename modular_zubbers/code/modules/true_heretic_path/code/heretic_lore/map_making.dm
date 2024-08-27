/datum/heretic_knowledge/map_making
	name = "Map Making"
	desc = "Allows you to transmute a metamaterial beaker and a heart into a magical flask that refills with with one of the selected reagents: \
	Godblood, Stimulants, Saturn-X, Blastoff, or Determination."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/sheet/cardboard = 1,
		/obj/item/paper = 1,
		/obj/item/pen = 1,
	)
	result_atoms = list(/obj/item/heretic_map)
	cost = 1
	route = PATH_ASH
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	depth = 8

/datum/heretic_knowledge/map_making/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)

	var/area/desired_area = loc.loc
	if(desired_area.area_flags & NOTELEPORT)
		user.to_chat(span("warning","[src] can't be completed! The area you are in seems to be protected from teleportation magic..."))
		return FALSE

	if(!istype(desired_area,/area/station))
		user.to_chat(span("warning","[src] can't be completed! The area you are in not interesting to the Exile... try a station area, perhaps."))
		return FALSE

	return TRUE


/datum/heretic_knowledge/map_making/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/heretic_map/created_map = new(loc)
	heretic_map.set_map(turf.loc)
	ADD_TRAIT(heretic_map, TRAIT_CONTRABAND, INNATE_TRAIT)
	return TRUE
