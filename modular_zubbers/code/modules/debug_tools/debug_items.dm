/obj/item/clothing/glasses/debug/architector_glasses
	name = "Architector glasses"
	desc = "High-tech glasses with many of special abilites."
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
	resistance_flags = INDESTRUCTIBLE

	actions_types = list(
		/datum/action/cooldown/fly,
		/datum/action/cooldown/noclip,
		/datum/action/item_action/chameleon/change/glasses/no_preset
	)
