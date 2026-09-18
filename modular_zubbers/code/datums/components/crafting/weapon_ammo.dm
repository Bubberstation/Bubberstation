/datum/crafting_recipe/stingballcan
	name = "Stingball Canister"
	result = /obj/item/ammo_box/stingball
	reqs = list(
		/obj/item/grenade/stingbang = 1,
	)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 1.0 SECONDS
	category = CAT_WEAPON_AMMO
