/datum/supply_pack/security/armory/wt551
	name = "WT-551 Autorifle Crate"
	desc = "Contains a pair of WT-551 Autorifles pre-loaded with less-than-lethal rubber-tipped rounds. Additional ammo sold seperately. Backwards-compatible with WT-550 magazines. NanoTrasen reminds you that the other weapon is for a friend, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/gun/ballistic/automatic/wt550/security/rubber = 2)
	crate_name = "wt-550 autorifle crate"

/datum/supply_pack/security/armory/wt550_ammo_rubber
	name = "WT-550/WT-551 Autorifle Ammo Crate (Rubber-Tipped)"
	desc = "Contains 3 magazines with less than lethal rubber-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/ammo_box/magazine/wt550m9/rubber = 3)
	crate_name = "wt-550 magazine crate (rubber-tipped)"

/datum/supply_pack/security/armory/wt550_ammo_flat
	name = "WT-550/WT-551 Autorifle Ammo Crate (Flat-Tipped)"
	desc = "Contains 3 magazines with lethal flat-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/ammo_box/magazine/wt550m9/flathead = 3)
	crate_name = "wt-550 magazine crate (flat-tipped)"

/datum/supply_pack/security/armory/wt550_ammo_regular
	name = "WT-550/WT-551 Autorifle Ammo Crate (Regular)"
	desc = "Contains 3 magazines with lethal regular rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 3)
	crate_name = "wt-550 magazine crate (regular)"

/datum/supply_pack/security/armory/renoster
	name = "Carwo 'Renoster' Shotgun Crate"
	desc = "Contains two Carwo 'Renoster' shotguns. Additional ammmo sold separately."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol = 2,
	/obj/item/ammo_box/advanced/s12gauge/buckshot = 2,
	)
	crate_name = "Carwo 'Renoster' Shotgun Crate"

/datum/supply_pack/security/armory/sindano
	name = "Carwo 'Sindano' Submachinegun Crate"
	cost = CARGO_CRATE_VALUE * 20
	desc = "Contains two Carwo 'Sindano' Submachineguns, and two spare magazines for them."
	contains = list(/obj/item/gun/ballistic/automatic/sol_smg = 2,
	/obj/item/ammo_box/magazine/c35sol_pistol = 2,
	)

	crate_name = "Carwo 'Sindano' Submachinegun Crate"

/datum/supply_pack/security/armory/infanterie
	name = "Carwo 'd'Infanteria' Rifle Crate"
	desc = "Contains two Carwo 'd'Infanteria' Rifles, and two spare magazines for them."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle = 2,
	/obj/item/ammo_box/magazine/c40sol_rifle = 2,
	)
	crate_name = "Carwo 'd'Infanteria' Rifle Crate"

/datum/supply_pack/security/armory/elite
	name = "Carwo 'd'Elite' Sniper Rifle Crate"
	desc = "Contains one Carwo 'd'Elite' Sniper Rifle, as well as a spare magazine for it."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 1,
	/obj/item/ammo_box/magazine/c40sol_rifle = 1,
	)
	crate_name = "Carwo 'd'Infanteria' Sniper Rifle Crate"

/datum/supply_pack/security/ammo
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 3,
					/obj/item/ammo_box/advanced/s12gauge/rubber = 3,
					/obj/item/ammo_box/c38/trac,
					/obj/item/ammo_box/c38/hotshot,
					/obj/item/ammo_box/c38/iceblox,
				)
	special = FALSE
//This makes the Security ammo crate use the cool advanced ammo boxes instead of the old ones

/datum/supply_pack/security/disabler
	cost = CARGO_CRATE_VALUE * 3
//Why were these made more expensive?

/datum/supply_pack/security/armory/ionrifle
	name = "Ion Carbine Crate"
	cost = CARGO_CRATE_VALUE * 18 //Same as the energy gun crate
	desc = "Contains two Ion Carbines, for when you need to deal with speedy space tiders, mechs, or upstart silicons."
	contains = list(/obj/item/gun/energy/ionrifle/carbine = 2)
	crate_name = "Ion Carbine Crate"

/datum/supply_pack/security/miniegun
	name = "Mini E-Gun Bulk Crate"
	cost = CARGO_CRATE_VALUE * 4
	desc = "Contains three mini e-guns, cheap and semi-effective, for when you need to arm up on a budget."
	contains = list(/obj/item/gun/energy/e_gun/mini = 3)
	crate_name = "Mini E-Gun Bulk Crate"

/datum/supply_pack/security/armory/kiboko
	name = "Kiboko Grenade Launcher Crate"
	cost = CARGO_CRATE_VALUE * 20
	desc = "Contains two Kiboko 25mm grenade launchers. A small dial on the sight allows you to set the length of the grenade fuse."
	contains = list(
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag = 2,
		/obj/item/ammo_box/magazine/c980_grenade/starts_empty = 2
	)
	crate_name = "Kiboko Grenade Launcher Crate"

/datum/supply_pack/security/armory/kiboko_variety
	name = "Kiboko 25mm Variety Pack"
	cost = CARGO_CRATE_VALUE * 8
	desc = "Contains a variety of ammo types for the Kiboko 25mm Grenade Launcher. One practice box, one smoke box, and one riot box."
	contains = list(
		/obj/item/ammo_box/c980grenade = 1,
		/obj/item/ammo_box/c980grenade/smoke = 1,
		/obj/item/ammo_box/c980grenade/riot = 1,
	)
