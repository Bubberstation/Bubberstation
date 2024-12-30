/*
*	BONES
*/

/obj/item/toy/fluff/bone_greyscale
	name = "colorable bone"
	desc = "A colorable chew bone. Nothing like a good bone to chew on."
	icon_state = "poly_bone"
	worn_icon_state = "poly_bone"
	throw_range = 7
	icon = 'modular_zzplurt/icons/obj/barkbox_fluff.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/fluff_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/fluff_righthand.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/mouthfluff.dmi'

	w_class = WEIGHT_CLASS_SMALL
	greyscale_colors = "#FFFFFF"
	greyscale_config = /datum/greyscale_config/bone
	greyscale_config_worn = /datum/greyscale_config/bone/worn

/datum/greyscale_config/bone
	name = "Bone"
	icon_file = 'modular_zzplurt/icons/obj/barkbox_fluff.dmi'
	json_config = 'modular_zzplurt/code/datums/greyscale/json_configs/bone.json'

/datum/greyscale_config/bone/worn
	name = "Bone (Worn)"
	icon_file = 'modular_zzplurt/icons/mob/mouthfluff.dmi'

/obj/item/toy/fluff/bone_greyscale/red
	greyscale_colors = "#FF4C00"

/obj/item/toy/fluff/bone_greyscale/yellow
	greyscale_colors = "#FFCC00"

/obj/item/toy/fluff/bone_greyscale/green
	greyscale_colors = "#99FF00"

/obj/item/toy/fluff/bone_greyscale/cyan
	greyscale_colors = "#00FFB2"

/obj/item/toy/fluff/bone_greyscale/blue
	greyscale_colors = "#007FFF"

/obj/item/toy/fluff/bone_greyscale/purple
	greyscale_colors = "#CC00FF"

/obj/item/toy/fluff/bone_greyscale/squeak
	name = "colorable bone"
	desc = "A colorable chew bone. Makes a small squeak when squeezed."

/obj/item/toy/fluff/bone_greyscale/squeak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak)

/*
*	FRISBEE
*/

/obj/item/toy/fluff/frisbee_greyscale
	name = "colorable frisbee"
	desc = "A colorable frisbee. Warning: May induce shock."
	icon_state = "poly_frisbee"
	worn_icon_state = "poly_frisbee"
	throw_range = 14
	icon = 'modular_zzplurt/icons/obj/barkbox_fluff.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/fluff_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/fluff_righthand.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/mouthfluff.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	greyscale_colors = "#CCFF00#FFFFFF"
	greyscale_config = /datum/greyscale_config/frisbee
	greyscale_config_worn = /datum/greyscale_config/frisbee/worn

/datum/greyscale_config/frisbee
	name = "Frisbee"
	icon_file = 'modular_zzplurt/icons/obj/barkbox_fluff.dmi'
	json_config = 'modular_zzplurt/code/datums/greyscale/json_configs/frisbee.json'

/datum/greyscale_config/frisbee/worn
	name = "Frisbee (Worn)"
	icon_file = 'modular_zzplurt/icons/mob/mouthfluff.dmi'

/obj/item/toy/fluff/frisbee_greyscale/red
	greyscale_colors = "#FF4C00#FFFFFF"

/obj/item/toy/fluff/frisbee_greyscale/yellow
	greyscale_colors = "#FFCC00#FFFFFF"

/obj/item/toy/fluff/frisbee_greyscale/green
	greyscale_colors = "#99FF00#FFFFFF"

/obj/item/toy/fluff/frisbee_greyscale/cyan
	greyscale_colors = "#00FFB2#FFFFFF"

/obj/item/toy/fluff/frisbee_greyscale/blue
	greyscale_colors = "#007FFF#FFFFFF"

/obj/item/toy/fluff/frisbee_greyscale/purple
	greyscale_colors = "#CC00FF#FFFFFF"
