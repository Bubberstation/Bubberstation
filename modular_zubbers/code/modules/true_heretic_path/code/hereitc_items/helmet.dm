/obj/item/clothing/head/helmet/heretic_resistance
	name = "leather rimmed cap"
	desc = "A strange leather reinforced cap with gold trimmings. The leather material glows faintly."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	icon_state = "rim"

	worn_icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_worn.dmi'
	worn_icon_state = "rim"

	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)

	armor_type = /datum/armor/heretic_resistance

/datum/armor/heretic_resistance
	melee = 0
	bullet = 0
	laser = 40
	energy = 40
	bomb = 40
	bio = 40
	fire = 40
	acid = 40
