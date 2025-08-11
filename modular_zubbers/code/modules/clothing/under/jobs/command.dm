/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper
	desc = "It's a revealing blue stripper outfit with some gold markings befitting either the Head of Personnel or Captain. Technically unsactioned by Nanotrasen, Now equipped with Pycroft Polycromatic pigment tech."
	name = "command stripper uniform"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper"
	post_init_icon_state = "cso"
	greyscale_config = /datum/greyscale_config/cso
	greyscale_config_worn = /datum/greyscale_config/cso/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	greyscale_colors = "#081027#41579a#c06822"

	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/nanotrasen_consultant/stripper
	desc = "It's a green stripper outfit with some gold markings denoting the rank of \"Nanotrasen Consultant\". Technically unsactioned by Nanotrasen, Now equipped with Pycroft Polycromatic pigment tech."
	name = "consultant's stripper uniform"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/nanotrasen_consultant/stripper"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	greyscale_config = /datum/greyscale_config/cso
	greyscale_config_worn = /datum/greyscale_config/cso/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	post_init_icon_state = "cso"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	greyscale_colors = "#081027#46b946#e6b917"

	can_adjust = FALSE

/obj/item/clothing/under/rank/nanotrasen_consultant/stripper/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)
