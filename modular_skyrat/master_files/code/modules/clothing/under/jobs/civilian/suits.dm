
/obj/item/clothing/under/suit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi' //Anything that was in TG's suits.dmi, should be in our suits_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/suit/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/suits.dmi'

//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/skyrat. USE /obj/item/clothing/under/suit/skyrat FOR MODULAR SUITS

/*
*	RECOLORABLE
*/
/obj/item/clothing/under/suit/skyrat/recolorable
	name = "recolorable suit"
	desc = "A semi-formal suit, clean-cut with a matching vest and slacks."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/skyrat/recolorable"
	post_init_icon_state = "recolorable_suit"
	can_adjust = FALSE
	greyscale_config = /datum/greyscale_config/recolorable_suit
	greyscale_config_worn = /datum/greyscale_config/recolorable_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/recolorable_suit/worn/digi
	greyscale_colors = "#a99780#ffffff#6e2727#ffc500"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/suit/skyrat/recolorable/skirt
	name = "recolorable suitskirt"
	desc = "A semi-formal suitskirt, clean-cut with a matching vest and skirt."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/skyrat/recolorable/skirt"
	post_init_icon_state = "recolorable_suitskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/recolorable_suitskirt
	greyscale_config_worn = /datum/greyscale_config/recolorable_suitskirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/recolorable_suitskirt/worn/digi

/*
*	SUITS
*/
/obj/item/clothing/under/suit/skyrat/pencil
	name = "black pencilskirt"
	desc = "A clean white shirt with a tight-fitting black pencilskirt."
	icon_state = "black_pencil"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/skyrat/pencil/black_really
	name = "executive pencilskirt"
	desc = "A sleek suit with a tight-fitting black pencilskirt."
	icon_state = "really_black_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/charcoal
	name = "charcoal pencilskirt"
	desc = "A clean white shirt with a tight-fitting charcoal pencilskirt."
	icon_state = "charcoal_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/navy
	name = "navy pencilskirt"
	desc = "A clean white shirt with a tight-fitting navy-blue pencilskirt."
	icon_state = "navy_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/burgandy
	name = "burgandy pencilskirt"
	desc = "A clean white shirt with a tight-fitting burgandy-red pencilskirt."
	icon_state = "burgandy_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/checkered
	name = "checkered pencilskirt"
	desc = "A clean white shirt with a tight-fitting grey checkered pencilskirt."
	icon_state = "checkered_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/tan
	name = "tan pencilskirt"
	desc = "A clean white shirt with a tight-fitting tan pencilskirt."
	icon_state = "tan_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/green
	name = "green pencilskirt"
	desc = "A clean white shirt with a tight-fitting green pencilskirt."
	icon_state = "green_pencil"

/obj/item/clothing/under/suit/skyrat/scarface
	name = "cuban suit"
	desc = "A yayo coloured silk suit with a crimson shirt. You just know how to hide, how to lie. Me, I don't have that problem. Me, I always tell the truth. Even when I lie."
	icon_state = "scarface"

/obj/item/clothing/under/suit/skyrat/black_really_collared
	name = "wide-collared executive suit"
	desc = "A formal black suit with the collar worn wide, intended for the station's finest."
	icon_state = "really_black_suit_collar"

/obj/item/clothing/under/suit/skyrat/black_really_collared/skirt
	name = "wide-collared executive suitskirt"
	desc = "A formal black suit with the collar worn wide, intended for the station's finest."
	icon_state = "really_black_suit_skirt_collar"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/skyrat/inferno
	name = "inferno suit"
	desc = "Stylish enough to impress the devil."
	icon_state = "lucifer"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/under/suit/skyrat/inferno/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/inferno_suit)

/datum/atom_skin/inferno_suit
	abstract_type = /datum/atom_skin/inferno_suit

/datum/atom_skin/inferno_suit/pride
	preview_name = "Pride"
	new_icon_state = "lucifer"

/datum/atom_skin/inferno_suit/wrath
	preview_name = "Wrath"
	new_icon_state = "justice"

/datum/atom_skin/inferno_suit/gluttony
	preview_name = "Gluttony"
	new_icon_state = "malina"

/datum/atom_skin/inferno_suit/envy
	preview_name = "Envy"
	new_icon_state = "zdara"

/datum/atom_skin/inferno_suit/vanity
	preview_name = "Vanity"
	new_icon_state = "cereberus"

/obj/item/clothing/under/suit/skyrat/inferno/skirt
	name = "inferno suitskirt"
	icon_state = "modeus"
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/under/suit/skyrat/inferno/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/inferno_suitskirt)

/datum/atom_skin/inferno_suitskirt
	abstract_type = /datum/atom_skin/inferno_suitskirt

/datum/atom_skin/inferno_suitskirt/lust
	preview_name = "Lust"
	new_icon_state = "modeus"

/datum/atom_skin/inferno_suitskirt/sloth
	preview_name = "Sloth"
	new_icon_state = "pande"

/obj/item/clothing/under/suit/skyrat/inferno/beeze
	name = "designer inferno suit"
	desc = "A fancy tail-coated suit with a fluffy bow emblazoned on the chest, complete with an NT pin."
	icon_state = "beeze"
	obj_flags = null

/obj/item/clothing/under/suit/skyrat/inferno/beeze/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/suit/skyrat/helltaker
	name = "red shirt with white pants"
	desc = "No time. Busy gathering girls."
	icon_state = "helltaker"

/obj/item/clothing/under/suit/skyrat/helltaker/skirt
	name = "red shirt with white skirt"
	desc = "No time. Busy gathering boys."
	icon_state = "helltakerskirt"
