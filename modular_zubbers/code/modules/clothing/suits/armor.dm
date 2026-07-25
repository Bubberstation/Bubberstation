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

//Maid SEC
//Icon by Onule!
/obj/item/clothing/suit/armor/vest/maid
	name = "cnc discreet armour vest"
	desc = "An armored durathread apron. This relatively innocent at first glance outfit is actually the specialized type worn by Nanotrasen's infamous high profile 'Cleaning and Clearing' kill squads. It's a lot more robust than it's janitorial counterpart. There are loops on the back for holding your 'mop'."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
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

// Virosec armor, sprites by axietheaxolotl

/obj/item/clothing/suit/armor/vest/viro
	name = "armor vest"
	desc = "A plate carrier meant to protect against all forms of threats."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "sec_platecarrier"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/vest/viro/heavy
	name = "heavy armor vest"
	desc = "A heavier plate carrier meant to protect against all forms of threats."
	icon_state = "sec_heavyvest"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/vest/viro/leatherjacket
	name = "security leather jacket"
	desc = "A leather jacket for security officers, with a badass red collar."
	icon_state = "sec_leatherjacket"

/obj/item/clothing/suit/armor/vest/viro/softshell
	name = "Security softshell jacket"
	desc = "A softshell weather-resistant jacket perfect for those plants with stormy weather."
	icon_state = "sec_softshell"

/obj/item/clothing/suit/armor/hos/viro
	name = "armored greatcoat"
	desc = "A greatcoat enhanced with a special alloy for some extra protection and style for those with a commanding presence."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hos_greatcoat"
	inhand_icon_state = "greatcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/armor_hos
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/hos/viro/vest
	name = "Head of Security's Plate Carrier"
	desc = "A plate carrier enhanced with a special alloy for some extra protection and style for those with a commanding presence."
	icon_state = "hos_platecarrier"
	inhand_icon_state = "armor"

/datum/armor/armor_hos
	melee = 30
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 70
	acid = 90
	wound = 10

/obj/item/clothing/suit/armor/hos/viro/trenchcoat
	name = "armored trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. The epitome of tactical plainclothes."
	icon_state = "hos_overcoat"
	inhand_icon_state = "hostrench"
	flags_inv = 0
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/hos/viro/trenchcoat/winter
	name = "head of security's winter trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar, padded with wool on the collar and inside. You feel strangely lonely wearing this coat."
	icon_state = "hos_wintercoat"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/vest/viro/warden
	name = "warden's jacket"
	desc = "A navy-blue armored jacket with blue shoulder designations and '/Warden/' stitched into one of the chest pockets."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "warden_jacket_v"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	strip_delay = 7 SECONDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/viro/warden/alt
	name = "warden's armored jacket"
	desc = "A red jacket with silver rank pips and body armor strapped on top."
	icon_state = "warden_alt"

/obj/item/clothing/suit/armor/vest/viro/warden/wintercoat
	name = "the warden's winter coat"
	desc = "A winter coat with an armored vest resting atop it, with some padded with wool on the collar and inside."
	icon_state = "warden_winterjacket"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/militia
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/hooded/cultrobes
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/head/hooded/cult_hoodie
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/suit/hooded/cultlain_robe
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/head/hooded/cultlain_hood
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/suit/hooded/secjuggernaut
	name = "security juggernaut suit"
	desc = "The Advanced Security Suit offers nigh-perfect protection of the wearer through an advanced layering of kevlar, titanium, and ceramic plates. \
		The construction of the suit unfortunately renders it incredibly heavy and cumbersome, effectively slowing the user to a crawl and heavily limiting their mobility options. \
		Only through recently developed micro-anti-gravitational generators can the suit actually be worn and moved in. \
		Comes along with a built-in helmet for EVA action."
	icon_state = "security_jugger"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	inhand_icon_state = "swat_suit"
	hoodtype = /obj/item/clothing/head/hooded/secjuggernaut
	hood_up_affix = ""
	armor_type = /datum/armor/secjuggernaut
	w_class = WEIGHT_CLASS_HUGE
	siemens_coefficient = 0
	strip_delay = 25 SECONDS
	equip_delay_self = 12 SECONDS
	equip_delay_other = 15 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	item_flags = SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	bubber_obj_flags = TRUE_IMMUTABLE_SLOW
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	slowdown = 5
	drag_slowdown = 5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, TRAIT_PUSHIMMUNE, TRAIT_NEGATES_GRAVITY, TRAIT_NO_SLIP_WATER, TRAIT_NO_VEHICLE, TRAIT_HUGE_CLOTHES, TRAIT_NO_BUCKLE)
	allowed = list(
		/obj/item/tank/internals,
		/obj/item/tank/jetpack/captain,
	)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40.4,
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.4
	)

/obj/item/clothing/suit/hooded/secjuggernaut/examine(mob/user)
	. = ..()
	. += span_warning("Trying to buckle to anything while wearing this is impossible, whether it be a chair, cyborg, horse, or golf cart.")

/obj/item/clothing/suit/hooded/secjuggernaut/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/secjuggernaut
	name = "security juggernaut helmet"
	desc = "A helmet built into the Advanced Security Suit. It offers nigh-perfect protection with the drawback of being permanently affixed to an incredibly heavy suit. \
		It is pressure resistant, flash-protected, and comes with a built-in seclite for visiblity in dark areas.\
		While made of the same materials and having the same overall construction, built-in servos and actuators allow it to be easily put on compared to the suit it comes with."
	icon_state = "security_jugger0"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_muzzled = 'modular_zubbers/icons/mob/clothing/head/helmet_muzzled.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	armor_type = /datum/armor/secjuggernaut
	flash_protect = FLASH_PROTECTION_WELDER
	strip_delay = 15 SECONDS
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | HEADINTERNALS
	bubber_obj_flags = TRUE_IMMUTABLE_SLOW
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEFACE|HIDESNOUT|SHOWSPRITEEARS
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH|PEPPERPROOF
	resistance_flags = FIRE_PROOF | ACID_PROOF

	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 7
	light_power = 1.0
	light_color = "#99ccff"
	light_on = FALSE
	var/on = FALSE

	var/sound_on = 'sound/items/weapons/magin.ogg'
	var/sound_off = 'sound/items/weapons/magout.ogg'

/obj/item/clothing/head/hooded/secjuggernaut/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddComponent(/datum/component/wearertargeting/earprotection)

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
	melee = 80
	bullet = 80
	laser = 70
	energy = 40
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 40

/obj/item/clothing/suit/armor/vest/blueshirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/alt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/alt/sec
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/warden
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/warden/alt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/capcarapace
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/blueshield/jacket
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/hop
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
