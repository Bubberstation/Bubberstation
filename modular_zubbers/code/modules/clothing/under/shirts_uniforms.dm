/obj/item/clothing/under/greyscale
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/greyscale_clothing.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/greyscale_clothing_digi.dmi'
	// Defaults to FALSE for this type because greyscale items are less commonly adjustable
	can_adjust = FALSE

/*
*	This file is for things that are recolorable and/or mix-and-match. Things like Jeans, T-Shirts, Skirts.
*	Basically the hope is that items here will reuse component icons that already exist in the .dmis where possible.
*
*	(Do not put items here that are too specific. These should generally be generic, customizable uniforms.)
*	These will likely fit in the CASUALWEAR loadout category.
*/

/obj/item/clothing/under/greyscale/turtleneck
	name = "turtleneck with pants"
	desc = "A rather comfortable turtleneck worn with pants. Talk about robust threads."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck"
	post_init_icon_state = "turtleneck"
	greyscale_config = /datum/greyscale_config/turtlenecks
	greyscale_config_worn = /datum/greyscale_config/turtlenecks/worn
	greyscale_config_worn_digi = /datum/greyscale_config/turtlenecks/worn/digi
	greyscale_colors = "#787878#252525"
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/turtleneck/skirt
	name = "greyscaleturtleneck_skirt"
	desc = "A rather comfortable turtleneck worn with a skirt. A skirtleneck, if you would."
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck/skirt"
	post_init_icon_state = "skirtleneck"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/greyscale/gorkas
	name = "gorka jumpsuit"
	desc = "A somewhat comfortable gorka, as comfy as a regular jumpsuit but with a more unique design."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/gorkas"
	post_init_icon_state = "gags_gorka"
	greyscale_config = /datum/greyscale_config/gorkas
	greyscale_config_worn = /datum/greyscale_config/gorkas/worn
	greyscale_config_worn_digi = /datum/greyscale_config/gorkas/worn/digi
	greyscale_colors = "#787878#252525"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/overalls
	name = "turtleneck with overalls"
	desc = "Overalls worn over a turtleneck. A combination providing comfort and coverage... or, at the least, the coverage."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/overalls"
	post_init_icon_state = "overalls"
	greyscale_config = /datum/greyscale_config/sus_overalls
	greyscale_config_worn = /datum/greyscale_config/sus_overalls/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sus_overalls/worn/digi
	greyscale_colors = "#787878#252525#CCCED1"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = TRUE

/obj/item/clothing/under/greyscale/overalls/skirt
	name = "turtleneck with overalls-skirt"
	desc = "An overalls-skirt worn over a turtleneck. A combination providing comfort and coverage... or, at the least- no, wait, this doesn't really provide either."
	icon_state = "/obj/item/clothing/under/greyscale/overalls/skirt"
	post_init_icon_state = "overalls_skirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/greyscale/playsuit
	name = "playsuit"
	desc = "For the love of the game."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/playsuit"
	post_init_icon_state = "playsuit"
	greyscale_config = /datum/greyscale_config/playsuit
	greyscale_config_worn = /datum/greyscale_config/playsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/playsuit/worn/digi
	greyscale_colors = "#787878#252525#CCCED1#787878"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE

/obj/item/clothing/under/pants/camo
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/camo"
	post_init_icon_state = "camopants"
	greyscale_config = /datum/greyscale_config/camo_pants
	greyscale_config_worn = /datum/greyscale_config/camo_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo_pants/worn/digi
	greyscale_colors = "#69704C#6E5B4C#343741"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/greyscale/big_pants
	name = "\improper 'JUNCO' megacargo pants"
	desc = "De riguer for techno classicists, these extreme wide leg pants come back into style every \
		now and then. This pair has generous onboard storage."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/greyscale/big_pants"
	post_init_icon_state = "big_pants"
	greyscale_config = /datum/greyscale_config/big_pants
	greyscale_config_worn = /datum/greyscale_config/big_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/big_pants/worn/digi
	greyscale_colors = "#874f16"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER

/obj/item/clothing/under/pants/greyscale/loose_pants
	name = "loose pants"
	desc = "Some loose pants with a belt that looks comfy."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/greyscale/loose_pants"
	post_init_icon_state = "loose_pants"
	greyscale_config = /datum/greyscale_config/loose_pants
	greyscale_config_worn = /datum/greyscale_config/loose_pants/worn
	greyscale_colors = "#4d4d4d#666633#c0c0c0"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER

/obj/item/clothing/under/pants/greyscale/wide_leg
	name = "wide legged pants"
	desc = "An airy pair of wide-legged pants with a reasonably high waist."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/greyscale/wide_leg"
	post_init_icon_state = "wide_leg"
	greyscale_config = /datum/greyscale_config/wide_leg //The naming conventions behind the icons/configs here are a travesty, and I'm very sorry.
	greyscale_config_worn = /datum/greyscale_config/wide_leg/worn	//It will happen again.
	greyscale_config_worn_digi = /datum/greyscale_config/wide_leg/worn/digi
	greyscale_colors = "#ba917d"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER
