// Buffs security modsuit armor
/datum/mod_theme/security
	armor_type = /datum/armor/mod_theme_security

/datum/armor/mod_theme_security
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 10

// Blueshield Armor
/datum/mod_theme/blueshield
	armor_type = /datum/armor/mod_theme_blueshield

/datum/armor/mod_theme_blueshield // Not really great for fighting.
	melee = 40
	bullet = 20
	laser = 20
	energy = 30
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 20

/datum/mod_theme/syndicate // Bloodred Syndicate
	inbuilt_modules = null //removing the armour booster. Its just base armour now.
	slowdown_active = 0 //no armour booster to control slowdown

/datum/armor/mod_theme_syndicate
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 40
	bio = 100
	fire = 50
	acid = 90
	wound = 25

/obj/item/mod/control/pre_equipped/syndicate/Initialize()
	default_pins -= /obj/item/mod/module/armor_booster
	. = ..()

/datum/mod_theme/elite // Elite Syndiate
	inbuilt_modules = null //ditto
	slowdown_active = 0

/datum/armor/mod_theme_elite
	melee = 60
	bullet = 60
	laser = 50
	energy = 60
	bomb = 60
	bio = 100
	fire = 100
	acid = 100
	wound = 25

/obj/item/mod/control/pre_equipped/elite/Initialize()
	default_pins -= /obj/item/mod/module/armor_booster
	. = ..()

/datum/mod_theme/contractor
	inbuilt_modules = list(/obj/item/mod/module/chameleon/contractor)

/datum/armor/mod_theme_contractor
	melee = 30
	bullet = 10
	laser = 30
	energy = 30
	bomb = 35
	bio = 100
	fire = 80
	acid = 90
	wound = 25

/obj/item/mod/control/pre_equipped/contractor/Initialize()
	default_pins -= /obj/item/mod/module/armor_booster
	. = ..()
