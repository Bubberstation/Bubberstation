/datum/loadout_item/suit/secjacket
	name = "High-Vis Security Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/secjacket/blue
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/leather_apron
	name = "Leather Apron"
	item_path = /obj/item/clothing/suit/leatherapron

/datum/loadout_item/suit/bubber/hench
	name = "Henchmen Coat"
	item_path = /obj/item/clothing/suit/jacket/henchmen_coat

/datum/loadout_item/suit/suit_harness
	name = "Suit Harness"
	item_path = /obj/item/clothing/suit/misc/suit_harness

/datum/loadout_item/suit/samurai_armor
	name = "Samurai armor"
	item_path = /obj/item/clothing/suit/costume/samurai

/datum/loadout_item/suit/bunny_tailcoat
	name = "Bunny Tailcoat"
	item_path = /obj/item/clothing/suit/jacket/tailcoat

/datum/loadout_item/suit/pirate_coat
	name = "Pirate coat"
	item_path = /obj/item/clothing/suit/costume/pirate

/datum/loadout_item/suit/hooded/wintercoat/security
	name = "Security winter jacket"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/hooded/wintercoat/security/redsec
	name = "Security winter jacket (Redsec)"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/toggle/jacket/sec/old
	name = "Security jacket (Redsec)"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec/old
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/officer/tan
	name = "Formal security jacket (tan)"
	item_path = /obj/item/clothing/suit/jacket/officer/tan
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/secjacket
	name = "Security jacket"
	item_path = /obj/item/clothing/suit/armor/vest/secjacket
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/peacekeeper/armadyne
	name = "Armadyne Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/peacekeeper/armadyne/armor
	name = "Armadyne Armor Vest"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/nri_police
	name = "Imperial police vest"
	item_path = /obj/item/clothing/suit/armor/vest/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/suit/jacket/fedsec
	name = "Modern Security federation jacket"
	item_path = /obj/item/clothing/suit/fedcoat/modern/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/corrections_officer
	name = "Correction's officer's jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/corrections_officer
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/suit/jacket/security_medic
	name = "Security medic labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/jacket/security_medic
	name = "Security medic labcoat (Blue)"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue
	restricted_roles = list(JOB_SECURITY_MEDIC)

// Silver Jacket Mk2 but for all of Command
/datum/loadout_item/suit/lt3_armor/New()
	restricted_roles += list(JOB_HEAD_OF_SECURITY, JOB_BLUESHIELD, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CAPTAIN, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER)
	return ..()

// Fancy crop-top jackets

/datum/loadout_item/suit/crop_jacket
	name = "Colourable Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket

/datum/loadout_item/suit/shortsleeve_crop_jacket
	name = "Colourable Short-Sleeved Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve

/datum/loadout_item/suit/sleeveless_crop_jacket
	name = "Colourable Sleeveless Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless

/datum/loadout_item/suit/sports_jacket
	name = "Colourable Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/long

/datum/loadout_item/suit/shortsleeve_sports_jacket
	name = "Colourable Short-Sleeved Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve/long

/datum/loadout_item/suit/sleeveless_sports_jacket
	name = "Colourable Sleeveless Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless/long

//Donator items V V V

/datum/loadout_item/suit/runner_engi
	name = "Engineer Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/engi
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/runner_syndi
	name = "Syndicate Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/syndicate
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/collared_vest
	name = "GLP-C 'Úlfur' Vest"
	item_path = /obj/item/clothing/suit/armor/vest/collared_vest
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_CENTRAL)
	donator_only = TRUE //Dono item for offwrldr

/datum/loadout_item/suit/highvisjacket //sprites by Keila
	name = "High Vis Trucker Jacket"
	item_path = /obj/item/clothing/suit/jacket/trucker/highvis
	donator_only = TRUE //Donator item for arandomhyena

/datum/loadout_item/suit/roninjacket //sprites by Keila
	name = "Ronin Jacket"
	item_path = /obj/item/clothing/suit/jacket/trucker/ronin
	donator_only = TRUE //Donator item for arandomhyena

/datum/loadout_item/suit/flight //Donor item for ironknight060
	name = "MA-1 flight jacket"
	item_path = /obj/item/clothing/suit/jacket/flight

// Lore Jackets

/datum/loadout_item/suit/galfed_jacket
	name = "Galactic Federation Jacket"
	item_path = /obj/item/clothing/suit/jacket/galfed
