/datum/mod_theme/frontline
	name = "frontline"
	desc = "A Pan-Slavic Commonwealth Defense Collegia protective suit, designed for fortified positions operation and humanitarian aid."
	extended_desc = "A cheaper and more versatile replacement of the dated VOSKHOD Power Armor, designed by the then-Novaya Rossiyskaya Imperiya Innovations Collegia in \
	collaboration with Agurkrral researchers. Instead of the polyurea coated durathread-lined plasteel plates it utilises thin plates of Kevlar-backed titanium, making it lighter and more compact \
	while leaving place for other modules; yet due to its lack of energy dissipation systems, making its user more vulnerable against conventional laser weaponry. \
	Built-in projectile trajectory and munition assistance computer informs the operator of better places to aim, as well as the remaining munitions for \
	the currently held weapon and its magazines. This function is quite straining on the power cell, and as such, this suit is rarely seen outside of the fortified positions or humanitarian missions; \
	becoming the sign of what little hospitality and assistance the military can provide. However many people who had an experience with this MOD describe it as \"Very uncomfortable.\", \
	mainly due to its lack of proper environmental regulation systems. But because of its protective capabilities, extreme mass-production and cheap price, it easily became the main armor system of the PSC DC."
	default_skin = "frontline"
	armor_type = /datum/armor/mod_theme_frontline
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"frontline" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
		/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_frontline
	melee = 50
	bullet = 60
	laser = 40
	energy = 50
	bomb = 60
	bio = 100
	fire = 50
	acid = 80
	wound = 25

/obj/item/mod/control/pre_equipped/frontline
	theme = /datum/mod_theme/frontline
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/frontline/ert
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)
	default_pins = list(
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)


/datum/mod_theme/frontline/surplus
	name = "frontline surplus"
	activation_step_time = MOD_ACTIVATION_STEP_TIME + 3
	desc = "A Pan-Slavic Commonwealth Defense Collegia protective suit, designed for fortified positions operation and humanitarian aid, this one looks rather old and worn out."
	extended_desc = "A Pan-Slavic Commonwealth Defense Collegia protective suit, designed for fortified positions operation and humanitarian aid. \
		This one was purchased at auction, the combat spec modules have been removed but \
		it would still be right at home in the service of gunrunners and private security forces. \
		Though, it's internal systems have degraded, and some of the ablative plating has been removed."
	armor_type = /datum/armor/mod_theme_frontline/surplus

/datum/mod_theme/frontline/surplus/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	mod.set_mod_color("#888888", FIXED_COLOUR_PRIORITY)

/datum/armor/mod_theme_frontline/surplus
	melee = 30
	bullet = 40
	laser = 15
	energy = 15
	bomb = 30
	wound = 10

/datum/mod_theme/frontline/surplus/New()
	allowed_suit_storage -= /obj/item/shield/riot
	. = ..()

/obj/item/mod/control/pre_equipped/frontline/surplus
	theme = /datum/mod_theme/frontline/surplus
	applied_modules = /obj/item/mod/module/status_readout/operational

/datum/supply_pack/imports/surplus_nri_modsuit
	name = "Surplus Combat MODsuit Crate"
	desc = "A crate containing a single surplus MODsuit, \
		designed for use by the Pan-Slavic Commonwealth Defense Collegia. \
		This one has been stripped of its combat modules, but is still a good suit for those who need protection and mobility. \
		Notably, does not use or require a armor module."
	cost = CARGO_CRATE_VALUE * 22
	contains = list(/obj/item/mod/control/pre_equipped/frontline/surplus)
	order_flags = ORDER_CONTRABAND

/datum/mod_theme/policing
	name = "policing"
	desc = "A Pan-Slavic Commonwealth Internal Affairs Collegia general purpose protective suit, designed for coreworld patrols."
	extended_desc = "An Apadyne Technologies outsourced, then modified for frontier use by the responding imperial police precinct, MODsuit model, \
		designed for reassuring panicking civilians than participating in active combat. The suit's thin plastitanium armor plating is durable against environment and projectiles, \
		and comes with a built-in miniature power redistribution system to protect against energy weaponry; albeit ineffectively. \
		Thanks to the modifications of the local police, additional armoring has been added to its legs and arms, at the cost of an increased system load."
	default_skin = "policing"
	armor_type = /datum/armor/mod_theme_policing
	complexity_max = DEFAULT_MAX_COMPLEXITY - 1
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_deployed = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"policing" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_policing
	melee = 40
	bullet = 50
	laser = 30
	energy = 30
	bomb = 60
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/control/pre_equipped/policing
	theme = /datum/mod_theme/policing
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/magnetic_harness
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/magboot,
	)

///Unrelated-to-Spider-Clan version of the module.
/obj/item/mod/module/status_readout/operational
	name = "MOD operational status readout module"
	desc = "A once-common module, this technology unfortunately went out of fashion in the safer regions of space; \
		however, it remained in use everywhere else. This particular unit hooks into the suit's spine, \
		capable of capturing and displaying all possible biometric data of the wearer; sleep, nutrition, fitness, fingerprints, \
		and even useful information such as their overall health and wellness. The vitals monitor also comes with a speaker, loud enough \
		to alert anyone nearby that someone has, in fact, died. This specific unit has a clock and operational ID readout."
	display_time = TRUE
	death_sound = 'modular_skyrat/modules/novaya_ert/sound/flatline.ogg'
