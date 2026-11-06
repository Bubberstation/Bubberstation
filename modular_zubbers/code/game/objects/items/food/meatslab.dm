/obj/item/food/meat/slab/drakebait
	name = "seasoned goliath meat"
	desc = "A slab of goliath meat, influenced by the Mother Tendril to be especially delicious to Ash Drakes. Something about it calms them enough to shed excess scales."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/toxin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 5,
	)
	icon_state = "bearsteak"
	tastes = list("meat" = 1)
	foodtypes = MEAT | TOXIC
