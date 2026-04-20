// Having custom_materials set for the 9mm bullet in this recipe breaks unit tests
/datum/crafting_recipe/food/pizza/arnold
	crafting_flags = parent_type::crafting_flags & CRAFT_SKIP_MATERIALS_PARITY
