/**
 * The opposite of proc/teach_crafting_recipe
 * will attempt to remove the arg "recipe" from the learned recipes
 */
/datum/mind/proc/unteach_crafting_recipe(recipe)
	if(!learned_crafting_recipes)
		return

	learned_crafting_recipes &= ~recipe
