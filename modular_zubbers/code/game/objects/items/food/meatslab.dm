/obj/item/food/meat/slab/drakebait
	name = "Seasoned Goliath Meat"
	desc = "A slab of goliath meat. It's been blessed somehow, Often seen as an offering for Ash Drakes."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/toxin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 5,
	)
	icon_state = "bearsteak"
	tastes = list("meat" = 1)
	foodtypes = MEAT | TOXIC
