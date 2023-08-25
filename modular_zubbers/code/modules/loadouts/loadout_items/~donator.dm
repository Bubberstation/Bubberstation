//Welcome to the Bubber donor file. You put all Bubberstation donor items here.

/*
/datum/loadout_item/suit/runner_syndi //Made by Kan3
	name = "Syndicate Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/syndicate
	donator_only = TRUE //Dono item for Kan3
	ckey_whitelist = list("kan3")
*/


// Bubber donor items below. When adding to this file, be sure to include credit for your spriter, whoever it may be. See example for how to add credit.
//Glasses (loadout_datum_glasses.dm.)
/datum/loadout_item/glasses/silk_blindfold
	name = "Silk Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/glasses/surgerygoggles
	name = "Surgery Goggles"
	item_path = /obj/item/clothing/glasses/surgerygoggles
	restricted_roles = list(JOB_MEDICAL_DOCTOR,JOB_CHIEF_MEDICAL_OFFICER)

//Gloves (loadout_datum_gloves.dm)
/datum/loadout_item/gloves/lace_gloves
	name = "Lace Gloves"
	item_path = /obj/item/clothing/gloves/evening/lace
	donator_only = TRUE

/datum/loadout_item/gloves/rubber_gloves
	name = "Long Rubber Gloves"
	item_path = /obj/item/clothing/gloves/longrubbergloves
	restricted_roles = list(JOB_MEDICAL_DOCTOR,JOB_CHIEF_MEDICAL_OFFICER)

//Heads (loadout_datum_heads.dm)
/datum/loadout_item/head/alien_fake
	name = "Kabrus Utility Helmet"
	item_path = /obj/item/clothing/head/helmet/abductor/fake
	donator_only = TRUE //Dono item for MyphicBowser

/datum/loadout_item/head/hats/warden/drill
	name = "warden's campaign hat"
	item_path = /obj/item/clothing/head/hats/warden/drill

/datum/loadout_item/head/hats/caphat/drill
	name = "Captain's campaign hat"
	item_path = /obj/item/clothing/head/hats/caphat/drill
	donator_only = TRUE
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/head/hats/blueshield/drill
	name = "Blueshield's campaign hat"
	item_path = /obj/item/clothing/head/hats/blueshield/drill
	donator_only = TRUE
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/head/hats/hos/drill
	name = "Head of Security's campaign hat"
	item_path = /obj/item/clothing/head/hats/hos/drill
	donator_only = TRUE
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/hats/nanotrasen_consultant/drill
	name = "Representative's campaign hat"
	item_path = /obj/item/clothing/head/nanotasen_consultant/drill
	donator_only = TRUE
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/head/lace_bow
	name = "Hair Bow"
	item_path = /obj/item/clothing/head/costume/hairbow
	donator_only = TRUE

//Neck (loadout_datum_neck.dm)
/datum/loadout_item/neck/heart_choker
	name = "Heart Collar"
	item_path = /obj/item/clothing/neck/lace_collar
	donator_only = TRUE

//Shoes (loadout_datum_shoes.dm)
/datum/loadout_item/shoes/lace_heels
	name = "Elegant Heels"
	item_path = /obj/item/clothing/shoes/heels/drag/lace
	ckeywhitelist = list("thedragmeme")

//Suit (loadout_datum_suit.dm)
/datum/loadout_item/suit/runner_engi
	name = "Engineer Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/engi
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/runner_syndi
	name = "Syndicate Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/syndicate
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/runner_winter
	name = "Winter Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/winter
	ckeywhitelist = list("kan3")

/datum/loadout_item/suit/shawl
	name = "Silk Shawl"
	item_path = /obj/item/clothing/suit/cloak/shawl
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/leather_apron
	name = "Leather Apron"
	item_path = /obj/item/clothing/suit/leatherapron
	restricted_roles = list(JOB_MEDICAL_DOCTOR,JOB_CHIEF_MEDICAL_OFFICER)
//Toys (loadout_datum_toys.dm)
/datum/loadout_item/toys/moffplush_lovers
	name = "Lovers moth plushie"
	item_path = /obj/item/toy/plush/moth/lovers
	donator_only = TRUE //Donor item for Basicguy20

/datum/loadout_item/toys/chirp_plush
	name = "Chirpy Synth Plushie"
	item_path = /obj/item/toy/plush/chirp_plush
	donator_only = FALSE //Donor item for potatomedic. Requested it be public.

//Jumpsuits (loadout_datum_under.dm)
/datum/loadout_item/under/syndicate/skyrat/tactical
	name = "tactical turtleneck"
	item_path = /obj/item/clothing/under/syndicate/skyrat/tactical
	donator_only = TRUE

/datum/loadout_item/under/syndicate/skyrat/tactical/skirt
	name = "tactical skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/skyrat/tactical/skirt
	donator_only = TRUE

/datum/loadout_item/under/rank/security/officer/hecu
	name = "Urban camouflage BDU"
	item_path = /obj/item/clothing/under/rank/security/officer/hecu
	donator_only = TRUE
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/under/formal/lace_dress
	name = "Lilac Dress"
	item_path = /obj/item/clothing/under/rank/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/under/miscellaneous/medrscrubs
	name = "Security Medic's Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	restricted_roles = list(JOB_SECURITY_MEDIC)
