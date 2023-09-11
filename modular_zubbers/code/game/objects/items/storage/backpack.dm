/obj/item/storage/backpack/satchel/flat/PopulateContents()

	//Create 3 low TC traitor items.
	for(var/items in 1 to 3)
		var/obj/item/I = pick(SStraitor.smuggler_satchel_items)
		new I(src)

	//Create 1 drug.
	var/obj/item/I = pick(SStraitor.smuggler_satchel_contraband)
	new I(src)
