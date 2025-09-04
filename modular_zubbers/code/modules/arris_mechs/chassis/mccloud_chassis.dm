/obj/vehicle/sealed/mecha/mccloud
	desc = "An ultralight mech capable of spaceflight. Most popular with mercenaries, wanderers, and pirates; Nanotrasen has their own variation. A manufacturing defect has a particular interaction with disabler beams..."
	name = "\improper McCloud"
	icon = 'modular_zubbers/code/modules/arris_mechs/icons/mecha_64x32.dmi'
	icon_state = "mccloud"
	silicon_icon_state =  "mccloud-empty"
	base_icon_state = "mccloud"
	stepsound = 'sound/vehicles/mecha/powerloader_step.ogg'
	turnsound = 'sound/vehicles/mecha/powerloader_turn2.ogg'

	var/jet_move_delay = 0.7
	var/biped_move_delay = 1.0
	var/biped_move_delay_disabler = 1.7
	movedelay = 1.0

	overclock_coeff = 1.1
	overclock_temp_danger = 3 //overclock ability makes this go crazy fast so it has to be significantly limited
	max_integrity = 150
	accesses = list(ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY)
	armor_type = /datum/armor/mecha_mccloud
	max_temperature = 25000
	force = 25
	destruction_sleep_duration = 8 SECONDS
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/mccloud
	mech_type = EXOSUIT_MODULE_GYGAX
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 0,
	)
	equip_by_category = list(
		MECHA_L_ARM = null,
		MECHA_R_ARM = null,
		MECHA_UTILITY = null,
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)
	step_energy_drain = 50 //extremely high energy drain forces user to return to recharge points often

	var/jet_mode = FALSE
	var/switching_modes = FALSE
	//thrusters to use when not in jet mode
	var/obj/item/mecha_parts/mecha_equipment/thrusters/backup_thrusters = null
	//thrusters to use when in jet mode
	var/obj/item/mecha_parts/mecha_equipment/thrusters/ion/mccloud/jet_mode_thrusters = null
	COOLDOWN_DECLARE(cooldown_mech_mccloud_landing_skid)
	COOLDOWN_DECLARE(cooldown_mech_mccloud_stamina_slow)
	SET_BASE_PIXEL(-16, 0)
	//explosion variables
	var/ex_dev = 0
	var/ex_heavy = 0
	var/ex_light = 5
	var/ex_flame = 1

	var/newtonian_acceleration = 6 NEWTONS
	var/newtonian_accel_cap = 18 NEWTONS

	var/disabler_vulnerable = TRUE

/obj/vehicle/sealed/mecha/mccloud/Initialize(mapload, built_manually)
	..()
	movedelay = biped_move_delay

/datum/armor/mecha_mccloud
	melee = 10
	bullet = 15
	energy = 10
	fire = 40
	acid = 100

/obj/structure/mecha_wreckage/mccloud
	icon = 'modular_zubbers/code/modules/arris_mechs/icons/mecha_64x32.dmi'
	icon_state = "mccloud-broken"
	SET_BASE_PIXEL(-16, 0)

/obj/vehicle/sealed/mecha/mccloud/nineball
	desc = "An ultralight mech capable of spaceflight. The Syndicate fields only their most elite mech pilots for this advanced, shapeshifting mech type."
	name = "\improper Nine-Ball"
	icon_state = "mccloud-syndie"
	silicon_icon_state =  "mccloud-syndie-empty"
	base_icon_state = "mccloud-syndie"
	max_integrity = 225
	accesses = list(ACCESS_SYNDICATE)
	wreckage = /obj/structure/mecha_wreckage/mccloud/nineball
	ui_theme = "syndicate"
	disabler_vulnerable = FALSE
	step_energy_drain = 30
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot,
		MECHA_R_ARM = null,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine),
	)

/obj/structure/mecha_wreckage/mccloud/nineball
	icon_state = "mccloud-syndie-broken"

/obj/vehicle/sealed/mecha/mccloud/lancer
	desc = "An ultralight mech capable of spaceflight. It is commonly seen deployed for Nanotrasen's own space force units as a vanguard to larger units, or solo to handle smaller conflicts."
	name = "\improper Lancer"
	icon_state = "mccloud-centcom"
	silicon_icon_state =  "mccloud-centcom-empty"
	base_icon_state = "mccloud-centcom"
	max_integrity = 240
	accesses = list(ACCESS_CENT_SPECOPS)
	wreckage = /obj/structure/mecha_wreckage/mccloud/lancer
	disabler_vulnerable = FALSE
	step_energy_drain = 25
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/pulse,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine),
	)

/obj/structure/mecha_wreckage/mccloud/lancer
	icon_state = "mccloud-centcom-broken"

/obj/vehicle/sealed/mecha/mccloud/harpoon
	desc = "An ultralight mech capable of spaceflight. The pirate-originating design bypasses many safety features to maximize its aggressive potential."
	name = "\improper Harpoon"
	icon_state = "mccloud-pirate"
	silicon_icon_state =  "mccloud-pirate-empty"
	base_icon_state = "mccloud-pirate"
	max_integrity = 200
	accesses = null
	wreckage = /obj/structure/mecha_wreckage/mccloud/harpoon
	disabler_vulnerable = TRUE
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/tesla,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/breaching,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)
	step_energy_drain = 30
	newtonian_acceleration = 7 NEWTONS
	newtonian_accel_cap = 21 NEWTONS
	ex_heavy = 1
	ex_light = 9
	ex_flame = 5

/obj/structure/mecha_wreckage/mccloud/harpoon
	icon_state = "mccloud-pirate-broken"
