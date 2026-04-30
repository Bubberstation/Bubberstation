/obj/item/heretic_labyrinth_handbook/examine(mob/user)
	. = ..()

	. += span_notice("Can be used to generate impenetrable barriers. Lasts for 8 seconds, 5 charges at a time.")
