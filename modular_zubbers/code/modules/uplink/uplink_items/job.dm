
/datum/uplink_item/role_restricted/combat_clown_shoes
	name = "Combat Clown Shoes"
	desc = "Advanced clown shoes that protect the wearer and render them nearly immune to slipping on their own peels. They also squeak at 100% capacity."
	item = /obj/item/clothing/shoes/clown_shoes/combat
	cost = 3
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/weapon_kits/clownsword/clown
	category = /datum/uplink_category/role_restricted
	restricted_roles = list(JOB_CLOWN)
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/weapon_kits/bananashield/clown
	category = /datum/uplink_category/role_restricted
	restricted_roles = list(JOB_CLOWN)
	purchasable_from = UPLINK_TRAITORS
