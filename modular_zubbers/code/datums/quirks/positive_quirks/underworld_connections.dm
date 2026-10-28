/datum/quirk/item_quirk/underworld_connections
	name = "Underworld Connections"
	desc = "You have made connections with the underbelly of crime and black markets. You carry a black market uplink."
	value = 2
	medical_record_text = "Subject has been known to harbour black market uplinks..."
	icon = FA_ICON_UPLOAD

/datum/quirk/item_quirk/underworld_connections/add_unique(client/client_source)
	give_item_to_holder(/obj/item/market_uplink/blackmarket, list(LOCATION_BACKPACK, LOCATION_HANDS))
