// Buffs security modsuit armor (relative), adds armour boosters to every sec and command and corporate modsuit, halves all default armour values
/datum/mod_theme/security
	armor_type = /datum/armor/mod_theme_security
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/nanotrasen/security)

/datum/armor/mod_theme_security
	melee = 20
	bullet = 15
	laser = 15
	energy = 20
	bomb = 30
	bio = 100
	fire = 100
	acid = 100
	wound = 10

/obj/item/mod/control/pre_equipped/security/Initialize(mapload, new_theme, new_skin, new_core)
	default_pins += /obj/item/mod/module/armor_booster/nanotrasen/security
	applied_modules -= /obj/item/mod/module/headprotector
	. = ..()

/datum/mod_theme/safeguard //HoS
	armor_type = /datum/armor/mod_theme_safeguard
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/nanotrasen/security/safeguard)

/datum/armor/mod_theme_safeguard
	melee = 20
	bullet = 15
	laser = 15
	energy = 20
	bomb = 30
	bio = 100
	fire = 100
	acid = 95
	wound = 25

/obj/item/mod/control/pre_equipped/safeguard/Initialize(mapload, new_theme, new_skin, new_core)
	default_pins += /obj/item/mod/module/armor_booster/nanotrasen/security/safeguard
	applied_modules -= /obj/item/mod/module/headprotector
	. = ..()

/datum/mod_theme/magnate // Captain
	armor_type = /datum/armor/mod_theme_magnate
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/nanotrasen/magnate)

/datum/armor/mod_theme_magnate
	melee = 20
	bullet = 20
	laser = 20
	energy = 20
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 20

/obj/item/mod/control/pre_equipped/magnate/Initialize(mapload, new_theme, new_skin, new_core)
	default_pins += /obj/item/mod/module/armor_booster/nanotrasen/magnate
	applied_modules -= /obj/item/mod/module/headprotector
	. = ..()

/datum/mod_theme/responsory // ERT
	armor_type = /datum/armor/mod_theme_responsory
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/nanotrasen/security)

/datum/armor/mod_theme_responsory
	melee = 20
	bullet = 15
	laser = 15
	energy = 20
	bomb = 50
	bio = 100
	fire = 100
	acid = 90
	wound = 15

/obj/item/mod/control/pre_equipped/responsory/Initialize(mapload, new_theme, new_skin, new_core)
	applied_modules -= list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/armor_booster/retractplates,
		/obj/item/mod/module/armor_booster, //none of them use these and im not sure if its redundant, better to be safe than not.
		)
	default_pins += /obj/item/mod/module/armor_booster/nanotrasen/security
	. = ..()

/datum/mod_theme/corporate // Centcom Commander
	armor_type = /datum/armor/mod_theme_corporate
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/nanotrasen/corporate)

/datum/armor/mod_theme_corporate
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 15

/obj/item/mod/control/pre_equipped/corporate/Initialize(mapload, new_theme, new_skin, new_core)
	default_pins += /obj/item/mod/module/armor_booster/nanotrasen/corporate
	. = ..()

// Blueshield Armor
/datum/mod_theme/blueshield
	armor_type = /datum/armor/mod_theme_blueshield
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/nanotrasen/blueshield)

/datum/armor/mod_theme_blueshield // Not really great for fighting.
	melee = 20
	bullet = 10
	laser = 10
	energy = 15
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 20

/obj/item/mod/control/pre_equipped/blueshield/
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/quick_carry,
	)

/obj/item/mod/control/pre_equipped/blueshield/Initialize(mapload, new_theme, new_skin, new_core)
	default_pins += /obj/item/mod/module/armor_booster/nanotrasen/blueshield
	. = ..()
