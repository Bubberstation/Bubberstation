/* Disabled because broken
/datum/heretic_knowledge/wand_purchase
	name = "Prophetic Wand of Heretical Fireball"
	desc = "Allows you to transmute an igniter, a wooden log, and a sheet of plasma into a low-charge self-recharging \
	wand that shoots lesser fireballs. Additionally, preforming this ritual will make you magically gifted, \
	allowing you to use some wizard items without consequence."
	gain_text = "Magic is essential to the Exile in order to survive this world. Use it well."
	next_knowledge = list(

	)
	required_atoms = list(
		/obj/item/grown/log = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stack/sheet/mineral/plasma = 1
	)
	result_atoms = list(/obj/item/gun/magic/wand/fireball/heretic)

	cost = 2
	depth = 3
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "wand"

/datum/heretic_knowledge/wand_purchase/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	ADD_TRAIT(user,TRAIT_MAGICALLY_GIFTED,EXILE_MAGIC)
*/