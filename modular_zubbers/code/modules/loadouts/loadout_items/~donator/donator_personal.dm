//Put ckey locked stuff in here. Stuff that's just general donator items can go in the typical files.


/*
*	HEAD
*/

/datum/loadout_item/head/pinwheel_hat/gold //sprites by Keila.
	name = "magnificent pinwheel hat"
	item_path = /obj/item/clothing/head/helmet/toggleable/pinwheel/gold
	ckeywhitelist = list("malice69", "miniusAreas", "gavla", "hydrosatan", "nevimer", "naruga", "OmegaTracing", "KeRSe", "CprlEvergreen", "RiskyBusiness", "Slouista", "SapphoQueer", "LordGingy", "ARandomHyena", "LiuJr", "jamiemundy", "snajper202", "snaffle15", "sonicgotnuked", "fellis", "laetex", "especiallystrange", "ghostie_dwagons", "Kidkirby",)
//11/08/23: Added as a reward to people who have recommended friends to Bubberstation. Add to this list as you please, you can offer this as a reward for basically anything.
//Please mark the date and what this was awarded for in code comments here. For example:
//XX/XX/XX: Added as a reward for EXAMPLE EVENT's winners.


/datum/loadout_item/head/idmaberet
	name = "IDMA beret"
	item_path = /obj/item/clothing/head/idma_beret
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")

/datum/loadout_item/head/idmahelmet
	name = "IDMA service helmet"
	item_path = /obj/item/clothing/head/helmet/sec/sol/idma_helmet
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")
	restricted_roles = list (JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)


/*
*	GLASSES
*/

/datum/loadout_item/glasses/silk_blindfold
	name = "Silk Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold/lace
	ckeywhitelist = list("thedragmeme")

/*
*	UNDER
*/

/datum/loadout_item/under/formal/lace_dress
	name = "Lilac Dress"
	item_path = /obj/item/clothing/under/rank/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/under/miscellaneous/diver
	name = "Black Divers Uniform"
	item_path = /obj/item/clothing/under/misc/diver
	ckeywhitelist = list("sexmaster", "leafydasurvivor")

/datum/loadout_item/under/miscellaneous/idmasnowfatigue
	name = "IDMA service uniform"
	item_path = /obj/item/clothing/under/rank/security/idma_fatigue
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")
	restricted_roles = list (JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/under/miscellaneous/idmafatigue
	name = "IDMA desert service uniform"
	item_path = /obj/item/clothing/under/rank/security/idma_fatigue/alt
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")
	restricted_roles = list (JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)


/*
*	SUIT
*/

/datum/loadout_item/suit/idmavest
	name = "IDMA combat vest"
	item_path = /obj/item/clothing/suit/armor/vest/idma_vest
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")
	restricted_roles = list (JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/suit/idmarsuit
	name = "IDMA service jacket"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/idma_jacket
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")
	restricted_roles = list (JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/suit/idmardjacket
	name = "silicon administrator vest"
	item_path = /obj/item/clothing/suit/jacket/vera_jacket
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")
	restricted_roles = list (JOB_RESEARCH_DIRECTOR) // and otherwise if not, specific to the RD

/datum/loadout_item/suit/runner_winter
	name = "Winter Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/winter
	ckeywhitelist = list("kan3")

/datum/loadout_item/suit/shawl
	name = "Silk Shawl"
	item_path = /obj/item/clothing/suit/cloak/shawl
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/diver //Donor item for patriot210
	name = "Black Divers Coat"
	item_path = /obj/item/clothing/suit/jacket/diver
	ckeywhitelist = list("sexmaster", "leafydasurvivor")

/datum/loadout_item/suit/holographic
    name = "Holographic Suit V4000"
    item_path = /obj/item/clothing/suit/misc/holographic
    ckeywhitelist = list("blovy")


/*
*	SHOES
*/

/datum/loadout_item/shoes/lace_heels
	name = "Elegant Heels"
	item_path = /obj/item/clothing/shoes/heels/drag/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/diver //Donor item for patriot210
	name = "Black Divers Boots"
	item_path = /obj/item/clothing/shoes/boots/diver
	ckeywhitelist = list("sexmaster", "leafydasurvivor")

/*
*	ACCESSORIES
*/

/datum/loadout_item/accessory/idmaarmbands
	name = "IDMA armbands"
	item_path = /obj/item/clothing/accessory/armband/idmaarmband
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok")

/*
*	TOYS
*/

/datum/loadout_item/toys/nobl_plush
	name = "fluffy skog plushie"
	item_path = /obj/item/toy/plush/nobl
	ckeywhitelist = list("nobledreameater")

/datum/loadout_item/toys/carrotbag
	name = "Carrot Bag"
	item_path = /obj/item/sbeacondrop/carrot
	//ckeywhitelist = list("slippyjoe")

/datum/loadout_item/toys/largeredslime
	name = "Large Red Slime Plush"
	item_path = /obj/item/toy/plush/largeredslime
	ckeywhitelist = list("blovy")

/*
*	GLOVES
*/

/datum/loadout_item/gloves/diver //Donor item for patriot210
	name = "Black Divers Gloves"
	item_path = /obj/item/clothing/gloves/misc/diver
	ckeywhitelist = list("sexmaster", "leafydasurvivor")

/*
*	IN-HAND
*/

/datum/loadout_item/inhand/korvenbank //sprites by Keila
	name = "korven bank card"
	item_path = /obj/item/card/cardboard/korvenbank
	ckeywhitelist = list("catmanpop")

/datum/loadout_item/inhand/ornate_bottle	//Donator item exclusive for Blovy. Sprited by Casey/Keila.
	name = "Ornate Bottle"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/ornate
	ckeywhitelist = list("blovy")

/datum/loadout_item/inhand/vaporsac //donator request for MyGuy49
	name = "Vaporsac Seeds"
	item_path = /obj/item/seeds/vaporsac
	ckeywhitelist = list("MyGuy49")

/*
*	POCKETS
*/

/datum/loadout_item/pocket_items/starwine //sprites by Keila
	name = "starwire wine bottle"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/beer/starwine
	ckeywhitelist = list("catmanpop") //donator item for Catmanpop

/datum/loadout_item/pocket_items/stamp/donator/crow
	name = "Mitchell Inc. Stamp"
	item_path = /obj/item/stamp/donator/crow
//	ckeywhitelist = list("slippyjoe") //donator item for SlippyJoe, who woulda guessed.

