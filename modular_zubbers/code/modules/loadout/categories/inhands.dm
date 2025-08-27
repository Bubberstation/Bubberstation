/datum/loadout_item/inhand/unioncard //sprites by Scuhf_
	name = "Worker's Union Card"
	item_path = /obj/item/card/cardboard/unioncard
	donator_only = TRUE //donator item for arandomhyena

/datum/loadout_item/inhand/challengecoin
	name = "SAC Challenge Coin"
	item_path = /obj/item/coin/challenge

/datum/loadout_item/inhand/pet/mrfluff_mothroach
	name = "Mr. Fluff"
	item_path = /obj/item/mob_holder/pet/donator/centralsmith

/datum/loadout_item/inhand/saddlebags
	name = "saddlebags"
	item_path = /obj/item/storage/backpack/saddlebags

/datum/loadout_item/inhand/saddle // these should be in the other category but apparantly those are "pocket" loadout items so idk?
	name = "riding saddle (leather)"
	item_path = /obj/item/riding_saddle/leather

/datum/loadout_item/inhand/saddle_peacekeeper
	name = "riding saddle (peacekeeper)"
	item_path = /obj/item/riding_saddle/leather/peacekeeper
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/inhand/wheelchair
	name = "folded wheelchair"
	item_path = /obj/item/wheelchair

// FRONTIER CLOTHING

/datum/loadout_item/inhand/frontier_backpack
	name = "Frontier backpack"
	item_path = /obj/item/storage/backpack/industrial/frontier_colonist

/datum/loadout_item/inhand/frontier_satchel
	name = "Frontier satchel"
	item_path = /obj/item/storage/backpack/industrial/frontier_colonist/satchel

/datum/loadout_item/inhand/frontier_messenger
	name = "Frontier messenger bag"
	item_path = /obj/item/storage/backpack/industrial/frontier_colonist/messenger
