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
