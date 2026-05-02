/obj/item/heretic_labyrinth_handbook/examine(mob/user)
	. = ..()

	. += span_notice("Can be used to generate impenetrable barriers. Lasts for 8 seconds, 5 charges at a time.")

/datum/heretic_knowledge_tree_column/lock
	description = list(
		"The Path of Lock revolves around access, area denial, theft and gadgets.",
		"Pick this path if you are new to heretic, or want a less confrontational playstyle and more interested in being a slippery rat.",
	)
