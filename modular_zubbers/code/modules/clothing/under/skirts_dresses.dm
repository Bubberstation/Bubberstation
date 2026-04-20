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
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/miniskirt"
	post_init_icon_state = "miniskirt"
	greyscale_colors = "#39393f#ffffff#ffffff"
	greyscale_config = /datum/greyscale_config/miniskirt
	greyscale_config_worn = /datum/greyscale_config/miniskirt_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	can_adjust = TRUE
	body_parts_covered = GROIN | LEGS

/obj/item/clothing/under/dress/bubber/midnight_gown
	name = "midnight gown"
	desc = "A seductive gown purpose tailored to show off one's legs."
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/bubber/midnight_gown"
	post_init_icon_state = "midnight_right"
	greyscale_config = /datum/greyscale_config/midnight_gown
	greyscale_config_worn = /datum/greyscale_config/midnight_gown/worn
	greyscale_config_worn_digi = /datum/greyscale_config/midnight_gown/worn/digi
	greyscale_colors = "#1D253B"
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = FALSE
	alternate_worn_layer = ABOVE_SHOES_LAYER
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/dress/bubber/midnight_gown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/midnight_gown)

/datum/atom_skin/midnight_gown
	abstract_type = /datum/atom_skin/midnight_gown
	greyscale_item_path = /obj/item/clothing/under/dress/bubber/midnight_gown

/datum/atom_skin/midnight_gown/right
	preview_name = "Right"
	new_icon_state = "midnight_right"

/datum/atom_skin/midnight_gown/left
	preview_name = "Left"
	new_icon_state = "midnight_left"

/datum/atom_skin/midnight_gown/middle
	preview_name = "Middle"
	new_icon_state = "midnight_mid"

/datum/atom_skin/giant_scarf
	abstract_type = /datum/atom_skin/giant_scarf
	greyscale_item_path = /obj/item/clothing/under/dress/bubber/giant_scarf

/datum/atom_skin/giant_scarf/giant_scarf
	preview_name = "Plain"
	new_icon_state = "giant_scarf"

/datum/atom_skin/giant_scarf/giant_scarf_crystal
	preview_name = "Crystal"
	new_icon_state = "giant_scarf_crystal"

/datum/atom_skin/giant_scarf/giant_scarf_stripe
	preview_name = "Stripe"
	new_icon_state = "giant_scarf_stripe"

/datum/atom_skin/giant_scarf/giant_scarf_twotone
	preview_name = "Two-tone"
	new_icon_state = "giant_scarf_twotone"

/datum/atom_skin/giant_scarf/giant_scarf_arrow
	preview_name = "Arrow"
	new_icon_state = "giant_scarf_arrow"

/datum/atom_skin/giant_scarf/giant_scarf_fancy
	preview_name = "Fancy"
	new_icon_state = "giant_scarf_fancy"

/datum/atom_skin/giant_scarf/giant_scarf_sepharim
	preview_name = "Sepharim"
	new_icon_state = "giant_scarf_sepharim"

/datum/atom_skin/giant_scarf/giant_scarf_bones
	preview_name = "Bones"
	new_icon_state = "giant_scarf_bones"

/datum/atom_skin/giant_scarf/giant_scarf_lines
	preview_name = "Lines"
	new_icon_state = "giant_scarf_lines"

/datum/atom_skin/giant_scarf/giant_scarf_runes
	preview_name = "Runes"
	new_icon_state = "giant_scarf_runes"

/datum/atom_skin/giant_scarf/giant_scarf_heart
	preview_name = "Heart"
	new_icon_state = "giant_scarf_heart"

/obj/item/clothing/under/dress/bubber/giant_scarf
	name = "giant scarf"
	desc = "An absurdly massive scarf, worn as the main article of clothing over the body. Ironically, not very suitable for the cold."
	body_parts_covered = CHEST|GROIN|LEGS
	icon = 'icons/map_icons/clothing/under/dress.dmi'
	icon_state = "/obj/item/clothing/under/dress/bubber/giant_scarf"
	post_init_icon_state = "giant_scarf"
	greyscale_config = /datum/greyscale_config/giant_scarf
	greyscale_config_worn = /datum/greyscale_config/giant_scarf/worn
	greyscale_colors = "#EEEEEE#bbbbbb"
	female_sprite_flags = NO_FEMALE_UNIFORM
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/bubber/giant_scarf/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/giant_scarf, initial_skin = "Plain")
