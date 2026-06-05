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
		/obj/item/gun/ballistic/automatic/wt550/sawnoff,
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
		/obj/item/gun/ballistic/automatic/wt550/sawnoff,
	)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/wt550_sawd
	name = "Sawn-off WT-550"
	result = /obj/item/gun/ballistic/automatic/wt550/sawnoff
	reqs = list(
		/obj/item/gun/ballistic/automatic/wt550 = 1,
		/obj/item/weaponcrafting/gunkit/wt550_sawd = 1,
	)
	blacklist = list(
		/obj/item/gun/ballistic/automatic/wt550/burst,
		/obj/item/gun/ballistic/automatic/wt550/dmr,
		/obj/item/gun/ballistic/automatic/wt550/sawnoff,
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
