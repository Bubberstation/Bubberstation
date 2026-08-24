// Aeri's Cheerleader Outfit - Sprites by Onule

// ---- ARMOR DATUMS ----

/datum/armor/clothing_under/cc_cheerleader
	melee = 10
	laser = 10
	energy = 15
	fire = 50
	acid = 40
	wound = 10

/datum/armor/clothing_under/centcom_cheerleader
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/datum/armor/clothing_under/syndie_cheerleader
	melee = 15
	bullet = 10
	laser = 10
	energy = 15
	fire = 50
	acid = 40
	wound = 10

/datum/armor/clothing_gloves/cc_cheerleader
	melee = 5
	fire = 10
	acid = 10

/datum/armor/clothing_gloves/centcom_cheerleader
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/datum/armor/clothing_gloves/syndie_cheerleader
	melee = 5
	bullet = 5
	laser = 5
	fire = 10
	acid = 10

/datum/armor/clothing_shoes/cc_cheerleader
	melee = 5
	bio = 50
	acid = 10

/datum/armor/clothing_shoes/centcom_cheerleader
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/datum/armor/clothing_shoes/syndie_cheerleader
	melee = 5
	bullet = 5
	bio = 50
	acid = 10

// ---- OUTFITS ----

/obj/item/clothing/under/costume/ba_cheerleader
	name = "NT cheerleading outfit"
	desc = "A Nanotrasen cheer uniform issued for company sporting events, morale drives, and mandatory victory \
		ceremonies. フレーフレー！ 今です！ Nobody on the design committee knows what that means, but it tested \
		extremely well with focus groups."
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_under"
	post_init_icon_state = "ba_cheerleader"
	inhand_icon_state = "ba_cheerleader"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader"
	greyscale_config = /datum/greyscale_config/ba_cheerleader
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ba_cheerleader/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/ba_cheerleader/inhand_right
	greyscale_colors = "#FFFFFF#2980b9"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/costume/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/centcom/ba_cheerleader
	name = "NT command cheerleading uniform"
	desc = "A command-grade Nanotrasen cheer uniform tailored for heads of staff, public appearances, and strategic \
		morale deployment. The nano-kevlar weave is sturdier than expected, presumably in case you are being boarded \
		by the opposing team. フレーフレー！ 今です！"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_under"
	post_init_icon_state = "ba_cheerleader"
	inhand_icon_state = "ba_cheerleader"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader"
	greyscale_config = /datum/greyscale_config/ba_cheerleader
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ba_cheerleader/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/ba_cheerleader/inhand_right
	greyscale_colors = "#FFFFFF#1a3a6b"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/cc_cheerleader

/obj/item/clothing/under/rank/centcom/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/centcom/ba_cheerleader/centcom
	name = "CentCom cheerleading uniform"
	desc = "A Central Command cheer uniform. フレーフレー！ 今です！ The nanoweave lining is inexplicably rated \
		against small arms fire, laser discharge, and moderate explosive yield. The exposed midriff remains \
		completely unprotected, by design. Watchdog groups believe this may be an attempt to induce brain \
		aneurisms in Syndicate agents who observe it."
	greyscale_colors = "#FFFFFF#2ecc71"
	armor_type = /datum/armor/clothing_under/centcom_cheerleader

/obj/item/clothing/under/syndicate/ba_cheerleader
	name = "Syndicate cheerleading uniform"
	desc = "A Syndicate cheer uniform reinforced with kevlar. フレーフレー！ 今です！ Your fellow operatives \
		aren't going to encourage themselves. Cybersun Industries proudly supports morale, wellness, and \
		hostile takeover spirit."
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_under"
	post_init_icon_state = "ba_cheerleader"
	inhand_icon_state = "ba_cheerleader"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader"
	greyscale_config = /datum/greyscale_config/ba_cheerleader
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ba_cheerleader/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/ba_cheerleader/inhand_right
	greyscale_colors = "#1a1a1a#7b241c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	has_sensor = NO_SENSORS
	armor_type = /datum/armor/clothing_under/syndie_cheerleader

