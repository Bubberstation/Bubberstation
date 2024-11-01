// Taken from Modular Vending in Bubber
// All entries will become null after Initialize, to free up memory.

/obj/machinery/vending
	// Additions to the `products` list
	var/list/zzplurt_products
	// Additions to the `product_categories` list
	var/list/zzplurt_product_categories
	// Additions to the `premium` list
	var/list/zzplurt_premium
	// Additions to the `contraband` list
	var/list/zzplurt_contraband

/obj/machinery/vending/Initialize(mapload)
	if(zzplurt_products)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in zzplurt_products)
			products[item_to_add] = zzplurt_products[item_to_add]

	if(zzplurt_product_categories)
		for(var/category in zzplurt_product_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(zzplurt_premium)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in zzplurt_premium)
			premium[item_to_add] = zzplurt_premium[item_to_add]

	if(zzplurt_contraband)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in zzplurt_contraband)
			contraband[item_to_add] = zzplurt_contraband[item_to_add]

	QDEL_NULL(zzplurt_products)
	QDEL_NULL(zzplurt_product_categories)
	QDEL_NULL(zzplurt_premium)
	QDEL_NULL(zzplurt_contraband)
	return ..()
