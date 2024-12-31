/obj/item/clothing/suit/baroness
	name = "Baroness Dress"
	desc = "This dress is stained red due to the bloody history of its previous owner"
	icon = 'modular_zzplurt/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/suit.dmi'
	icon_state = "baroness"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	flags_inv = HIDESHOES|HIDEUNDERWEAR

/obj/item/clothing/suit/baroness/ladyballat
	name = "Green Ball Dress"
	desc = "This dress looks a bit like the one an estranged aunt would wear."
	icon_state = "ladyballat"

/obj/item/clothing/suit/invisijacket
	name = "invisifiber jacket"
	desc = "A jacket made of transparent fibers, often used with reinforcement kits."
	icon = 'modular_zzplurt/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/suit.dmi'
	icon_state = "jacket_transparent"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//DS9
/obj/item/clothing/suit/storage/trek/ds9
	name = "Padded Overcoat"
	desc = "The overcoat worn by all officers of the 2380s."
	icon = 'modular_zzplurt/icons/obj/clothing/trek_item_icon.dmi'
	icon_state = "trek_ds9_coat"
	worn_icon = 'modular_zzplurt/icons/mob/clothing/trek_mob_icon.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(
		/obj/item/flashlight,
		/obj/item/analyzer,
		/obj/item/radio,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/reagent_containers/hypospray,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/restraints/handcuffs,
		/obj/item/hypospray
		)
	armor_type = /datum/armor/none

/obj/item/clothing/suit/storage/trek/ds9/admiral
	name = "Admiral Overcoat"
	desc = "Admirality specialty coat to keep flag officers fashionable and protected."
	icon_state = "trek_ds9_coat_adm"
	armor_type = /datum/armor/admiral_coat

/datum/armor/admiral_coat
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 50
	bio = 50
	fire = 50
	acid = 50

//For general use
/obj/item/clothing/suit/storage/fluff/fedcoat
	name = "Federation Uniform Jacket"
	desc = "A uniform jacket from the United Federation. Set phasers to awesome."
	icon = 'modular_zzplurt/icons/obj/clothing/trek_item_icon.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/trek_mob_icon.dmi'
	icon_state = "fedcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/analyzer,
		/obj/item/radio,
		/obj/item/gun,
		/obj/item/melee/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/reagent_containers/hypospray,
		/obj/item/hypospray,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/storage/pill_bottle,
		/obj/item/taperecorder)
	armor_type = /datum/armor/none
	var/unbuttoned = FALSE

/obj/item/clothing/suit/storage/fluff/fedcoat/verb/toggle()
	set name = "Toggle coat buttons"
	set category = "Object"
	set src in usr

	var/mob/living/L = usr
	if(!istype(L) || L.stat != CONSCIOUS)
		return FALSE

	switch(unbuttoned)
		if(FALSE)
			icon_state = "[initial(icon_state)]_open"
			unbuttoned = TRUE
			to_chat(usr,"You unbutton the coat.")
		if(TRUE)
			icon_state = "[initial(icon_state)]"
			unbuttoned = FALSE
			to_chat(usr,"You button up the coat.")

	usr.update_worn_oversuit()

//Variants
/obj/item/clothing/suit/storage/fluff/fedcoat/medsci
	icon_state = "fedblue"

/obj/item/clothing/suit/storage/fluff/fedcoat/eng
	icon_state = "fedeng"

/obj/item/clothing/suit/storage/fluff/fedcoat/capt
	icon_state = "fedcapt"

//"modern" ones for fancy

/obj/item/clothing/suit/storage/fluff/modernfedcoat
	name = "Modern Federation Uniform Jacket"
	desc = "A modern uniform jacket from the United Federation."
	icon = 'modular_zzplurt/icons/obj/clothing/trek_item_icon.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/trek_mob_icon.dmi'
	icon_state = "fedmodern"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/flashlight,
		/obj/item/analyzer,
		/obj/item/radio,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/reagent_containers/hypospray,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/restraints/handcuffs,
		/obj/item/hypospray
		)
	armor_type = /datum/armor/none

//Variants
/obj/item/clothing/suit/storage/fluff/modernfedcoat/medsci
	icon_state = "fedmodernblue"

/obj/item/clothing/suit/storage/fluff/modernfedcoat/eng
	icon_state = "fedmoderneng"

/obj/item/clothing/suit/storage/fluff/modernfedcoat/sec
	icon_state = "fedmodernsec"
