/obj/item/clothing/suit/misc/holographic //Donator item for Blovy. Sprited by Casey/Keila.
	icon = 'modular_zubbers/icons/obj/clothing/suits/misc.dmi'
	icon_state = "holographic"
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/misc.dmi' //Works like a gear harness but keeps private parts hidden for the suit slot.
	worn_icon_state = "holographic"
	name = "Holographic Suit V4000"
	desc = "The Holographic Suit V4000 has multiple layers designed specifically to refract and bend light waves around the user, effectively making them transparent to the naked eye. The suit comes equipped with advanced sensors that constantly scan its surroundings, adjusting its holographic projection accordingly. As soon as you put on the suit it calibrates itself based on your unique body shape and size."
	attachment_slot_override = CHEST
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/misc/suit_harness
	name = "suit harness"
	desc = "A near-concealed harness meant for going over uniforms. Or lack thereof."
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	icon_state = "suit_harness"
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	worn_icon_state = "suit_harness"
	inhand_icon_state = null
	body_parts_covered = 0x0
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	attachment_slot_override = CHEST

	//Allowed is same as jackets.
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		/obj/item/storage/belt/holster,
	)

/obj/item/clothing/suit/misc/allamerican
	name = "all-american diner manager's vest"
	desc = "A soft fabric vest, with a nametag of the employee on it. It says, MANAGER on the back, making you obvious for the Karens who just NEED your attention."
	icon = 'modular_zubbers/icons/obj/clothing/suits/misc.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/misc.dmi'
	icon_state = "allamerican"
	worn_icon_state = "allamerican"
	attachment_slot_override = CHEST
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		/obj/item/storage/belt/holster,
	)
