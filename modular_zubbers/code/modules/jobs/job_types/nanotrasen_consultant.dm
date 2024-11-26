/obj/structure/closet/secure_closet/nanotrasen_consultant/station
	req_access = list()
	req_one_access = list(ACCESS_CENT_GENERAL) //Make it so the Consultant can access their own locker with these changes
//Making the Nanotrasen Consultant have a silver ID, so they cannot have all access by default.

/obj/item/pen/fountain/green
	name = "nanotrasen fountain pen"
	desc = "It's an expensive green fountain pen. The case may be plastic, but that gold is real!"
	icon = 'modular_zubbers/icons/obj/service/bureaucracy.dmi'
	icon_state = "pen-fountain-nt"
	colour = "#18610D"
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5)
