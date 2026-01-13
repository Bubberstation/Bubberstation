/*
/datum/supply_pack/imports/lmg
	name = "Smuggled Sol Light Machinegun Crate"
	desc = "(*!&@#GOOD NEWS, OPERATIVE! WE GOT YOU THE BIG LEAGUE AUTOMATIC WEAPONS. BY \
		SMUGGLING THIS CRATE THROUGH A FEW OUTDATED CUSTOMS CHECKPOINTS, WE'VE THE NEXT BEST THING! \
		A FUCKING LIGHT MACHINE GUN. DON'T WORRY, THE RUMORS ABOUT THE GUN MELTING YOU ARE JUST THAT! RUMORS! \
		THESE THINGS WORK FINE! MIGHT BE SLIGHTLY DIRTY.!#@*$"
	hidden = TRUE
	cost = CARGO_CRATE_VALUE * 52
	contains = list(
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle/drum = 2,
	)
*/ //BUBBER EDIT: IT'S AS BAD AS YOU THOUGHT

//Goodies

//Override
/datum/supply_pack/security/ammo
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 3,
					/obj/item/ammo_box/advanced/s12gauge/rubber = 3,
					/obj/item/ammo_box/speedloader/c38/trac,
					/obj/item/ammo_box/speedloader/c38/hotshot,
					/obj/item/ammo_box/speedloader/c38/iceblox,
				)

//This makes the Security ammo crate use the cool advanced ammo boxes instead of the old ones
