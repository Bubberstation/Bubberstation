/datum/loadout_item/neck/heart_choker
	name = "Heart Collar"
	item_path = /obj/item/clothing/neck/lace_collar
	donator_only = TRUE

/datum/loadout_item/neck/ringbell
	name = "Ringing Bell Collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/ringbell

/datum/loadout_item/neck/gps
	name = "Tracking Collar"
	item_path = /obj/item/clothing/neck/kink_collar/locked/gps

/datum/loadout_item/neck/binary
	name = "Crow Feather Cloak"
	item_path = /obj/item/clothing/neck/binary

/datum/loadout_item/neck/security_cape
	name = "security cape"
	item_path = /obj/item/clothing/neck/security_cape
	restricted_roles = list(ALL_JOBS_SEC)
	can_be_reskinned = TRUE

/datum/loadout_item/neck/security_cape/armplate
	name = "security gauntlet"
	item_path = /obj/item/clothing/neck/security_cape/armplate
	restricted_roles = list(ALL_JOBS_SEC)
	can_be_reskinned = TRUE

/datum/loadout_item/neck/pauldron
	name = "lieutenant commander's pauldron"
	item_path = /obj/item/clothing/neck/pauldron
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/neck/pauldron/captain
	name = "commander's pauldron"
	item_path = /obj/item/clothing/neck/pauldron/captain
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/neck/pauldron/commander
	name = "captain's pauldron"
	item_path = /obj/item/clothing/neck/pauldron/commander
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/neck/imperial_cloak
	name = "Imperial Police Cloak"
	item_path = /obj/item/clothing/neck/cloak/colonial/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/neck/bunnypendant
	name = "Rabbit Pendant"
	item_path = /obj/item/clothing/neck/bunny_pendant

/datum/loadout_item/neck/scarf/pride
	name = "Pride Scarf"
	item_path = /obj/item/clothing/neck/scarf/pride
	can_be_reskinned = TRUE

/datum/loadout_item/neck/holobadge/hos
	name = "Head of Security's Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/neck/holobadge/warden
	name = "Warden's Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo/warden
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/neck/holobadge/detective
	name = "Detective's Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo/detective
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/neck/warrior_cape_worn
	name = "tattered cloak"
	item_path = /obj/item/clothing/neck/warrior_cape/loadout

/datum/loadout_item/neck/scarf/shadekin
	name = "Shadekin Fur Scarf"
	item_path = /obj/item/clothing/neck/scarf/shadekin
