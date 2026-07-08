
/datum/crafting_recipe/stake
	name = "Stake"
	result = /obj/item/stake
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3)
	time = 8 SECONDS
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/hardened_stake
	name = "Hardened Stake"
	result = /obj/item/stake/hardened
	tool_behaviors = list(TOOL_WELDER)
	reqs = list(/obj/item/stack/rods = 1)
	time = 6 SECONDS
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/silver_stake
	name = "Silver Stake"
	result = /obj/item/stake/hardened/silver
	tool_behaviors = list(TOOL_WELDER)
	reqs = list(
		/obj/item/stack/sheet/mineral/silver = 1,
		/obj/item/stake/hardened = 1,
		// It's slathered in garlic, smelly.
		/obj/item/food/grown/garlic = 2,
	)
	time = 8 SECONDS
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/stunstaff
	name = "Stun Staff"
	result = /obj/item/melee/baton/security/staff
	reqs = list(
		/obj/item/melee/baton/security = 2,
		/obj/item/stack/sheet/plasteel = 3,
		/obj/item/stack/cable_coil = 5
	)
	blacklist = list(
		/obj/item/melee/baton/security/cattleprod,
		/obj/item/melee/baton/security/cattleprod/telecrystalprod,
		/obj/item/melee/baton/security/cattleprod/teleprod,
		/obj/item/melee/baton/security/boomerang,
		/obj/item/melee/baton/security/stunsword
	)
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	time = 15 SECONDS
	category = CAT_WEAPON_MELEE
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/stunstaff_prime
	name = "Magna-staff"
	result = /obj/item/melee/baton/security/staff/prime
	reqs = list(
		/obj/item/melee/baton/security/staff = 1,
		/obj/item/stack/sheet/mineral/titanium = 10,
		/obj/item/stack/sheet/mineral/plasma = 10,
		/obj/item/stock_parts/capacitor/quadratic = 5,
		/datum/reagent/consumable/ethanol/quintuple_sec = 30,
	)
	blacklist = list(
		/obj/item/melee/baton/security/staff/prime
	)
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	tool_paths = list(
		/obj/item/clothing/accessory/medal/silver/security,
	)
	machinery = list(
		/obj/machinery/power/apc,
	)
	time = 15 SECONDS
	category = CAT_WEAPON_MELEE
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY | CRAFT_MUST_BE_LEARNED
