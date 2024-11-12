/datum/map_template/ruin/space/bubberstation/independent_miner_asteroid
	id = "indminer_asteroid"
	suffix = "indminer_asteroid.dmm"
	name = "Independent Miner Asteroid"
	description = "Some space miners still cling to the old way of getting that \
		sweet, sweet plasma - painstakingly digging it out of free-floating asteroids\
		instead of flying down to the hellscape of lavaland."
	allow_duplicates = FALSE
	always_spawn_with = list(/datum/map_template/ruin/space/bubberstation/whiteship_miner_ship = PLACE_SPACE_RUIN)

	placement_weight = 3
	always_place = TRUE

/datum/map_template/ruin/space/bubberstation/whiteship_miner_ship
	id = "whiteshipdock_m"
	suffix = "whiteshipdock_m.dmm"
	name = "Independent Miner Ship"
	description = "An independent crewed mining vessel parked in nearby space"

/obj/docking_port/stationary/picked/whiteship_miner
	name = "Deep Space"
	shuttle_id = "whiteship_miner"
	dir = 2
	shuttlekeys = list(
		"miner_indminer_ship"
	)

/datum/map_template/shuttle/ruin/independent_miner
	port_id = "miner"
	prefix = "_maps/shuttles/zubbers/"
	suffix = "indminer_ship"

	name = "Independent mining ship"
	description = "Deep space mining operations vessel, \
	still used in spite of being not as prospective as planet mining"

/obj/item/circuitboard/computer/white_ship/miner

/obj/machinery/computer/shuttle/white_ship/miner
	name = "Independent Miner Ship Console"
	desc = "Used to control the Independent Miner Ship."
	circuit = /obj/item/circuitboard/computer/white_ship/miner
	possible_destinations = "whiteship_miner;whiteship_away;whiteship_home;whiteship_z4;whiteship_mining0;whiteship_mining1;whiteship_mining2;whiteship_custom"
	req_access = list(ACCESS_INDMINER_CAPTAIN)

/obj/machinery/computer/camera_advanced/shuttle_docker/whiteship/miner
	name = "Free Miner Navigation Computer"
	desc = "Used to designate a precise transit location for the Free Miner Ship."
	jump_to_ports = list("whiteship_miner" = 1, "whiteship_away_miner" = 1, "whiteship_home" = 1, "whiteship_mining0" = 1, "whiteship_mining1" = 1, "whiteship_mining2" = 1)

/obj/machinery/computer/camera_advanced/shuttle_docker/whiteship/miner/Initialize(mapload)
	. = ..()
	for(var/obj/docking_port/stationary/dock in SSshuttle.stationary_docking_ports)
		if(jump_to_ports[dock.shuttle_id])
			z_lock |= dock.z

/obj/effect/mob_spawn/ghost_role/human/independent_miner
	name = "Independent Miner"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	flavour_text = "You are an independent miner, making a living mining the asteroids that were left behind when Nanotrasen moved from asteroid mining to lavaland. Try to make a profit and show those corporates who the real miners are!"
	outfit = /datum/outfit/independent_miner
	prompt_name = "an independent miner"

/datum/outfit/independent_miner
	name = "Independent Miner"
	uniform = /obj/item/clothing/under/rank/cargo/miner
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/industrial
	l_pocket = /obj/item/mining_voucher
	r_pocket = /obj/item/storage/bag/ore
	belt = /obj/item/pickaxe
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/independent_miner

	backpack_contents = list(/obj/item/radio)

/obj/effect/mob_spawn/ghost_role/human/independent_miner/captain
	name = "Independent Miner Captain"
	outfit = /datum/outfit/independent_miner/captain
	prompt_name = "the independent miner captain"

/datum/outfit/independent_miner/captain
	name = "Independent Miner"
	uniform = /obj/item/clothing/under/suit/navy
	back = /obj/item/storage/backpack
	l_pocket = /obj/item/melee/baton/telescopic
	r_pocket = null
	belt = null
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/independent_miner/captain
	backpack_contents = list(/obj/item/radio)

/datum/id_trim/independent_miner
	assignment = "Independent Miner"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	access = list(ACCESS_INDMINER)

/datum/id_trim/independent_miner/captain
	assignment = "Independent Miner captain"
	access = list(ACCESS_INDMINER, ACCESS_INDMINER_CAPTAIN)
