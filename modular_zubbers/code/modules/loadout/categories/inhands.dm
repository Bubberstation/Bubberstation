/datum/loadout_item/inhand/unioncard //sprites by Scuhf_
	name = "Worker's Union Card"
	item_path = /obj/item/card/cardboard/unioncard
	donator_only = TRUE //donator item for arandomhyena

/datum/loadout_item/inhand/challengecoin
	name = "SAC Challenge Coin"
	item_path = /obj/item/coin/challenge

/datum/loadout_item/inhand/pet/mrfluff_mothroach
	name = "Mr. Fluff"
	item_path = /obj/item/clothing/head/mob_holder/pet/donator/centralsmith

/datum/loadout_item/inhand/saddlebags
	name = "saddlebags"
	item_path = /obj/item/storage/backpack/saddlebags

/datum/loadout_item/inhand/saddle // these should be in the other category but apparantly those are "pocket" loadout items so idk?
	name = "riding saddle (leather)"
	item_path = /obj/item/riding_saddle/leather

/datum/loadout_item/inhand/saddle_peacekeeper
	name = "riding saddle (peacekeeper)"
	item_path = /obj/item/riding_saddle/leather/peacekeeper

	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER, JOB_HEAD_OF_SECURITY)
