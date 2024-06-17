/obj/item/clothing/head/helmet/space/beret
	name = "CentCom officer's beret"
	desc = "An armored beret commonly used by special operations officers. Uses advanced force field technology to protect the head from space."
	icon_state = "officerberet" // Bubberstation Edit
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi' // Bubberstation Edit
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi' // Bubberstation Edit
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	flags_inv = 0
	armor_type = /datum/armor/space_beret
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/datum/armor/space_beret
	melee = 80
	bullet = 80
	laser = 50
	energy = 60
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 15

/obj/item/clothing/suit/space/officer
	name = "CentCom officer's coat"
	desc = "An armored, space-proof coat used in special operations."
	icon_state = "centcom_coat"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi' // Bubberstation Edit
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi' // Bubberstation Edit
	inhand_icon_state = "centcom"
	blood_overlay_type = "coat"
	slowdown = 0
	flags_inv = 0
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	armor_type = /datum/armor/space_officer
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/space_officer
	melee = 80
	bullet = 80
	laser = 50
	energy = 60
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 15
