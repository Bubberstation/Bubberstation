/datum/loadout_item/glasses/silk_blindfold
	name = "Silk Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/glasses/surgerygoggles
	name = "Recovery Goggles"
	item_path = /obj/item/clothing/glasses/surgerygoggles

/datum/loadout_item/glasses/surgerygoggles/med
	name = "Surgery Goggles"
	item_path = /obj/item/clothing/glasses/hud/health/surgerygoggles
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)
