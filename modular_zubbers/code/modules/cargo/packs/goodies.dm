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
