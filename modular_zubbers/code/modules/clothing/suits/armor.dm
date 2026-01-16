/obj/item/clothing/suit/armor/vest/collared_vest//Sprite done by offwrldr/Bangle - same person. Recently edited sprite.
	name = "GLP-C 'Úlfur' Vest"
	desc = "A set of General Light Protective armor, with complimentary pauldrons and an additional armored collar, similar to a gorget. This pattern of armored vest is typically afforded to diplomats and members of the press in hostile environments, though has seen use among private security forces. The armored collar is designed to protect the neck and throat from shrapnel. All things considered, it's quite comfortable, though many unfortunate wearers are often mistaken for combatants given the militarized aesthetic."
	icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	icon_state = "vest_worn"
	inhand_icon_state = null
	armor_type = /datum/armor/suit_armor

/datum/atom_skin/collared_vest
	abstract_type = /datum/atom_skin/collared_vest

/datum/atom_skin/collared_vest/red
	preview_name = "Red Pattern"
	new_icon_state = "vest_worn_red"

/datum/atom_skin/collared_vest/neutral
	preview_name = "Neutral Pattern"
	new_icon_state = "vest_worn"

/datum/atom_skin/collared_vest/blue
	preview_name = "Blue Pattern"
	new_icon_state = "vest_worn_blue"

/obj/item/clothing/suit/armor/vest/collared_vest/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/collared_vest)

/obj/item/clothing/suit/armor/vest/secjacket // Port from TG Station (DrTuxedo)
	name = "security jacket"
	desc = "A red jacket in red Security colors. It has hi-vis stripes all over it."
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	icon_state = "secjacket"
	inhand_icon_state = "armor"
	armor_type = /datum/armor/suit_armor
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/secjacket/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/armor/vest/secjacket/blue // Port from TG Station (DrTuxedo)
	name = "security jacket"
	desc = "A blue jacket in blue Peacekeeper colors. It has hi-vis stripes all over it."
	icon_state = "secjacket_blue"

//Maid SEC
//Icon by Onule!
/obj/item/clothing/suit/armor/vest/maid
	name = "cnc discreet armour vest"
	desc = "An armored durathread apron. This relatively innocent at first glance outfit is actually the specialized type worn by Nanotrasen's infamous high profile 'Cleaning and Clearing' kill squads. It's a lot more robust than it's janitorial counterpart. There are loops on the back for holding your 'mop'."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "security_maid"
	allowed = list(
		/obj/item/access_key,
		/obj/item/assembly/mousetrap,
		/obj/item/clothing/gloves,
		/obj/item/flashlight,
		/obj/item/forcefield_projector,
		/obj/item/grenade/chem_grenade,
		/obj/item/holosign_creator,
		/obj/item/key/janitor,
		/obj/item/lightreplacer,
		/obj/item/melee/flyswatter,
		/obj/item/mop,
		/obj/item/mop/advanced,
		/obj/item/paint/paint_remover,
		/obj/item/plunger,
		/obj/item/pushbroom,
		/obj/item/reagent_containers/cup/bucket,
		/obj/item/reagent_containers/spray,
		/obj/item/soap,
		/obj/item/wirebrush,
	)

/obj/item/clothing/suit/armor/vest/maid/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/armor/elder_atmosian
	desc = "The pinnacle of atmospherics equipment, an expensive modified atmospherics firesuit plated in one of the most luxurious and durable metals known to man. Providing full atmos coverage without the heavy materials of the firesuit to slow the user down, it also offers far greater protection to most sources of damage."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	material_flags = NONE
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	flags_inv = HIDEJUMPSUIT | HIDESHOES | HIDEGLOVES | HIDETAIL
	custom_materials = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/clothing/suit/armor/elder_atmosian/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/fireaxe/metal_h2_axe,
	)

/datum/armor/armor_elder_atmosian
	melee = 40
	bullet = 30
	laser = 40
	energy = 40
	bomb = 100
	bio = 50
	fire = 100
	acid = 50
	wound = 25

//MetroCop armor, by HL13 station.
/obj/item/clothing/suit/armor/vest/alt/sec/metrocop
	name = "metrocop armor"
	desc = "Pick up that can. Uses advanced GigaSlop brand Matrixes to allow alternative variants!"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "civilprotection"

/obj/item/clothing/suit/armor/vest/alt/sec/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop_armor)

/datum/atom_skin/metrocop_armor
	abstract_type = /datum/atom_skin/metrocop_armor

/datum/atom_skin/metrocop_armor/metro_cop
	preview_name = "Metro Cop"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop_armor/metro_coat
	preview_name = "MetroCop Coat"
	new_icon_state = "cp_trenchcoat"

/datum/atom_skin/metrocop_armor/medic
	preview_name = "Medic"
	new_icon_state = "medicalofficer"

/datum/atom_skin/metrocop_armor/red_trim
	preview_name = "Red Trim"
	new_icon_state = "dv_vest"

/datum/atom_skin/metrocop_armor/overwatch_white
	preview_name = "White Overwatch"
	new_icon_state = "overwatch_white"

/datum/atom_skin/metrocop_armor/overwatch
	preview_name = "Overwatch"
	new_icon_state = "overwatch"

/datum/atom_skin/metrocop_armor/overwatch_red
	preview_name = "Red Overwatch"
	new_icon_state = "overwatch_red"
