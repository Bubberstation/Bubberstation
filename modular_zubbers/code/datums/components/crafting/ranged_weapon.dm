//This is a crafting override for the regal condor.

/datum/crafting_recipe/deagle_prime
	reqs = list(
		/obj/item/gun/ballistic/automatic/pistol = 1, //marakov (7 TC)
		/obj/item/stack/sheet/mineral/gold = 25,
		/obj/item/stack/sheet/mineral/silver = 25,
		/obj/item/food/donkpocket = 1,
		/obj/item/weaponcrafting/gunkit/regal_condor = 1, //we replace the 4tc with an uplink item that costs 4tc and is restricted
		/obj/item/clothing/head/costume/crown/fancy = 1,
		/obj/item/storage/toolbox/syndicate = 1, //toolbox (1 TC)
		/obj/item/stack/sheet/iron = 10,
	)

/datum/crafting_recipe/deagle_prime_mag
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY | CRAFT_MUST_BE_LEARNED //for the unit test, this recipe is has custom materials like the original.
	reqs = list(
		/obj/item/stack/sheet/iron = 10,
		/obj/item/stack/sheet/mineral/gold = 10,
		/obj/item/stack/sheet/mineral/silver = 10,
		/obj/item/stack/sheet/mineral/plasma = 10,
		/obj/item/stack/telecrystal = 1, //induces a limit on how many magazines you can make
		/obj/item/food/donkpocket = 1,
	)

/datum/crafting_recipe/wt550_burst
	name = "WT-550-B Autoburstrifle"
	result = /obj/item/gun/ballistic/automatic/wt550/burst
	reqs = list(
		/obj/item/gun/ballistic/automatic/wt550 = 1,
		/obj/item/weaponcrafting/gunkit/wt550_burst = 1,
	)
	blacklist = list(
		/obj/item/gun/ballistic/automatic/wt550/burst,
		/obj/item/gun/ballistic/automatic/wt550/dmr,
	)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/wt550_long
	name = "WT-550-C Autorifle"
	result = /obj/item/gun/ballistic/automatic/wt550/dmr
	reqs = list(
		/obj/item/gun/ballistic/automatic/wt550 = 1,
		/obj/item/weaponcrafting/gunkit/wt550_long = 1,
	)
	blacklist = list(
		/obj/item/gun/ballistic/automatic/wt550/burst,
		/obj/item/gun/ballistic/automatic/wt550/dmr,
	)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/simple_battle_rifle
	name = "NT .38 Battle Rifle"
	result = /obj/item/gun/ballistic/automatic/battle_rifle_basic
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_MULTITOOL)
	reqs = list(
		/obj/item/gun/ballistic/automatic/battle_rifle = 1,
		/obj/item/weaponcrafting/gunkit/simple_battle_rifle = 1,
	)
	time = 20 SECONDS
	category = CAT_WEAPON_RANGED
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/nuclear_smg
	name = "Advanced Energy SMG"
	result = /obj/item/gun/energy/e_gun/nuclear_smg
	tool_behaviors = list(TOOL_WIRECUTTER, TOOL_MULTITOOL)
	reqs = list(
		/obj/item/gun/energy/e_gun/nuclear = 1,
		/obj/item/gun/energy/laser/carbine = 1,
		/obj/item/gun/energy/disabler/smg = 1,
	)
	time = 20 SECONDS
	category = CAT_WEAPON_RANGED
