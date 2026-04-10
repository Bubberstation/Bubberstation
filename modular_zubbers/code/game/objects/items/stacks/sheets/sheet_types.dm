/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += /datum/stack_recipe("dirty mattress", /obj/structure/bed/maint, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE)
