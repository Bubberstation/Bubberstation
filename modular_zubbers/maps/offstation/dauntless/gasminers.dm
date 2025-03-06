/obj/item/storage/box/gas_miner_beacons/syndicate
	name = "box of syndicate gas miner delivery beacons"
	desc = "Contains two beacons for delivery of atmospheric gas miners."

/obj/item/storage/box/gas_miner_beacons/syndicate/PopulateContents()
	new /obj/item/summon_beacon/gas_miner/syndicate(src)
	new /obj/item/summon_beacon/gas_miner/syndicate(src)

/obj/item/summon_beacon/gas_miner/syndicate
	name = "syndicate gas miner beacon"

	allowed_areas = list(/area/ruin/space/has_grav/bubbers/dauntless/cargo,
						 /area/ruin/space/has_grav/bubbers/dauntless/engineering,
						 /area/ruin/space/has_grav/bubbers/dauntless/engineering/turbine,
						 /area/ruin/space/has_grav/bubbers/persistance/engineering,
						 /area/ruin/space/has_grav/bubbers/persistance/engineering/atmospherics,
						 /area/ruin/space/has_grav/bubbers/persistance/engineering/mining,
						 /area/ruin/space/has_grav/bubbers/persistance/engineering/gas,
						 /area/ruin/space/has_grav/bubbers/persistance/engineering/utilities
						 )
	area_string = "dauntless"
