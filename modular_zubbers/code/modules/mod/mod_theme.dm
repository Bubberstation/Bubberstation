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
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
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

/datum/mod_theme/asset_protection/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	var/parts = mod.get_parts()
	for(var/obj/item/part as anything in parts + mod)
		part.worn_icon_digi = 'modular_zubbers/icons/mob/clothing/modsuit/mod.dmi'

/datum/mod_theme/mining/New()
	variants += list(
		"imp" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
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
	. = ..()

#define LUSTWISH_HELMET_SEAL "slides closed"
#define LUSTWISH_HELMET_UNSEAL "slides open"
#define LUSTWISH_CHESTPLATE_SEAL "squeezes snugly around your body"
#define LUSTWISH_CHESTPLATE_UNSEAL "spontaniously loosens"
#define LUSTWISH_GAUNTLET_SEAL "clenches between each finger"
#define LUSTWISH_GAUNTLET_UNSEAL "relaxes from your hand"
#define LUSTWISH_BOOT_SEAL "squeezes tightly around your ankles"
#define LUSTWISH_BOOT_UNSEAL "gives room to your feet"

//// Sprites done by Toriate - Commissioned by The Sharkenning
/datum/mod_theme/lustwish
	name = "lustwish"
	desc = "A specialty designed lustwish themed modsuit which is based entirely off of earlier civilian modsuits."
	default_skin = "lustwish"
	hardlight_theme = ROYAL_PURPLE
	ui_theme = "ntos_darkmode"
	variants = list(
		"lustwish" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_lustwish.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_lustwish.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = LUSTWISH_HELMET_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_HELMET_SEAL,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = LUSTWISH_CHESTPLATE_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_CHESTPLATE_SEAL,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = LUSTWISH_GAUNTLET_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_GAUNTLET_SEAL,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = LUSTWISH_BOOT_UNSEAL,
				SEALED_MESSAGE = LUSTWISH_BOOT_SEAL,
			),
		),
	)

#undef LUSTWISH_HELMET_SEAL
#undef LUSTWISH_HELMET_UNSEAL
#undef LUSTWISH_CHESTPLATE_SEAL
#undef LUSTWISH_CHESTPLATE_UNSEAL
#undef LUSTWISH_GAUNTLET_SEAL
#undef LUSTWISH_GAUNTLET_UNSEAL
#undef LUSTWISH_BOOT_SEAL
#undef LUSTWISH_BOOT_UNSEAL

// VOSKHOD MOD, ported from Nova. By Vinylspiders

/datum/mod_theme/voskhod
	name = "refitted voskhod"
	desc = "A PSC standard-issue heavy duty suit, designed for fortified positions operation and humanitarian aid."
	extended_desc = "A more expensive, yet more versatile replacement of the dated Voskhod powered armor, designed by the Magellanic Economic Corporate Union researchers \
		in collaboration with and for the needs of the PSC. An efficient implementation of mixed exoskeletons in between and underneath its armor plating \
		allows for an unprecedented level of protection through an overly abundant use of durathread-backed plasteel plating; and the remnant materials of its predecessor allow for \
		a dubiously efficient dissipation of any stray photon ray or a concentrated laser, were one to get hit by them. The suit's infamous autoparamedical systems \
		are also fully present - or their chemical synthesizing part, consisting of a thin web of subdermal autoinjectors, reaction cameras and tubes lined through the \
		insulation material - leading into its control unit where the relevant synthesis proceeds, mainly out of raw materials of the pharmaceutical industry; \
		omnizine's older brother, protozine. The sight of a white-and-green juggernaut is the one that instills many fears into numerous pirates; earning it the reputation of a peacekeeper \
		and a niche amongst the rimworld population."
	default_skin = "voskhod"
	armor_type = /datum/armor/mod_theme_voskhod
	complexity_max = DEFAULT_MAX_COMPLEXITY //Five of which is occupied by the in-builts, thus it's closer to 10
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
		"voskhod" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
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

/datum/armor/mod_theme_voskhod
	melee = 30
	bullet = 30
	laser = 15
	energy = 20
	bomb = 30
	bio = 30
	fire = 80
	acid = 85
	wound = 20
