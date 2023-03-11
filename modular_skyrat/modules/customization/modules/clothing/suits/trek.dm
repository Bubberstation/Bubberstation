//Trek Jacket(s?)
/obj/item/clothing/suit/fedcoat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "Federation uniform jacket"
	desc = "A uniform jacket from the United Federation. Set phasers to awesome."
	icon_state = "fedcoat"
	inhand_icon_state = "coatsecurity"
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
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/fedcoat/medsci
	icon_state = "fedblue"
	inhand_icon_state = "coatmedical"

/obj/item/clothing/suit/fedcoat/eng
	icon_state = "fedeng"
	inhand_icon_state = "coatengineer"

/obj/item/clothing/suit/fedcoat/capt
	icon_state = "fedcapt"
	inhand_icon_state = "coatcaptain"

//fedcoat but modern
/obj/item/clothing/suit/fedcoat/modern
	name = "modern Federation uniform jacket"
	desc = "A modern uniform jacket from the United Federation."
	icon_state = "fedmodern"
	inhand_icon_state = "coatsecurity"

/obj/item/clothing/suit/fedcoat/modern/medsci
	name = "modern medsci Federation jacket"
	icon_state = "fedmodernblue"
	inhand_icon_state = "coatmedical"

/obj/item/clothing/suit/fedcoat/modern/eng
	name = "modern engineering Federation jacket"
	icon_state = "fedmoderneng"
	inhand_icon_state = "coatengineer"

/obj/item/clothing/suit/fedcoat/modern/sec
	name = "modern security Federation jacket"
	icon_state = "fedmodernsec"
	inhand_icon_state = "coatcaptain"
