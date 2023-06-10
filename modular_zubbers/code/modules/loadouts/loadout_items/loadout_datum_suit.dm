//Donator items V V V

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
