/datum/crafting_recipe/pn_jaws
	name = "Proto Nitrate Jaws of Life"
	result = /obj/item/crowbar/power/protonitrate
	time = 3 SECONDS
	reqs = list(/obj/item/crowbar/power = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_jaws/science
	name = "Proto Nitrate Hybrid Cutters"
	result = /obj/item/crowbar/power/protonitrate/science
	time = 3 SECONDS
	reqs = list(/obj/item/crowbar/power/science = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_drill
	name = "Proto Nitrate Hand Drill"
	result = /obj/item/screwdriver/power/protonitrate
	time = 3 SECONDS
	reqs = list(/obj/item/screwdriver/power = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_drill/science
	name = "Proto Nitrate Hand Drill"
	result = /obj/item/screwdriver/power/protonitrate/science
	time = 3 SECONDS
	reqs = list(/obj/item/screwdriver/power/science = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_welder
	name = "Proto Nitrate Welding Tool"
	result = /obj/item/weldingtool/experimental/protonitrate
	time = 3 SECONDS
	reqs = list(/obj/item/weldingtool/experimental = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/jaws_of_recovery
	category = null
	crafting_flags = CRAFT_MUST_BE_LEARNED
