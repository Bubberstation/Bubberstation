
/datum/heretic_knowledge/limited_amount/wand_purchase
	name = "Prophetic Fire Wand"
	desc = "Allows you to transmute an igniter, a wooden log, a sheet of plasma into a low-charge self-recharging \
	wand that shoots lesser fireballs. Additionally, preforming this ritual will make you magically gifted, \
	allowing you to use some wizard federation items without consequence. \
	Note that this ritual can only be performed once!"
	gain_text = "Magic is essential to the Exile in order to survive this world. Use it well."
	next_knowledge = list(
		/datum/heretic_knowledge/map_making
	)
	required_atoms = list(
		/obj/item/grown/log = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stack/sheet/mineral/plasma = 1
	)
	result_atoms = list(/obj/item/gun/magic/wand/fireball/heretic)

	cost = 1
	depth = 7
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "wand"

	limit = 1

/datum/heretic_knowledge/limited_amount/wand_purchase/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	ADD_TRAIT(user,TRAIT_MAGICALLY_GIFTED,EXILE_MAGIC)
