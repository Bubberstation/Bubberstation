/obj/item/clothing/under/stripper_outfit
	name = "stripper outfit"
	desc = "An item of clothing that leaves little to the imagination."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE
	icon_state = "stripper_cyan"
	inhand_icon_state = "b_suit"
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/under/stripper_outfit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/stripper_outfit)

/datum/atom_skin/stripper_outfit
	abstract_type = /datum/atom_skin/stripper_outfit

/datum/atom_skin/stripper_outfit/cyan
	preview_name = "Cyan"
	new_icon_state = "stripper_cyan"

/datum/atom_skin/stripper_outfit/yellow
	preview_name = "Yellow"
	new_icon_state = "stripper_yellow"

/datum/atom_skin/stripper_outfit/green
	preview_name = "Green"
	new_icon_state = "stripper_green"

/datum/atom_skin/stripper_outfit/red
	preview_name = "Red"
	new_icon_state = "stripper_red"

/datum/atom_skin/stripper_outfit/latex
	preview_name = "Latex"
	new_icon_state = "stripper_latex"

/datum/atom_skin/stripper_outfit/orange
	preview_name = "Orange"
	new_icon_state = "stripper_orange"

/datum/atom_skin/stripper_outfit/white
	preview_name = "White"
	new_icon_state = "stripper_white"

/datum/atom_skin/stripper_outfit/purple
	preview_name = "Purple"
	new_icon_state = "stripper_purple"

/datum/atom_skin/stripper_outfit/black
	preview_name = "Black"
	new_icon_state = "stripper_black"

/datum/atom_skin/stripper_outfit/black_teal
	preview_name = "Black-teal"
	new_icon_state = "stripper_tealblack"
