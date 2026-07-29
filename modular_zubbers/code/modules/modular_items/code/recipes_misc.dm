
/datum/crafting_recipe/makeshift/crowbar_alt
	name = "Makeshift Crowbar"
	result = /obj/item/crowbar/makeshift
	reqs = list(/obj/item/stack/sheet/iron = 4,
				/obj/item/stack/sheet/cloth = 1,
				/obj/item/weaponcrafting/silkstring = 1)
	time = 120
	category = CAT_MISC

/datum/crafting_recipe/makeshift/screwdriver_alt
	name = "Makeshift Screwdriver"
	tool_paths = list(/obj/item/crowbar/makeshift)
	result = /obj/item/screwdriver/makeshift
	reqs = list(/obj/item/weaponcrafting/silkstring = 1,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/rods = 2)
	time = 80
	category = CAT_MISC

/datum/crafting_recipe/makeshift/welder_alt
	name = "Makeshift Welder"
	tool_paths = list(/obj/item/crowbar/makeshift)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/weldingtool/makeshift
	reqs = list(/obj/item/tank/internals/emergency_oxygen = 1,
				/obj/item/stack/sheet/iron = 6,
				/obj/item/stack/sheet/glass = 2,
				/obj/item/weaponcrafting/silkstring = 2)
	time = 160
	category = CAT_MISC

/datum/crafting_recipe/makeshift/wirecutters_alt
	name = "Makeshift Wirecutters"
	tool_paths = list(/obj/item/crowbar/makeshift)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	result = /obj/item/wirecutters/makeshift
	reqs = list(/obj/item/weaponcrafting/silkstring = 2,
				/obj/item/stack/rods = 4)
	time = 80
	category = CAT_MISC

/datum/crafting_recipe/makeshift/wrench_alt
	name = "Makeshift Wrench"
	tool_paths = list(/obj/item/crowbar/makeshift)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	result = /obj/item/wrench/makeshift
	reqs = list(/obj/item/weaponcrafting/silkstring = 1,
				/obj/item/stack/sheet/iron = 3,
				/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/cloth = 2)
	time = 80
	category = CAT_MISC

/datum/crafting_recipe/stunsword
	blacklist = list(
		/obj/item/claymore/cutlass,
		/obj/item/claymore/cutlass/old,
		/obj/item/claymore/carrot,
		/obj/item/claymore/shortsword,
		/obj/item/claymore/highlander,
		/obj/item/claymore/weak,
		/obj/item/claymore/weak/weaker,
		/obj/item/claymore/weak/ceremonial,
		/obj/item/claymore/highlander/robot,
		/obj/item/claymore/bone
	)

/datum/crafting_recipe/stunswordalt2
	blacklist = list(
		/obj/item/melee/sabre/cargo
	)
