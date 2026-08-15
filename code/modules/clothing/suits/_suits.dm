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

/obj/item/clothing/suit/worn_overlays(mutable_appearance/standing, isinhands = FALSE, icon_file, bodyshape = NONE)
	. = ..()
	if(isinhands)
		return

	//BUBBER EDIT BEGIN - Species specific damage states.
	var/mob/living/carbon/human/wearer = loc
	if(damaged_clothes)
		//. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]") //ORIGINAL
		//todo: the taur icon doesn't exist anymore. Needs replacement.
		var/icon/damage_icon_file = (bodyshape & STYLE_TAUR_ALL) ? 'modular_skyrat/master_files/icons/mob/64x32_item_damage.dmi' : 'icons/effects/item_damage.dmi'
		var/damage_icon_state = "damaged[blood_overlay_type]"
		if(ishuman(wearer) && icon_exists('modular_zubbers/icons/effects/item_damage_species.dmi', "damaged[blood_overlay_type]_[wearer.dna.species.id]"))
			damage_icon_file = 'modular_zubbers/icons/effects/item_damage_species.dmi'
			damage_icon_state  = "damaged[blood_overlay_type]_[wearer.dna.species.id]"

		. += mutable_appearance(damage_icon_file, damage_icon_state)
	//BUBBER EDIT END

	if(!ishuman(wearer) || !wearer.w_uniform)
		return
	var/obj/item/clothing/under/undershirt = wearer.w_uniform
	if(!istype(undershirt))
		return
	for(var/obj/item/clothing/accessory/accessory as anything in undershirt.attached_accessories)
		if (accessory.above_suit)
			. += accessory.generate_accessory_overlay(undershirt)

/obj/item/clothing/suit/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands = FALSE, icon_file, bodyshape = NONE)
	. = ..()
	if (isinhands)
		return
	var/blood_overlay = get_blood_overlay(blood_overlay_type, bodyshape)
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
