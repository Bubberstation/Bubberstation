/*
The Path of Exile


Goes as follows:

Act One
Grasp of Looting
----Optional: Satchel of Looting
Ring of Determination
----Optional: Prophetic Wand of Heretical Fireball

Mark of Mansus
Ritual of Knowledge
Auto-Alchemical Creation
----Optional: Wizardblood
----Optional: Boots of Speed
Hidden Fishing

Elder's Insanity
Map Making
----Optional: Advanced Map Making
----Optional: Exile's Vision

Resistance Capped

*/

/datum/heretic_knowledge/limited_amount/starting/base_exile
	name = "Act One"
	desc = "Opens up the Path of Exile to you. \
		Allows you to transmute a knife and a sheet of iron into an Cold Iron Dagger, \
		which is less obvious than most heretical blades. \
		You can only create five at a time."
	gain_text = "Walk the steps of the Exile. Then walk them again. You will learn from their mistakes as well as yours."
	next_knowledge = list(
		/datum/heretic_knowledge/loot_grasp
	)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/iron = 1
	)
	result_atoms = list(/obj/item/melee/sickly_blade/exile)
	route = PATH_EXILE
	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	research_tree_icon_state = "dagger"
	limit = 5

