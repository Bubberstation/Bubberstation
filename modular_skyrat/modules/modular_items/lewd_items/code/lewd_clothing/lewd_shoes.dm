//heels item
/obj/item/clothing/shoes/latex_heels
	name = "latex heels"
	desc = "Lace up before use. It's pretty difficult to walk in these."
	icon_state = "latexheels"
	inhand_icon_state = null
	// We really need to find a way to condense there.
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes/latex_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/shoes/latex_heels/domina_heels
	name = "dominant heels"
	desc = "A pair of aesthetically pleasing heels."
	icon_state = "dominaheels"

/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	icon_state = "latexsocks"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'

// Ballet Heels
/obj/item/clothing/shoes/latex_heels/ballet_heels
	name = "ballet heels"
	desc = "A pair of ballet dancing heels."
	icon_state = "balletheels"
