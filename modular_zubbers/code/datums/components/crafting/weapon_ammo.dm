/datum/crafting_recipe/ripslug
	name = "Ripslug Shell"
	result = /obj/item/ammo_casing/shotgun/rip
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stack/sheet/mineral/plastitanium = 5,
				/obj/item/stock_parts/micro_laser/quadultra = 1) // to split the slug duh
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 0.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/anarchy
	name = "Anarchy Shell"
	result = /obj/item/ammo_casing/shotgun/anarchy
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stack/sheet/plastic = 5, // uhh because we dont have rubber and this is as close as i can get?
				/obj/item/stack/sheet/mineral/silver = 5) // mirrors are inlaid with silver so light reflects, so clearly it helps them reflect too, right?
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 0.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/depleteduraniumslug
	name = "Depleted Uranium Slug Shell"
	result = /obj/item/ammo_casing/shotgun/uraniumpenetrator
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stack/sheet/mineral/uranium = 3,
				/obj/item/stack/rods = 2,
				/datum/reagent/thermite = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 0.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/cryoshot
	name = "Cryoshot Shell"
	result = /obj/item/ammo_casing/shotgun/cryoshot
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/datum/reagent/medicine/c2/hercuri = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 0.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/thundershot
	name = "Thundershot Shell"
	result = /obj/item/ammo_casing/shotgun/thundershot
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/capacitor/super = 1,
				/datum/reagent/teslium = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 0.5 SECONDS
	category = CAT_WEAPON_AMMO
