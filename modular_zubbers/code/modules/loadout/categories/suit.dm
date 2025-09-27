//Title Capitalization for names please!!!

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
	name = "Samurai Costume"
	item_path = /obj/item/clothing/suit/costume/samurai

/datum/loadout_item/suit/bunny_tailcoat
	name = "Bunny Tailcoat"
	item_path = /obj/item/clothing/suit/jacket/tailcoat

/datum/loadout_item/suit/pirate_coat
	name = "Pirate Coat"
	item_path = /obj/item/clothing/suit/costume/pirate

/datum/loadout_item/suit/hooded/wintercoat/security
	name = "Security Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/hooded/wintercoat/security/redsec
	name = "Security Red Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/toggle/jacket/sec/old
	name = "Security Red Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec/old
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/secjacket
	name = "High-Vis Security Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/secjacket/blue
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/secjacket/bomber
	name = "Security Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/officer/tan
	name = "Tan Security Blazer"
	item_path = /obj/item/clothing/suit/jacket/officer/tan
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/secjacket
	name = "Security Jacket"
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
	name = "Imperial Police Vest"
	item_path = /obj/item/clothing/suit/armor/vest/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/suit/jacket/fedsec
	name = "Modern Security Federation Jacket"
	item_path = /obj/item/clothing/suit/fedcoat/modern/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/corrections_officer
	name = "Correction's Officer's Blazer"
	item_path = /obj/item/clothing/suit/toggle/jacket/corrections_officer
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/suit/jacket/security_medic
	name = "Security Medic Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/jacket/security_medic
	name = "Security Medic's Blue Labcoat"
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

/datum/loadout_item/suit/frontier_colonist
	name = "Frontier Trenchcoat"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/loadout

/datum/loadout_item/suit/frontier_colonist_short
	name = "Frontier Jacket"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/short/loadout

//Doppler hoodies.

/datum/loadout_item/suit/hoodie/big_hoodie
	name = "Big Hoodie"
	item_path = /obj/item/clothing/suit/hooded/big_hoodie

/datum/loadout_item/suit/hoodie/twee_hoodie
	name = "Disconcertingly Twee Hoodie"
	item_path = /obj/item/clothing/suit/hooded/twee_hoodie

//Para Bombers
//Unless it has armor, real armor and not just like minor acid/fire I'm just gonna leave it unrestricted because the people want their drip. Me. I'm the people.
/datum/loadout_item/suit/parabomber
	name = "Three Piece Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber

/datum/loadout_item/suit/paraatmosbomber
	name = "Atmos Bomber Jacket"
	item_path = /obj/item/clothing/suit/utility/fire/atmosbomber
	restricted_roles = list(ALL_JOBS_ENGINEERING)

/datum/loadout_item/suit/paraengibomber
	name = "Engineering Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/engi

/datum/loadout_item/suit/paracargobomber
	name = "Cargo Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo

/datum/loadout_item/suit/parathesmithsbomber
	name = "Blacksmith Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo/smith

/datum/loadout_item/suit/paraminingbomber
	name = "Mining Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining
	restricted_roles = list(JOB_SHAFT_MINER)

/datum/loadout_item/suit/parascibomber
	name = "Scientist Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science

/datum/loadout_item/suit/pararobobomber
	name = "Robotics Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/robotics

/datum/loadout_item/suit/paramedbomber
	name = "Medical Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/med

/datum/loadout_item/suit/parachembomber
	name = "Chemical Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/chem

/datum/loadout_item/suit/paracorobomber
	name = "Black Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/coroner

/datum/loadout_item/suit/parabotbomber
	name = "Botanical Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/hydro

/datum/loadout_item/suit/paraimposterbomber
	name = "Suspicious Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/syndicate/fake
