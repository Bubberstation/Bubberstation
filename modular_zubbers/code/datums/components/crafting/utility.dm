/datum/crafting_recipe/paperbin
	name = "Paper bin"
	result = /obj/item/paper_bin
	time = 5 SECONDS
	reqs = list(
		/obj/item/stack/sheet/iron = 1,
		/obj/item/paper = 30
	)
	category = CAT_MISC

/datum/crafting_recipe/big_lead_acid
	name = "Lead-acid battery array"
	time = 10 SECONDS
	reqs = list(/datum/reagent/lead = 15, /obj/item/stack/cable_coil = 30, /obj/item/stack/rods = 8, /obj/item/stock_parts/power_store/cell/lead = 4)
	tool_paths = list(/obj/item/wirecutters, /obj/item/wrench, /obj/item/cautery)
	result = /obj/item/stock_parts/power_store/cell/lead
	category = CAT_MISC
