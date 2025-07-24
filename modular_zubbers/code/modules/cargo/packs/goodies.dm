/datum/supply_pack/goody/sol_pistol_single
	name = "Sol 'Wespe' Pistol Single Pack"
	desc = "The standard issue service pistol of the Terran Government's various military branches. Comes with an attached light and a spare magazine."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sol = 1,
	/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 1,
	)
	cost = PAYCHECK_COMMAND * 10 //Half the cost of a Detective Revolver
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/sol_revolver_single
	name = "Sol 'Eland' Revolver Single Pack"
	desc = "A stubby revolver chiefly found in the hands of Private Security forces due to its cheap price and decent stopping power. Comes with an ammo box."
	contains = list(/obj/item/gun/ballistic/revolver/sol = 1,
	/obj/item/ammo_box/c35sol = 1,
	)
	cost = PAYCHECK_COMMAND * 10 //Half the cost of a Detective Revolver
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/disablersmg_single
	name = "Disabler SMG Single-Pack"
	desc = "Contains one disabler SMG, an automatic variant of the original workhorse."
	cost = PAYCHECK_COMMAND * 3
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/disabler/smg)

/datum/supply_pack/goody/lasercarbine_single
	name = "Laser Carbine Single-Pack"
	desc = "Contains one laser carbine, an automatic variant of the laser gun. For when you need a fast-firing lethal-only solution."
	cost = PAYCHECK_COMMAND * 12
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/carbine)

/datum/supply_pack/goody/miniegun_single
	name = "Mini E-Gun Single-Pack"
	desc = "Contains one mini e-gun, for when your Bridge Officer loses theirs to the clown."
	cost = PAYCHECK_COMMAND * 5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun/mini)

/datum/supply_pack/goody/shotgun_revolver
	name = "Bóbr 12 GA Revolver Single-Pack"
	desc = "Contains 1 civilian-modified Bóbr revolver, chambered in 12 gauge. For when you really want the power of a shotgun in the palm of your hand. Comes with a box of beanbag shells."
	contains = list(/obj/item/gun/ballistic/revolver/shotgun_revolver/civvie = 1,
	/obj/item/ammo_box/advanced/s12gauge/bean = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 20

/datum/supply_pack/goody/plasma_projector
	name = "Słońce Plasma Projector Single-Pack"
	desc = "Contains one Słońce Plasma Projector. Spews an inaccurate stream of searing plasma out the magnetic barrel so long as it has power."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_thrower = 1,
	/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/goody/sakhno_derringer_single
	name = "Sakhno 'Yinbi' Derringer Single Pack"
	desc = "A compact self-defense pistol, chambered in .310 strilka. Comes with a box of modern reproduction cartridges."
	contains = list(/obj/item/gun/ballistic/derringer = 1,
	/obj/item/ammo_box/c310_cargo_box = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 4.5 //It's a close-range cannon, very poor ranged performance. Slightly pricer than imported Sol pistols

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

/datum/supply_pack/goody/medkit_surgery
	name = "High Capacity Surgical Medkit"
	desc = "A high capacity aid kit, full of medical supplies and basic surgical equipment."
	cost = PAYCHECK_CREW * 15
	contains = list(/obj/item/storage/medkit/surgery)

//For @unionheart
/datum/supply_pack/goody/security_maid
	name = "CnC Maid Operator Kit"
	desc = "Contains a set of armoured janitorial kit for combat scenario."
	cost = PAYCHECK_COMMAND * 4
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/clothing/under/rank/security/maid, /obj/item/clothing/suit/armor/vest/maid, /obj/item/clothing/head/security_maid, /obj/item/pushbroom)

/datum/supply_pack/goody/prescription_lenses
	name = "Spare Prescription Lenses"
	desc = "A small toolbox with one spare set of prescripted lenses. Warning: fragile."
	cost = PAYCHECK_COMMAND * 2 // glasses are expensive! woah-wee momma!
	contains = list(/obj/item/prescription_lenses)

/datum/supply_pack/goody/space_pet_snack
	name = "Spaceproof Pet Snack"
	desc = "Contains a treat for your loving companion that'll make them spaceworthy."
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/pet_food/pet_space_treat)

/datum/supply_pack/goody/rope_implant
	name = "Climbing Hook Implant"
	desc = "A specialized climbing hook implant for the vertically challenged."
	cost = PAYCHECK_CREW * 12
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/rope)

/datum/supply_pack/imports/donk
	access = NONE
	cost = PAYCHECK_CREW
	group = "Goodies" //figure this out later
	goody = TRUE
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/donk/food/ready/standard
	name = "Ready Donk"
	contains = list(/obj/item/food/ready_donk)

