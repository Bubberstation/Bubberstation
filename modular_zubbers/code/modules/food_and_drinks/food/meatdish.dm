/obj/item/food/fishmeat/shrimp
	name = "raw shrimp"
	desc = "A freshly prepared shrimp."
	icon = 'modular_zubbers/icons/obj/food/meat.dmi'
	icon_state = "shrimp"
	tastes = list("raw shrimp" = 1)
	bite_consumption = 3
	fillet_name = "raw %NAME"

/obj/item/food/fishmeat/shrimp/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/fried_shrimp, rand(40 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/fried_shrimp
	name = "fried shrimp"
	desc = "Shrimp that someone has fried."
	icon = 'modular_zubbers/icons/obj/food/meat.dmi'
	icon_state = "shrimp_cooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 3
	tastes = list("shrimp" = 1)
	foodtypes = JUNKFOOD | SEAFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2
