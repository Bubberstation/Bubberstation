// Having custom_materials set for the 9mm bullet in this recipe breaks unit tests
/datum/crafting_recipe/food/pizza/arnold/New()
	crafting_flags &= ~CRAFT_ENFORCE_MATERIALS_PARITY
	. = ..()
