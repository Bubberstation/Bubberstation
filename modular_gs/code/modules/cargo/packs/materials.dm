//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.

/datum/supply_pack/materials/basic_materials_crate
	crate_type = /obj/structure/closet/secure_closet/cargo
	name = "Kickstart Mineral Package"
	desc = "A mineral package that was scrapped from a bunch of obsolete machines by the cleaning crew - it will help your station get at least basic means of production available."
	cost = 8000
	contains = list(/obj/item/stack/sheet/mineral/plasma/five,
					/obj/item/stack/sheet/mineral/uranium/five,
					/obj/item/stack/sheet/mineral/gold,
					/obj/item/stack/sheet/mineral/gold,
					/obj/item/stack/sheet/mineral/gold,
					/obj/item/stack/sheet/mineral/gold,
					/obj/item/stack/sheet/mineral/gold,
					/obj/item/stack/sheet/mineral/silver,
					/obj/item/stack/sheet/mineral/silver,
					/obj/item/stack/sheet/mineral/silver,
					/obj/item/stack/sheet/mineral/silver,
					/obj/item/stack/sheet/mineral/silver,
					/obj/item/stack/sheet/mineral/titanium,
					/obj/item/stack/sheet/mineral/titanium,
					/obj/item/stack/sheet/mineral/titanium,
					/obj/item/stack/sheet/mineral/titanium,
					/obj/item/stack/sheet/mineral/titanium)

/datum/supply_pack/materials/gmushroom50 //buyable special wood planks
	name = "50 Mushroom Planks"
	desc = "Looks like wood AND is fire proof? Of course you need fifty mushroom planks!"
	cost = 1700
	crate_type = /obj/structure/closet/secure_closet/cargo
	contains = list(/obj/item/stack/sheet/mineral/gmushroom/fifty)

/datum/supply_pack/materials/plaswood50
	name = "50 Plaswood Planks"
	desc = "Who need metal when you can have fifty plaswood planks?"
	cost = 6000
	crate_type = /obj/structure/closet/secure_closet/cargo
	contains = list(/obj/item/stack/sheet/mineral/plaswood/fifty)

/datum/supply_pack/materials/shadoww50
	name = "50 Shadow Wood Planks"
	desc = "Time to bring the dark side with fifty shadow wooden planks!"
	cost = 1450
	crate_type = /obj/structure/closet/secure_closet/cargo
	contains = list(/obj/item/stack/sheet/mineral/shadoww/fifty)
