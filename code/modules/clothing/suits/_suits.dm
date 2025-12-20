/obj/item/clothing/suit
	name = "suit"
	icon = 'icons/obj/clothing/suits/default.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/suits_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/suits_righthand.dmi'
	abstract_type = /obj/item/clothing/suit
	var/fire_resist = T0C+100
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/tank/jetpack/captain,
		/obj/item/storage/belt/holster,
		)
	armor_type = /datum/armor/none
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'
	slot_flags = ITEM_SLOT_OCLOTHING
	var/blood_overlay_type = "suit"
	limb_integrity = 0 // disabled for most exo-suits

/obj/item/clothing/suit/worn_overlays(mutable_appearance/standing, isinhands = FALSE, file2use = null, mutant_styles = NONE) // SKYRAT EDIT CHANGE - TAURS AND TESHIS - ORIGINAL: /obj/item/clothing/suit/worn_overlays(mutable_appearance/standing, isinhands = FALSE)
	. = ..()
	if(isinhands)
		return

	if(damaged_clothes)
		//SKYRAT EDIT CHANGE BEGIN
		//. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]") //ORIGINAL
		var/damagefile2use = (mutant_styles & STYLE_TAUR_ALL) ? 'modular_skyrat/master_files/icons/mob/64x32_item_damage.dmi' : 'icons/effects/item_damage.dmi'
		. += mutable_appearance(damagefile2use, "damaged[blood_overlay_type]")
		//SKYRAT EDIT CHANGE END
	if(GET_ATOM_BLOOD_DNA_LENGTH(src))
		//SKYRAT EDIT CHANGE BEGIN
		//. += mutable_appearance('icons/effects/blood.dmi', "[blood_overlay_type]blood") //ORIGINAL
		var/bloodfile2use = (mutant_styles & STYLE_TAUR_ALL) ? 'modular_skyrat/master_files/icons/mob/64x32_blood.dmi' : 'icons/effects/blood.dmi'
		. += mutable_appearance(bloodfile2use, "[blood_overlay_type]blood")
		//SKYRAT EDIT CHANGE END

	var/mob/living/carbon/human/wearer = loc
	if(!ishuman(wearer) || !wearer.w_uniform)
		return
	var/obj/item/clothing/under/undershirt = wearer.w_uniform
	if(!istype(undershirt) || !LAZYLEN(undershirt.attached_accessories))
		return

	var/obj/item/clothing/accessory/displayed = undershirt.attached_accessories[1]
	if(displayed.above_suit && undershirt.accessory_overlay)
		. += undershirt.accessory_overlay

/obj/item/clothing/suit/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands = FALSE, icon_file)
	. = ..()
	if (isinhands)
		return
	var/blood_overlay = get_blood_overlay(blood_overlay_type)
	if (blood_overlay)
		. += blood_overlay

/obj/item/clothing/suit/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_worn_oversuit()

/obj/item/clothing/suit/generate_digitigrade_icons(icon/base_icon, greyscale_colors)
	var/icon/legs = icon(SSgreyscale.GetColoredIconByType(/datum/greyscale_config/digitigrade, greyscale_colors), "oversuit_worn")
	return replace_icon_legs(base_icon, legs)
