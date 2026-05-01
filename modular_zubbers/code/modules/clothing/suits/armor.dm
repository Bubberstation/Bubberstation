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

/obj/item/clothing/suit/hooded/secjuggernaut
	name = "security juggernaut suit"
	desc = "An advanced suit of armor. Difficult to put on and cumbersome to wear. Comes with a built-in helmet for EVA action."
	icon_state = "security_jugger"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	inhand_icon_state = "swat_suit"
	hoodtype = /obj/item/clothing/head/hooded/secjuggernaut
	hood_up_affix = ""
	armor_type = /datum/armor/secjuggernaut
	siemens_coefficient = 0
	strip_delay = 25 SECONDS
	equip_delay_self = 12 SECONDS
	equip_delay_other = 15 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | IMMUTABLE_SLOW | SNUG_FIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	slowdown = 5
	drag_slowdown = 5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, TRAIT_PUSHIMMUNE, TRAIT_NEGATES_GRAVITY, TRAIT_NO_SLIP_WATER, TRAIT_NO_VEHICLE, TRAIT_HUGE_CLOTHES)
	allowed = list(
		/obj/item/gun/ballistic/shotgun/automatic/combat
	)

/obj/item/clothing/suit/hooded/secjuggernaut/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/secjuggernaut
	name = "security juggernaut helmet"
	desc = "An advanced helmet. Easily put on compared to the armor it came with."
	icon_state = "security_jugger"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_muzzled = 'modular_zubbers/icons/mob/clothing/head/helmet_muzzled.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	armor_type = /datum/armor/secjuggernaut
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | IMMUTABLE_SLOW | SNUG_FIT | HEADINTERNALS
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH|PEPPERPROOF
	resistance_flags = FIRE_PROOF | ACID_PROOF

	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 0.8
	light_color = "#ffcc99"
	light_on = FALSE
	var/on = FALSE

	var/sound_on = 'sound/items/weapons/magin.ogg'
	var/sound_off = 'sound/items/weapons/magout.ogg'

/obj/item/clothing/head/hooded/secjuggernaut/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/hooded/secjuggernaut/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		playsound(src, sound_on, 40, TRUE)
		turn_on(user)
	else
		playsound(src, sound_off, 40, TRUE)
		turn_off(user)
	update_appearance()

/obj/item/clothing/head/hooded/secjuggernaut/update_icon_state()
	icon_state = "security_jugger[on]"
	return ..()

/obj/item/clothing/head/hooded/secjuggernaut/proc/turn_on(mob/user)
	set_light_on(TRUE)

/obj/item/clothing/head/hooded/secjuggernaut/proc/turn_off(mob/user)
	set_light_on(FALSE)

/obj/item/clothing/head/hooded/secjuggernaut/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(on)
		toggle_helmet_light()
		return TRUE

/obj/item/clothing/head/hooded/secjuggernaut/attack_self(mob/living/user)
	toggle_helmet_light(user)

/datum/armor/secjuggernaut
	melee = 75
	bullet = 70
	laser = 60
	energy = 50
	bomb = 100
	bio = 100
	fire = 100
	acid = 90
	wound = 30
