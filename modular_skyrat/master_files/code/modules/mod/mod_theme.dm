// -- Modular mod theme changes. -- (Modception.)
/datum/armor/mod_theme_engineering  // Engineer
	melee = 10
	bullet = 5
	laser = 20
	energy = 10
	bomb = 30
	bio = 100
	fire = 100
	acid = 25
	wound = 10

/datum/armor/mod_theme_atmospheric // Atmospheric Technician
	melee = 10
	bullet = 5
	laser = 10
	energy = 15
	bomb = 40
	bio = 100
	fire = 100
	acid = 75
	wound = 10

/datum/armor/mod_theme_advanced  // Chief Engineer
	melee = 30
	bullet = 5
	laser = 20
	energy = 15
	bomb = 50
	bio = 100
	fire = 100
	acid = 90
	wound = 10

/datum/armor/mod_theme_loader // Cargo
	melee = 20
	bullet = 5
	laser = 10
	energy = 10
	bomb = 50
	bio = 100
	fire = 50
	acid = 25
	wound = 10

/datum/armor/mod_theme_medical // Paramedic / Medical Doctor
	melee = 10
	bullet = 5
	laser = 5
	energy = 10
	bomb = 10
	bio = 100
	fire = 60
	acid = 75
	wound = 10

/datum/armor/mod_theme_rescue // Chief Medical Officer
	melee = 20
	bullet = 10
	laser = 10
	energy = 10
	bomb = 20
	bio = 100
	fire = 100
	acid = 100
	wound = 10

/datum/armor/mod_theme_research // Research Director
	melee = 20
	bullet = 15
	laser = 20
	energy = 20
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 15

/datum/armor/mod_theme_prototype // Charlie Station
	melee = 25
	bullet = 5
	laser = 20
	energy = 20
	bomb = 50
	bio = 100
	fire = 100
	acid = 75
	wound = 5

/datum/mod_theme/asset_protection
	name = "Asset Protection"
	desc = "A weaker version of the Apocryphal Modsuit, chiefly worn by Nanotrasen Asset Protection."
	extended_desc = "A weaker version of the Apocryphal Modsuit meant for the Nanotrasen Asset Protection Division. This suit boasts higher speed and advanced actuators that make moving feel almost weightless, with advanced features for the savvy bodyguard."
	default_skin = "asset_protection"
	armor_type = /datum/armor/mod_theme_ap
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	variants = list(
		"asset_protection" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),

	)

/datum/armor/mod_theme_ap
	melee = 50
	bullet = 40
	laser = 50
	energy = 50
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 15
