/obj/item/clothing/under/greyscale
	icon = 'modular_zubbers/icons/obj/clothing/under/greyscale.dmi'
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
	icon = 'modular_zubbers/icons/obj/clothing/under/greyscale.dmi'
	icon_state = "greyscaleturtleneck"
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
	icon = 'modular_zubbers/icons/obj/clothing/under/greyscale.dmi'
	icon_state = "greyscalegorka"
	post_init_icon_state = "gags_gorka"
	greyscale_config = /datum/greyscale_config/gorkas
	greyscale_config_worn = /datum/greyscale_config/gorkas/worn
	greyscale_config_worn_digi = /datum/greyscale_config/gorkas/worn/digi
	greyscale_colors = "#787878#252525"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/overalls
	name = "turtleneck with overalls"
	desc = "Overalls worn over a turtleneck. A combination providing comfort and coverage... or, at the least, the coverage."
	icon = 'modular_zubbers/icons/obj/clothing/under/greyscale.dmi'
	icon_state = "greyscaleoveralls"
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
	icon_state = "greyscaleoveralls_skirt"
	post_init_icon_state = "overalls_skirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/greyscale/playsuit
	name = "playsuit"
	desc = "For the love of the game."
	icon = 'modular_zubbers/icons/obj/clothing/under/greyscale.dmi'
	icon_state = "greyscaleplaysuit"
	post_init_icon_state = "playsuit"
	greyscale_config = /datum/greyscale_config/playsuit
	greyscale_config_worn = /datum/greyscale_config/playsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/playsuit/worn/digi
	greyscale_colors = "#787878#252525#CCCED1#787878"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE
