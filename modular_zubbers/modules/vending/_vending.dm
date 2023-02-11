/obj/machinery/vending
	var/list/budder_products
	var/list/budder_products_categories
	var/list/budder_premium
	var/list/budder_contraband


/obj/machinery/vending/Initialize(mapload)
	if(budder_products) //This is probably not how I should do this.  Since it ignores Alphabetical order.
		products += budder_products

	if(budder_products_categories)
		for(var/category in budder_products_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break
			if(!already_exists)
				product_categories += category

	if(budder_premium)
		premium += budder_premium

	if(budder_contraband)
		contraband+= budder_contraband
	/*
	if(budder_products)
		for(var/items_to_add in budder_products)
			products[items_to_add] = budder_products[items_to_add]

	if(budder_products_categories)
		for(var/category in budder_products_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break
			if(!already_exists)
				product_categories += category

	if(budder_premium)
		for(var/items_to_add in budder_premium)
			premium[items_to_add] = budder_premium[items_to_add]

	if(budder_contraband)
		for(var/items_to_add in budder_premium)
			contraband[items_to_add] = budder_contraband[items_to_add]
*/
	QDEL_NULL(budder_products)
	QDEL_NULL(budder_products_categories)
	QDEL_NULL(budder_premium)
	QDEL_NULL(budder_contraband)
	return ..()
