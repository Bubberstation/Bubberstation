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

/obj/item/mod/control/pre_equipped/security
	default_pins = list(
		/obj/item/mod/module/armor_booster/nanotrasen/security,
	)

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

/obj/item/mod/control/pre_equipped/safeguard
	default_pins = list(
		/obj/item/mod/module/armor_booster/nanotrasen/security/safeguard,
		/obj/item/mod/module/jetpack,
	)

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

/obj/item/mod/control/pre_equipped/magnate
	default_pins = list(
		/obj/item/mod/module/armor_booster/nanotrasen/magnate,
		/obj/item/mod/module/jetpack/advanced,
	)

/datum/mod_theme/responsory // ERT
	armor_type = /datum/armor/mod_theme_responsory

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

/obj/item/mod/control/pre_equipped/responsory
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/armor_booster/nanotrasen/security, //replaced the welding mask with a booster
	)
	default_pins = list(
		/obj/item/mod/module/armor_booster/nanotrasen/security,
	)

/obj/item/mod/control/pre_equipped/responsory/inquisitory
	applied_modules = list(
		/obj/item/mod/module/anti_magic,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/armor_booster/nanotrasen/security, //same as above
	)

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

/obj/item/mod/control/pre_equipped/corporate
	default_pins = list(
		/obj/item/mod/module/armor_booster/nanotrasen/corporate,
	)

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
// the default pins addition is directly in the skyrat blueshield mod module, because skyrat
