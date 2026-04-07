//Modsuits used by offstation syndicate factions

//Infiltrator mod minus the Psi Emitter

/datum/mod_theme/infiltrator/persistence
	extended_desc = "Several questions have been raised over the years in regards to the clandestine Infiltrator modular suit. \
		Why is the suit blood red despite being a sneaking suit? Why did a movie company of all things develop a stealth suit? \
		The simplest answer is that Roseus Galactic hire more than a few eccentric individuals who know more about \
		visual aesthetics and prop design than they do functional operative camouflage. But the true reason goes deeper. \
		The visual appearance of the suit exemplifies brazen displays of power, not true stealth. However, the suit's inbuilt stealth mechanisms\
		prevent anyone from fully recognizing the occupant, only the suit, creating perfect anonymity. \
		This one seems to lack the Psi Emitter usually seen in this type of modsuit."

	inbuilt_modules = list(/obj/item/mod/module/infiltrator, /obj/item/mod/module/storage/belt)
	allowed_suit_storage = list(
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)

//Admiral's Unique modsuit, designed around being a Cybersun modsuit and not specifically Syndicate

/obj/item/mod/control/pre_equipped/daimyo
	theme = /datum/mod_theme/daimyo
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/longfall,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/night,
		/obj/item/mod/module/welding/syndicate,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/night,
	)

/datum/mod_theme/daimyo
	name = "daimyo"
	desc = "A bleeding-edge armored suit designed by Cybersun Industries in tandem with Nakamura Engineering."
	extended_desc = "A strikingly unique looking up-armored MODsuit which calls back to Cybersun's long lineage, \
		the Daimyo MODsuit was designed in tandem with Nakamura Engineering's top divisions. It utilizes advanced technology\
		provided to them by a secretive Cybersun West subsidiary known only as the Invictia Research Division. \
		Created as a response to the Apocryphal MODsuit, the Daimyo MODsuit provides less overall protection \
		to lean on a more agressive approach to confrontations. Only seen worn by Cybersun Executives and \
		high ranking employees, this MODsuit symbolizes Cybersun excellence and power. This one has been modified \
		slightly to better protect the wearer from the harshness of Lavaland, where it's deployed. \
		A tag on the core reads 'This is the most expensive piece of equipment you'll ever handle in your life, \
		do NOT lose it.' -Ruggero"
	default_skin = "daimyo"
	armor_type = /datum/armor/mod_theme_daimyo
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	ui_theme = "syndicate"
	complexity_max = DEFAULT_MAX_COMPLEXITY + 10
	hearing_protection = EAR_PROTECTION_NORMAL
	allowed_suit_storage = list(
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)
	variants = list(
		"daimyo" = list(
			MOD_ICON_OVERRIDE = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
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

/datum/armor/mod_theme_daimyo
	melee = 80
	bullet = 60
	laser = 50
	energy = 60
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 25

/datum/mod_theme/daimyo/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	var/parts = mod.get_parts()
	for(var/obj/item/part as anything in parts + mod)
		part.worn_icon_digi = 'modular_zubbers/icons/mob/clothing/modsuit/mod.dmi'
