/datum/heretic_knowledge/map_making
	name = "Map Making"
	desc = "Allows you to transmute a sheet of cardboard, a sheet of paper, and a pen into a special map that, when used in hand, \
	teleports you and up to 5 nearby living beings to approximately the same area where the ritual took place."
	gain_text = "The creation of maps is an important step in following the Path of Exile."
	next_knowledge = list(
		// /datum/heretic_knowledge/wand_purchase, Disabled, for now.
		/datum/heretic_knowledge/fire_resist_ring,
		/datum/heretic_knowledge/blade_upgrade/exile,
		/datum/heretic_knowledge/boots_purchase
	)
	required_atoms = list(
		/obj/item/stack/sheet/cardboard = 1,
		/obj/item/paper = 1,
		/obj/item/pen = 1,
	)
	result_atoms = list(/obj/item/heretic_map)

	cost = 1
	depth = 3
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_maps.dmi'
	research_tree_icon_state = "map_filled"

/datum/heretic_knowledge/map_making/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)

	var/area/desired_area = loc.loc
	if(desired_area.area_flags & NOTELEPORT)
		to_chat(user,span_warning("[src] can't be completed! The area you are in seems to be protected from teleportation magic..."))
		return FALSE

	if(!istype(desired_area,/area/station))
		to_chat(user,span_warning("[src] can't be completed! The area you are in not interesting to the Exile... try a station area, perhaps."))
		return FALSE

	return TRUE


/datum/heretic_knowledge/map_making/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/heretic_map/created_map = new(loc)
	created_map.set_map(loc.loc)
	ADD_TRAIT(created_map, TRAIT_CONTRABAND, INNATE_TRAIT)
	return TRUE
