/obj/structure/closet/crate/large/smithing
	name = "smithing equipment crate"
	desc = "A hefty wooden crate full of smithing equipment. You'll need a crowbar to get it open."

/obj/structure/closet/crate/large/smithing/PopulateContents()
	new /obj/structure/reagent_anvil(src)
	new /obj/structure/reagent_crafting_bench(src)
	new /obj/structure/reagent_dispensers/reagent_smithing_basin(src)
	new /obj/structure/reagent_forge(src)
	new /obj/item/reagent_containers/cup/jerrycan/smithing_oil(src)
	new /obj/item/reagent_containers/cup/jerrycan/smithing_oil(src)
	new /obj/item/wallframe/wall_heater(src)
	new /obj/item/wrench

/obj/structure/closet/crate/wooden/blacksmith
	name = "blacksmith's equipment crate"

/obj/structure/closet/crate/wooden/blacksmith/PopulateContents()
	new /obj/item/forging/tongs(src)
	new /obj/item/forging/hammer(src)
	new /obj/item/forging/billow(src)
	var/obj/item/stack/sheet/tempstack = new /obj/item/stack/sheet/mineral/wood(src)
	tempstack.add(9)
	new /obj/item/stack/sheet/mineral/coal/five(src)
	tempstack = new /obj/item/stack/sheet/glass(src)
	tempstack.add(9)
	new /obj/item/stack/sheet/iron/ten(src)

/obj/item/storage/box/blacksmith
	name = "box of smithing tools"

/obj/item/storage/box/blacksmith/PopulateContents()
	new /obj/item/forging/tongs(src)
	new /obj/item/forging/hammer(src)
	new /obj/item/forging/billow(src)
