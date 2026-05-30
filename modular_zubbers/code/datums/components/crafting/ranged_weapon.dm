/datum/crafting_recipe/deagle_prime
	reqs = list(
		/obj/item/gun/ballistic/automatic/pistol = 1,
		/obj/item/stack/sheet/mineral/gold = 25,
		/obj/item/stack/sheet/mineral/silver = 25,
		/obj/item/food/donkpocket = 1,
		/obj/item/weaponcrafting/gunkit/regal_condor, //we replace the 4tc with an uplink item that costs 4tc and is restricted
		/obj/item/clothing/head/costume/crown/fancy = 1,
		/obj/item/storage/toolbox/syndicate = 1,
		/obj/item/stack/sheet/iron = 10,
	)

/datum/crafting_recipe/deagle_prime_mag
	reqs = list(
		/obj/item/stack/sheet/iron = 10,
		/obj/item/stack/sheet/mineral/gold = 10,
		/obj/item/stack/sheet/mineral/silver = 10,
		/obj/item/stack/sheet/mineral/plasma = 10,
		/obj/item/stack/telecrystal = 1, //induces a limit on how many magazines you can make
		/obj/item/food/donkpocket = 1,
	)
