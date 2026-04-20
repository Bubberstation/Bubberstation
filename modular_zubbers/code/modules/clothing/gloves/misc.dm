/obj/item/clothing/gloves/misc/diver //Donor item for patriot210
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	name = "black divers gloves"
	desc = "An old pair of gloves used by a now-defunct mining coalition."
	icon_state = "diver"
	worn_icon_state = "diver"

/obj/item/clothing/gloves/latex/allamerican
	name = "all-american diner latex gloves"
	desc = "A sterile pair of gloves for preparing food without the risk of contamination! The old fashion american style."
	icon_state = "latex_black"
	worn_icon_state = "latex_black"

//Cat Gloves seemingly by Taomayo of MonkeStation

/obj/item/clothing/gloves/cat
	desc = "hewwo everynyaan!!"
	name = "cat gloves"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/cat"
	post_init_icon_state = "catgloves"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors =  "#ffffff#FFC0CB"
	greyscale_config_worn = /datum/greyscale_config/catgloves/worn
	greyscale_config = /datum/greyscale_config/catgloves
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null


//Metrocop Gloves by ... Dun dun dun, HL13 station.
/obj/item/clothing/gloves/color/black/security/metrocop
	name = "metrocop gloves"
	desc = "Now you can pick up that can! Uses advanced GigaSlop brand Matrixes to allow alternative varients!"
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	icon_state = "civilprotection"

/obj/item/clothing/gloves/color/black/security/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop_gloves)

/datum/atom_skin/metrocop_gloves
	abstract_type = /datum/atom_skin/metrocop_gloves

/datum/atom_skin/metrocop_gloves/metro_cop
	preview_name = "Metro Cop"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop_gloves/overwatch
	preview_name = "Overwatch"
	new_icon_state = "overwatch"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/gloves/color/black/security/snake
	name = "stealth gloves"
	desc = "We will forsake our countries."
	icon = 'modular_zubbers/icons/obj/clothing/gloves/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/gloves/gloves.dmi'
	icon_state = "snake"

/obj/item/clothing/gloves/color/black/security/snake/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/gloves/bubber/snake
	name = "big boss' gloves"
	desc = "We will forsake our countries."
	icon_state = "snake"
