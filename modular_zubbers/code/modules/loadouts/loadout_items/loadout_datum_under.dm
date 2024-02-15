/datum/loadout_item/under/jumpsuit/security/hecu
	name = "urban camouflage BDU"
	item_path = /obj/item/clothing/under/rank/security/officer/hecu
	donator_only = TRUE
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/under/miscellaneous/command/stripper //Sprites by SierraGenevese
	name = "command stripper uniform"
	item_path = /obj/item/clothing/under/rank/civilian/head_of_personnel/stripper
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/under/miscellaneous/nanotrasen_consultant/stripper //Sprites by SierraGenevese
	name = "consultant stripper uniform"
	item_path = /obj/item/clothing/under/rank/nanotrasen_consultant/stripper
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/under/formal/lace_dress
	name = "Lilac Dress"
	item_path = /obj/item/clothing/under/rank/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/under/miscellaneous/medrscrubs
	name = "Security Medic's Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/under/miscellaneous/tactical_maid //Donor item for skyefree
	name = "Tactical Maid Costume"
	item_path = /obj/item/clothing/under/misc/maid/tactical
	donator_only = TRUE
