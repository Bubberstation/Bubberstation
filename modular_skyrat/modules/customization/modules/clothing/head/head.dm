/obj/item/clothing/head/hats/flakhelm	//Actually the M1 Helmet
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "flak helmet"
	icon_state = "m1helm"
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/hats_flakhelm
	desc = "A dilapidated helmet used in ancient wars. This one is brittle and essentially useless. An ace of spades is tucked into the band around the outer shell."
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/hats_flakhelm
	bomb = 0.1
	fire = -10
	acid = -15
	wound = 1

/obj/item/clothing/head/hats/flakhelm/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny/spacenam)

/datum/storage/pockets/tiny/spacenam
	attack_hand_interact = TRUE		//So you can actually see what you stuff in there

//Cyberpunk PI Costume - Sprites from Eris
/obj/item/clothing/head/fedora/det_hat/cybergoggles //Subset of detective fedora so that detectives dont have to sacrifice candycorns for style
	name = "type-34P semi-enclosed headwear"
	desc = "A popular helmet used by certain law enforcement agencies. It has minor armor plating and a neo-laminated fiber lining."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/fedora/det_hat/cybergoggles/civilian //Actually civilian with no armor for drip purposes only
	name = "type-34C semi-enclosed headwear"
	desc = "The civilian model of a popular helmet used by certain law enforcement agencies. It has no armor plating."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	armor_type = /datum/armor/none
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/intern/developer
	name = "intern beancap"

/obj/item/clothing/head/beret/sec/navywarden/syndicate
	name = "master at arms' beret"
	desc = "Surprisingly stylish, if you lived in a silent impressionist film."
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden/syndicate"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#353535#AAAAAA"
	post_init_icon_state = "beret_badge"
	armor_type = /datum/armor/navywarden_syndicate
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/navywarden_syndicate
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 50
	wound = 6

/obj/item/clothing/head/colourable_flatcap
	name = "colourable flat cap"
	desc = "You in the computers son? You work the computers?"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/colourable_flatcap"
	post_init_icon_state = "flatcap"
	greyscale_config = /datum/greyscale_config/flatcap
	greyscale_config_worn = /datum/greyscale_config/flatcap/worn
	greyscale_colors = "#79684c"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee
	name = "fashionable baseball cap"
	desc = "Rimmed and brimmed."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeesoft"
	soft_type = "yankee"
	dog_fashion = /datum/dog_fashion/head/yankee
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee/rimless
	name = "rimless fashionable baseball cap"
	desc = "Rimless for her pleasure."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeenobrimsoft"
	soft_type = "yankeenobrim"

/obj/item/clothing/head/fedora/brown //Fedora without detective's candy corn gimmick
	name = "brown fedora"
	icon_state = "detective"
	inhand_icon_state = null

/obj/item/clothing/head/hooded/standalone_hood
	name = "hood"
	desc = "A hood with a bit of support around the neck so it actually stays in place, for all those times you want a hood without the coat."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hooded/standalone_hood"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/head/head.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/head/head_teshari.dmi'
	post_init_icon_state = "hood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS|SHOWSPRITEEARS
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#4e4a43#F1F1F1"
	greyscale_config = /datum/greyscale_config/standalone_hood
	greyscale_config_worn = /datum/greyscale_config/standalone_hood/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/standalone_hood/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/standalone_hood/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/standalone_hood/worn/oldvox

/obj/item/clothing/head/beret/badge
	name = "badged beret"
	desc = "A beret. With a badge. What do you want, a dissertation? It's a hat."
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/badge"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#972A2A#EFEFEF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/cowboyhat_old
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "old cowboy hat"
	desc = "An older cowboy hat, perfect for any outlaw, though lacking fancy colour magic."
	icon_state = "cowboyhat_black"
	inhand_icon_state = "cowboy_hat_black"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

//BOWS
/obj/item/clothing/head/small_bow
	name = "small bow"
	desc = "A small compact bow that you can place on the side of your hair."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/small_bow"
	post_init_icon_state = "small_bow"
	greyscale_config = /datum/greyscale_config/small_bow
	greyscale_config_worn = /datum/greyscale_config/small_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/small_bow/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "small_bow_t")

/obj/item/clothing/head/large_bow
	name = "large bow"
	desc = "A large bow that you can place on top of your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/large_bow"
	post_init_icon_state = "large_bow"
	greyscale_config = /datum/greyscale_config/large_bow
	greyscale_config_worn = /datum/greyscale_config/large_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/back_bow
	name = "back bow"
	desc = "A large bow that you can place on the back of your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/back_bow"
	post_init_icon_state = "back_bow"
	greyscale_config = /datum/greyscale_config/back_bow
	greyscale_config_worn = /datum/greyscale_config/back_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/sweet_bow
	name = "sweet bow"
	desc = "A sweet bow that you can place on the back of your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/sweet_bow"
	post_init_icon_state = "sweet_bow"
	greyscale_config = /datum/greyscale_config/sweet_bow
	greyscale_config_worn = /datum/greyscale_config/sweet_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/hats/caphat/bicorne
	name = "captain's biscorne"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "It's good overthrowing the king."
	icon_state = "terragov_bicorne"
	worn_y_offset = 2

/obj/item/clothing/head/hats/caphat/sonnensoldner
	name = "captain's feathered hat"
	desc = "Cannons ready!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sonnensoldner_hat"
	worn_y_offset = 4
