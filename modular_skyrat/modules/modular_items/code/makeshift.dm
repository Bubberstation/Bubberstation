//Tools that are made using makeshift item crafting

/obj/item/crowbar/makeshift
	name = "makeshift crowbar"
	desc = "A makeshift crowbar, flimsily constructed with miscellaneous parts. It's got a strong head that looks like it could be used for hammering."
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_crowbar"
	worn_icon_state = "crowbar"
	force = 2
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/screwdriver/makeshift
	name = "makeshift screwdriver"
	desc = "A makeshift screwdriver, flimsily made using cloth and some metal."
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_screwdriver"
	post_init_icon_state = null
	inside_belt_icon_state = null
	random_color = FALSE
	force = 1
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/weldingtool/makeshift
	name = "makeshift welder"
	desc = "A makeshift welder, flimsily constructed with miscellaneous parts."
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_welder"
	force = 1
	throwforce = 2
	toolspeed = 1.5
	w_class = WEIGHT_CLASS_NORMAL
	max_fuel = 10
	heat = 1800
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/wirecutters/makeshift
	name = "makeshift wirecutters"
	desc = "Makeshift wire cutters, flimsily constructed with miscellaneous parts."
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_cutters"
	random_color = FALSE
	force = 3
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/wrench/makeshift
	name = "makeshift wrench"
	desc = "A makeshift wrench, flimsily constructed with miscellaneous parts."
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "makeshift_wrench"
	force = 2
	throwforce = 2
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5)
