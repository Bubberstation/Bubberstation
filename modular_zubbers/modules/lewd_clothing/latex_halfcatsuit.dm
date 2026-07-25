/obj/item/clothing/under/misc/latex_halfcatsuit
	name = "latex half-catsuit"
	desc = "A shiny uniform that fits snugly to the skin. The legs have been cut off this one."
	icon_state = "latex_halfcatsuit_female"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	inhand_icon_state = "latex_catsuit"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg'
	worn_icon_taur_big = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	strip_delay = 80
	var/mutable_appearance/breasts_overlay
	var/mutable_appearance/breasts_icon_overlay

//this fragment of code makes unequipping not instant
/obj/item/clothing/under/misc/latex_halfcatsuit/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/affected_human = user
		if(src == affected_human.w_uniform)
			if(!do_after(affected_human, 6 SECONDS, target = src))
				return
	. = ..()

// //some gender identification magic
/obj/item/clothing/under/misc/latex_halfcatsuit/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	var/obj/item/organ/genital/breasts/affected_breasts = affected_human.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(src == affected_human.w_uniform)
		if(affected_mob.gender == FEMALE)
			icon_state = "latex_halfcatsuit_female"
		else
			icon_state = "latex_halfcatsuit_male"

		affected_mob.update_worn_undersuit()

	breasts_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi', "none")

	//Breasts overlay for catsuit
	if(affected_breasts && affected_breasts.genital_size >= 6)
		switch(affected_breasts.genital_type)
			if("pair")
				breasts_overlay.icon_state = "breasts_double"
				breasts_icon_overlay.icon_state = "iconbreasts_double"
				accessory_overlay = breasts_overlay
				add_overlay(breasts_icon_overlay)
			if("quad")
				breasts_overlay.icon_state = "breasts_quad"
				breasts_icon_overlay.icon_state = "iconbreasts_quad"
				accessory_overlay = breasts_overlay
				add_overlay(breasts_icon_overlay)
			if("sextuple")
				breasts_overlay.icon_state = "breasts_sextuple"
				breasts_icon_overlay.icon_state = "iconbreasts_sextuple"
				accessory_overlay = breasts_overlay
				add_overlay(breasts_icon_overlay)

	update_overlays()

	affected_human.regenerate_icons()

/obj/item/clothing/under/misc/latex_halfcatsuit/dropped(mob/living/affected_mob)
	. = ..()
	accessory_overlay = null
	breasts_overlay.icon_state = "none"
	cut_overlay(breasts_icon_overlay)
	breasts_icon_overlay.icon_state = "none"

//Plug to bypass the bug with instant suit equip/drop
/obj/item/clothing/under/misc/latex_halfcatsuit/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	return

/obj/item/clothing/under/misc/latex_halfcatsuit/Initialize(mapload)
	. = ..()
	breasts_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi', "none", ABOVE_MOB_LAYER)
	breasts_overlay.icon_state = ORGAN_SLOT_BREASTS
	breasts_icon_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi', "none")
	breasts_icon_overlay.icon_state = ORGAN_SLOT_BREASTS
