/datum/design/biogen/frontier_ration/ingredients
	name = "Frontier Rations Ingredients"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_FOODRICATOR_INGREDIENTS,
	)

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_egg
	name = "Egg"
	id = "frontier_ration_egg"
	build_path = /obj/item/food/egg

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_chicken
	name = "Chicken"
	id = "frontier_ration_chicken"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/chicken

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_mystery_meat
	name = "Meat Product"
	id = "frontier_ration_mystery_meat"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/meatproduct

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_butter
	name = "Butter"
	id = "frontier_ration_butter"
	build_path = /obj/item/food/butter

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_cheese
	name = "Cheese"
	id = "frontier_ration_cheese"
	build_path = /obj/item/food/cheese/wedge

/datum/design/biogen/frontier_ration/ingredients/frontier_ration_cheese_firm
	name = "Firm Cheese"
	id = "frontier_ration_firm_cheese"
	build_path = /obj/item/food/cheese/firm_cheese_slice
