/datum/supply_pack/goody/sol_pistol_single
	name = "Sol 'Wespe' Pistol Single Pack"
	desc = "The standard issue service pistol of the Solar Federation's various military branches. Comes with an attached light and a spare magazine."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sol = 1,
	/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 1,
	)
	cost = PAYCHECK_COMMAND * 20
	access_view = ACCESS_WEAPONS //The cost of a Detective Revolver

/datum/supply_pack/goody/sol_revolver_single
	name = "Sol 'Eland' Revolver Single Pack"
	desc = "A stubby revolver chiefly found in the hands of Private Security forces due to its cheap price and decent stopping power. Comes with an ammo box."
	contains = list(/obj/item/gun/ballistic/revolver/sol = 1,
	/obj/item/ammo_box/c35sol = 1,
	)
	cost = PAYCHECK_COMMAND * 20 //The cost of a Detective Revolver
	access_view = ACCESS_WEAPONS
//Cargo techs when no permit

/datum/supply_pack/goody/mars_single
	special = FALSE

/datum/supply_pack/goody/dumdum38
	special = FALSE

/datum/supply_pack/goody/match38
	special = FALSE

/datum/supply_pack/goody/rubber
	special = FALSE

/datum/supply_pack/goody/ballistic_single
	special = FALSE

/datum/supply_pack/goody/disabler_single
	special = FALSE

/datum/supply_pack/goody/energy_single
	special = FALSE

/datum/supply_pack/goody/laser_single
	special = FALSE

/datum/supply_pack/goody/hell_single
	special = FALSE

/datum/supply_pack/goody/thermal_single
	special = FALSE
