/obj/item/clothing/gloves/ring/fire_resistance
	name = "gold ring of fire resistance"
	desc = "A bright golden ring, affixed with an ruby stone."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	icon_state = "fire_resist"

	worn_icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_worn.dmi'
	worn_icon_state = "fire_resist"

	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)

	armor_type = /datum/armor/ring_of_fire_resistance

	resistance_flags = FIRE_PROOF

/datum/armor/ring_of_fire_resistance
	melee = 0
	bullet = 0
	laser = 0
	energy = 0
	bomb = 0
	bio = 0
	fire = 75
	acid = 0


