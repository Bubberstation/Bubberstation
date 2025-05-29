//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.

/datum/supply_pack/engineering/advanced_atmos_tools
	name = "Advanced Atmospherics Tools"
	access = ACCESS_ATMOSPHERICS
	crate_type = /obj/structure/closet/crate/secure/engineering
	desc = "A set of tools to tackle any atmospherics challenges one may face! Contains the Long Range Analyzer, Holocombifan, atmos and firelock projector, pocket fire extinguisher and an RPD. Requires atmospherics access to open"
	cost = 8500
	contains = list(/obj/item/analyzer/ranged,
					/obj/item/holosign_creator/atmos,
					/obj/item/holosign_creator/firelock,
					/obj/item/holosign_creator/combifan,
					/obj/item/extinguisher/mini,
					/obj/item/pipe_dispenser)

/datum/supply_pack/engineering/advanced_engi_tools
	name = "Advanced Engineering Tools"
	access = ACCESS_ENGINE_EQUIP
	crate_type = /obj/structure/closet/crate/secure/engineering
	desc = "A set of power tools that even the CE wouldn't be ashamed of! Contains the Hand Drill, Jaws of Life, Engineering Holobarrier Projector and an Experimental Welding Tool. Requires engineering machinery access to open"
	cost = 10000
	contains = list(/obj/item/screwdriver/power,
					/obj/item/crowbar/power,
					/obj/item/weldingtool/experimental,
					/obj/item/holosign_creator/engineering)

/datum/supply_pack/engineering/energy_harvester_board
	name = "Energy Harvester Board"
	desc = "Engineering made some crazy power device that seems to be creating massive amounts of energy out of thin air? With the parts found in this crate, you'll be able to make some sweet cash out of the engineers hard labor. Half of the credits made by this machine go to the engineering budget."
	cost = 5000
	contains = list(/obj/item/circuitboard/machine/energy_harvester)
	crate_name = "Energy Harvester Board supply crate"