/obj/item/clothing/under/dress/bubber
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/skirts_dresses.dmi'

/obj/item/clothing/under/dress/bubber/strapped
	name = "formal evening gown"
	desc = "A richly made dress of quality fabrics, but not much of them."
	icon_state = "dress_strapped"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/dress/miniskirt
	name = "miniskirt"
	desc = "This skirt is quite small, even by skirt standards."
	icon_state = "miniskirt"
	greyscale_colors = "#39393f#ffffff#ffffff"
	greyscale_config = /datum/greyscale_config/miniskirt
	greyscale_config_worn = /datum/greyscale_config/miniskirt_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	can_adjust = TRUE
