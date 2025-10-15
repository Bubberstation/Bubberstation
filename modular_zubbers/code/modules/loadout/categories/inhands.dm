//Title Capitalization for names please!!!



/datum/loadout_item/inhand/cane
	name = "Cane"
	item_path = /obj/item/cane

/datum/loadout_item/inhand/cane/crutch
	name = "Crutch"
	item_path = /obj/item/cane/crutch

/datum/loadout_item/inhand/briefcase
	name = "Briefcase"
	item_path = /obj/item/storage/briefcase

/datum/loadout_item/inhand/briefcase_secure
	name = "Secure Briefcase"
	item_path = /obj/item/storage/briefcase/secure

/datum/loadout_item/inhand/skub
	name = "Skub"
	item_path = /obj/item/skub

/datum/loadout_item/inhand/skateboard
	name = "Skateboard"
	item_path = /obj/item/melee/skateboard

/datum/loadout_item/inhand/emergency_toolbox
	name = "Emergency Toolbox"
	item_path = /obj/item/storage/toolbox/emergency
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/inhand/bouquet_mixed
	name = "Mixed Bouquet"
	item_path = /obj/item/bouquet

/datum/loadout_item/inhand/bouquet_sunflower
	name = "Sunflower Bouquet"
	item_path = /obj/item/bouquet/sunflower

/datum/loadout_item/inhand/bouquet_poppy
	name = "Poppy Bouquet"
	item_path = /obj/item/bouquet/poppy

/datum/loadout_item/inhand/bouquet_rose
	name = "Rose Bouquet"
	item_path = /obj/item/bouquet/rose

/datum/loadout_item/inhand/flag_nt
	name = "Folded Nanotrasen Flag"
	item_path = /obj/item/sign/flag/nanotrasen

/datum/loadout_item/inhand/flag_agurk
	name = "Folded Kingdom Of Agurkrral Flag"
	item_path = /obj/item/sign/flag/ssc

/datum/loadout_item/inhand/flag_terragov
	name = "Folded Terran Government Flag"
	item_path = /obj/item/sign/flag/terragov

/datum/loadout_item/inhand/flag_moghes
	name = "Folded Republic Of Northern Moghes Flag"
	item_path = /obj/item/sign/flag/tizira

/datum/loadout_item/inhand/flag_mothic
	name = "Folded Grand Nomad Fleet Flag"
	item_path = /obj/item/sign/flag/mothic

/datum/loadout_item/inhand/flag_teshari
	name = "Folded Teshari League For Self-Determination Flag"
	item_path = /obj/item/sign/flag/mars

/datum/loadout_item/inhand/flag_nri
	name = "Folded Novaya Rossiyskaya Imperiya Flag"
	item_path = /obj/item/sign/flag/nri

/datum/loadout_item/inhand/flag_azulea
	name = "Folded Azulea Flag"
	item_path = /obj/item/sign/flag/azulea

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
	name = "Saddlebags"
	item_path = /obj/item/storage/backpack/saddlebags

/datum/loadout_item/inhand/saddle // these should be in the other category but apparantly those are "pocket" loadout items so idk?
	name = "Leather Saddle"
	item_path = /obj/item/riding_saddle/leather

/datum/loadout_item/inhand/saddle_peacekeeper
	name = "Peacekeeper Saddle"
	item_path = /obj/item/riding_saddle/leather/peacekeeper
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/inhand/wheelchair
	name = "Folded Wheelchair"
	item_path = /obj/item/wheelchair

/datum/loadout_item/inhand/sex_sign
	name = "Sex Holosign Projector"
	item_path = /obj/item/holosign_creator/sex

/datum/loadout_item/inhand/officialcat
	name = "Official Cat Stamp"
	item_path = /obj/item/stamp/cat
//	ckeywhitelist = list("kathrinbailey")

/datum/loadout_item/inhand/hardlight_wheelchair
	name = "Hardlight Wheelchair Projector"
	item_path = /obj/item/holosign_creator/hardlight_wheelchair
//	ckeywhitelist = list("sqnztb")
