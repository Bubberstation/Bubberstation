/obj/item/storage/backpack/satchel/flat/PopulateContents()

	//Create 3 low TC traitor items.
	for(var/i in 1 to 3)
		var/obj/item/I = pick(SStraitor.smuggler_satchel_items)
		new I(src)

	//Create 2 drugs.
	for(var/i in 1 to 2)
		var/obj/item/I = pick(SStraitor.smuggler_satchel_contraband)
		new I(src)