/datum/supply_pack/imports/donk/food/ready/donkhiladas
	name = "Ready Donkhiladas"
	contains = list(/obj/item/food/ready_donk/donkhiladas)

/datum/supply_pack/imports/donk/food/ready/mac_n_cheese
	name = "Mac & Cheese Ready Donk"
	contains = list(/obj/item/food/ready_donk/mac_n_cheese)

/datum/supply_pack/imports/donk/food/pockets/standard
	name = "Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets)

/datum/supply_pack/imports/donk/food/pockets/berry
	name = "Berry Honk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketberry)

/datum/supply_pack/imports/donk/food/pockets/banana
	name = "Honk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpockethonk)

/datum/supply_pack/imports/donk/food/pockets/pizza
	name = "Pizza Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketpizza)

/datum/supply_pack/imports/donk/food/pockets/spicy
	name = "Spicy Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketspicy)

/datum/supply_pack/imports/donk/food/pockets/teriyaki
	name = "Teriyaki Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketteriyaki)

/datum/supply_pack/imports/donk/merch/donk_carpet
	name = "Donk Pocket Carpet"
	contains = list(/obj/item/stack/tile/carpet/donk/thirty)

/datum/supply_pack/imports/donk/merch/tacticool_turtleneck
	name = "Tacticool Turtleneck"
	contains = list(/obj/item/clothing/under/syndicate/tacticool)

/datum/supply_pack/imports/donk/merch/tacticool_turtleneck_skirt
	name = "Tacticool Turtleneck Skirt"
	contains = list(/obj/item/clothing/under/syndicate/tacticool/skirt)

/datum/supply_pack/imports/donk/merch/fake_centcom_turtleneck
	name = "Replica CentCom Turtleneck"
	contains = list(/obj/item/clothing/under/rank/centcom/officer/replica)

/datum/supply_pack/imports/donk/merch/fake_centcom_turtleneck_skirt
	name = "Replica CentCom Turtleneck Skirt"
	contains = list(/obj/item/clothing/under/rank/centcom/officer_skirt/replica)

/datum/supply_pack/imports/donk/merch/snack_rig
	name = "Donk Co. Tactical Snack Belt"
	contains = list(/obj/item/storage/belt/military/snack)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/donk/merch/fake_syndie_suit
	name = "Replica Syndicate Suit"
	contains = list(/obj/item/storage/box/fakesyndiesuit)

/datum/supply_pack/imports/donk/merch/syndicate_balloon
	name = "Syndicate Balloon"
	contains = list(/obj/item/toy/balloon/arrest)

/datum/supply_pack/imports/donk/foamforce
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/donk/foamforce/pistol
	name = "Foam Dart Pistol"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)

/datum/supply_pack/imports/donk/foamforce/shotgun
	name = "Foam Dart Shotgun"
	contains = list(/obj/item/gun/ballistic/shotgun/toy/riot)

/datum/supply_pack/imports/donk/foamforce/smg
	name = "Foam Dart SMG"
	contains = list(/obj/item/gun/ballistic/automatic/toy/riot)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/donk/foamforce/c20
	name = "Foam Dart C20R"
	contains = list(/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/donk/foamforce/lmg
	name = "Foam Dart L6 Saw"
	contains = list(/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/donk/foamforce/turret
	name = "Foam Dart Turret"
	contains = list(/obj/item/storage/toolbox/emergency/turret/mag_fed/toy/pre_filled)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/donk/foamforce/pistol
	name = "Foam Dart Pistol"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)

/datum/supply_pack/imports/donk/foamforce/ammo
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/donk/foamforce/ammo/darts
	name = "Foamforce Darts"
	contains = list(/obj/item/ammo_box/foambox)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/donk/foamforce/ammo/riot
	name = "Foamforce Riot Darts"
	contains = list(/obj/item/ammo_box/foambox/riot)
	cost = PAYCHECK_COMMAND * 1.5

/datum/supply_pack/imports/donk/foamforce/ammo/pistol_mag
	name = "Foamforce Pistol Magazine"
	contains = list(/obj/item/ammo_box/magazine/toy/pistol)

/datum/supply_pack/imports/donk/foamforce/ammo/smg_mag
	name = "Foamforce SMG Magazine"
	contains = list(/obj/item/ammo_box/magazine/toy/smg)

/datum/supply_pack/imports/donk/foamforce/ammo/smgm45_mag
	name = "Foamforce SMGM45 Magazine"
	contains = list(/obj/item/ammo_box/magazine/toy/smgm45)

/datum/supply_pack/imports/donk/foamforce/ammo/m762_mag
	name = "Foamforce M762 Mag"
	contains = list(/obj/item/ammo_box/magazine/toy/m762)
