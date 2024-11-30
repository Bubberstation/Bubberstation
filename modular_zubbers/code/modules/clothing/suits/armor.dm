/obj/item/clothing/suit/armor/metrocop //Sprite done by Gat1Day#2892
	name = "Civil Protection Suit"
	desc = "Standard issue armor for Civil Protection."
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	cold_protection = CHEST|ARMS|GROIN|LEGS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|ARMS|GROIN|LEGS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hardsuit-metrocop"
	inhand_icon_state =  null
	blood_overlay_type = "hardsuit-metrocop"
	armor_type =/datum/armor/suit_armor

/obj/item/clothing/suit/armor/metrocopriot //Sprite done by Gat1Day#2892
	name = "Riot Civil Protection Suit"
	desc = "A Suit of armor to help Civil Protection deal with unruly citizens."
	icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hardsuit-metrocop-RL"
	inhand_icon_state =  null
	blood_overlay_type = "hardsuit-metrocop-RL"
	armor_type = /datum/armor/armor_riot

/obj/item/clothing/suit/armor/vest/collared_vest//Sprite done by offwrldr/Bangle - same person. Recently edited sprite.
	name = "GLP-C 'Úlfur' Vest"
	desc = "A set of General Light Protective armor, with complimentary pauldrons and an additional armored collar, similar to a gorget. This pattern of armored vest is typically afforded to diplomats and members of the press in hostile environments, though has seen use among private security forces. The armored collar is designed to protect the neck and throat from shrapnel. All things considered, it's quite comfortable, though many unfortunate wearers are often mistaken for combatants given the militarized aesthetic."
	icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	icon_state = "vest_worn"
	inhand_icon_state = null
	armor_type = /datum/armor/suit_armor
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Pattern" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi',
			RESKIN_ICON_STATE = "vest_worn_red",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi',
			RESKIN_WORN_ICON_STATE = "vest_worn_red"
		),
		"Neutral Pattern" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi',
			RESKIN_ICON_STATE = "vest_worn",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi',
			RESKIN_WORN_ICON_STATE = "vest_worn",
		),
		"Blue Pattern" = list(
			RESKIN_ICON = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi',
			RESKIN_ICON_STATE = "vest_worn_blue",
			RESKIN_WORN_ICON = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi',
			RESKIN_WORN_ICON_STATE = "vest_worn_blue",
			RESKIN_SUPPORTS_VARIATIONS_FLAGS = NONE
		)
	)

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
