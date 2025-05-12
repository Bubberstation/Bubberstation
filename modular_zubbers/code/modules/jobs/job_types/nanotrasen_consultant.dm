/datum/job/nanotrasen_consultant
	departments_list = list(
		/datum/job_department/command,
	)
//Making the NT consultant Command, not Central Command.
/datum/outfit/job/nanotrasen_consultant
	id = /obj/item/card/id/advanced/silver
	suit_store = /obj/item/gun/energy/e_gun
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		)
//Makes it so the NTRep only has an e_gun forevermore

/obj/structure/closet/secure_closet/nanotrasen_consultant/station
	req_access = list()
	req_one_access = list(ACCESS_CENT_GENERAL) //Make it so the Consultant can access their own locker with these changes
//Making the Nanotrasen Consultant have a silver ID, so they cannot have all access by default.

/obj/structure/closet/secure_closet/nanotrasen_consultant // Ditto of the previous for skyrat automapper placed lockers.
	req_access = list()
	req_one_access = list(ACCESS_CENT_GENERAL)

/datum/id_trim/job/nanotrasen_consultant
	minimal_access = list(
				ACCESS_AI_UPLOAD, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_AUX_BASE, ACCESS_BAR, ACCESS_BRIG_ENTRANCE,
				ACCESS_CENT_GENERAL, ACCESS_CHANGE_IDS, ACCESS_CHAPEL_OFFICE, ACCESS_COMMAND, ACCESS_CONSTRUCTION,
				ACCESS_COURT, ACCESS_ENGINEERING, ACCESS_EVA, ACCESS_GATEWAY, ACCESS_HOP, ACCESS_HYDROPONICS,
				ACCESS_JANITOR, ACCESS_KEYCARD_AUTH, ACCESS_SERVICE, ACCESS_KITCHEN, ACCESS_LAWYER, ACCESS_LIBRARY, ACCESS_MAINT_TUNNELS,
				ACCESS_MEDICAL, ACCESS_MECH_ENGINE, ACCESS_MECH_MEDICAL, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY,
				ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_MORGUE, ACCESS_PSYCHOLOGY, ACCESS_RC_ANNOUNCE,
				ACCESS_RESEARCH, ACCESS_SECURITY, ACCESS_TELEPORTER, ACCESS_THEATRE, ACCESS_VAULT, ACCESS_WEAPONS
				)
//Removes Crematorium access, adds access to the Service hall

/obj/item/pen/fountain/green
	name = "nanotrasen fountain pen"
	desc = "It's an expensive green fountain pen. The case may be plastic, but that gold is real!"
	icon = 'modular_zubbers/icons/obj/service/bureaucracy.dmi'
	icon_state = "pen-fountain-nt"
	colour = "#18610D"
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5)