/obj/item/clothing/under/syndicate/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

// ---- GLOVES ----

/obj/item/clothing/gloves/ba_cheerleader
	name = "NT cheerleading gloves"
	desc = "Soft cotton cheer gloves. Go team!"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_gloves_icon"
	post_init_icon_state = "ba_cheerleader_gloves"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader_gloves"
	greyscale_config = /datum/greyscale_config/ba_cheerleader_gloves
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader_gloves/worn
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#FFFFFF#2980b9"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = HANDS

/obj/item/clothing/gloves/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/gloves/ba_cheerleader/command
	name = "NT command cheerleading gloves"
	desc = "Cheer gloves with a discreet nano-kevlar lining. Comfortable and authoritative."
	greyscale_colors = "#FFFFFF#1a3a6b"
	body_parts_covered = HANDS|ARMS
	siemens_coefficient = 0
	armor_type = /datum/armor/clothing_gloves/cc_cheerleader

/obj/item/clothing/gloves/ba_cheerleader/centcom
	name = "CentCom cheerleading gloves"
	desc = "Cheer gloves of unmistakably high-grade nanoweave construction. They feel less like costume accessories \
		and more like evidence in an appropriations hearing; it would be cheaper to make them out of actual gold."
	greyscale_colors = "#FFFFFF#2ecc71"
	body_parts_covered = HANDS|ARMS
	siemens_coefficient = 0
	armor_type = /datum/armor/clothing_gloves/centcom_cheerleader

/obj/item/clothing/gloves/ba_cheerleader/syndicate
	name = "Syndicate cheerleading gloves"
	desc = "Cheer gloves reinforced across the knuckles with kevlar. Ideal for \"encouraging\" hostile targets \
		to be unconscious."
	greyscale_colors = "#1a1a1a#7b241c"
	body_parts_covered = HANDS|ARMS
	siemens_coefficient = 0
	armor_type = /datum/armor/clothing_gloves/syndie_cheerleader

// ---- SNEAKERS ----

/obj/item/clothing/shoes/sneakers/ba_cheerleader
	name = "NT cheerleading sneakers"
	desc = "A pair of sporty sneakers. Good for cheering. Usefulness for running not evaluated by Nanotrasen \
		Corporation; sprint at your own risk."
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_shoes_icon"
	post_init_icon_state = "ba_cheerleader_shoes"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader_digi.dmi'
	worn_icon_state = "ba_cheerleader_shoes"
	greyscale_config = /datum/greyscale_config/ba_cheerleader_shoes
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader_shoes/worn
	greyscale_config_worn_digi = /datum/greyscale_config/ba_cheerleader_shoes/worn/digi
	greyscale_colors = "#FFFFFF#2980b9"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/sneakers/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/shoes/sneakers/ba_cheerleader/command
	name = "NT command cheerleading sneakers"
	desc = "A pair of sporty sneakers. Good for cheering. Usefulness for running not evaluated by Nanotrasen \
		Corporation; sprint at your own risk."
	greyscale_colors = "#FFFFFF#1a3a6b"
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clothing_shoes/cc_cheerleader

/obj/item/clothing/shoes/sneakers/ba_cheerleader/centcom
	name = "CentCom cheerleading sneakers"
	desc = "CentCom cheer sneakers with custom anti-fatigue inserts, rated for zero-gravity routines."
	greyscale_colors = "#FFFFFF#2ecc71"
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clothing_shoes/centcom_cheerleader

/obj/item/clothing/shoes/sneakers/ba_cheerleader/syndicate
	name = "Syndicate cheerleading sneakers"
	desc = "Cheer sneakers with blood-red orthopedic gel inserts and slip resistant soles rated for \"Performing\" \
		even in environments with normally untenable levels of blood, lubricant, and several surfaces \
		Cybersun Legal advised against listing."
	greyscale_colors = "#1a1a1a#7b241c"
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clothing_shoes/syndie_cheerleader
	clothing_traits = list(TRAIT_NO_SLIP_WATER)
