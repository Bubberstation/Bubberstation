//Taken from Modular Vending in Skyrat

/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/zubbers_products
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/zubbers_product_categories
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/zubbers_premium
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/zubbers_contraband

/obj/machinery/vending/Initialize(mapload)
	if(zubbers_products)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in zubbers_products)
			products[item_to_add] = zubbers_products[item_to_add]

	if(zubbers_product_categories)
		for(var/category in zubbers_product_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(zubbers_premium)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in zubbers_premium)
			premium[item_to_add] = zubbers_premium[item_to_add]

	if(zubbers_contraband)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in zubbers_contraband)
			contraband[item_to_add] = zubbers_contraband[item_to_add]

	zubbers_products = null
	zubbers_product_categories = null
	zubbers_premium = null
	zubbers_contraband = null
	return ..()

