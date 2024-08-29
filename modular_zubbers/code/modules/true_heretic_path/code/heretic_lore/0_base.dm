/*
The Path of Exile


Goes as follows:



*/

/datum/heretic_knowledge/limited_amount/starting/base_exile
	name = "Act One"
	desc = "Opens up the Path of Exile to you. \
		Allows you to transmute a knife, a sheet of iron, and a condenser into an Cold Iron Dagger, \
		which is less obvious than most heretical blades. \
		You can only create five at a time, and researching this will prevent you from accessing other heretic paths. You cannot research this path if you've already chosen a heretic path.\
		<b>Note that this heretic path is new and is currently undergoing testing! Expect this path to be either absurdly overpowered or absurdly weak!"
	gain_text = "Walk the steps of the Exile. Then walk them again. You will learn from their mistakes as well as yours."
	next_knowledge = list(
		/datum/heretic_knowledge/loot_grasp
	)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/iron = 1,
		/obj/item/assembly/igniter/condenser = 1
	)
	result_atoms = list(/obj/item/melee/sickly_blade/exile)
	route = PATH_EXILE
	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "dagger"
	limit = 5

/datum/heretic_knowledge/limited_amount/starting/base_exile/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	to_chat(user,span_admin("Note that this heretic path is new and is currently undergoing testing! Expect this path to be either absurdly overpowered or absurdly weak! Use at your own risk! If in the case that it is absurdly powerful, remember to show restraint!"))


/datum/heretic_knowledge/limited_amount/starting/base_exile/New(...)
	. = ..()
	for(var/datum/heretic_knowledge/knowledge_type as anything in subtypesof(/datum/heretic_knowledge))
		var/knowledge_route = initial(knowledge_type.route)
		if(!knowledge_route == PATH_SIDE || knowledge_route == src.route)
			continue
		banned_knowledge += knowledge_route