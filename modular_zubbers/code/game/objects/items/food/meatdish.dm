/obj/item/food/lava_chicken
	name = "lava chicken"
	desc = "It's tasty as hell! But it's also a lava attack!"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	icon = 'modular_zubbers/icons/obj/food/meat.dmi'
	icon_state = "lava_chicken"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/toxin/spore_burning = 50)
	tastes = list("l-l-l-lava" = 40, "ch-ch-ch-chicken" = 40)
	foodtypes = MEAT | FRIED
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL
