/obj/machinery/vending/hydroseeds/Initialize(mapload)
	for(var/category in product_categories)
		if(category["name"] == "Fruits")
			category["products"] += list(/obj/item/seeds/rockfruit = 3)

	return ..()
