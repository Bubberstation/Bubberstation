/obj/item/food/nekoroll
	name = "neko roll"
	desc = "A cute sushi roll in the shape of a cat face. Almost too adorable to eat."
	icon = 'modular_zubbers/icons/obj/food/food.dmi'
	icon_state = "nekoroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("rice" = 1, "fish" = 1, "cuteness" = 1)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/bignekoroll
	name = "nekobara roll"
	desc = "A fistful of rice with a crude cat face on it. It's got a fishy scent, too."
	icon = 'modular_zubbers/icons/obj/food/food.dmi'
	icon_state = "bignekoroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("rice" = 1, "fish" = 1, "wastefulness" = 1)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_SMALL
