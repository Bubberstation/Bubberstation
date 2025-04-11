/datum/supply_pack/science/upload
	name = "Upload Console Crate"
	desc = "AI Upload console destroyed in an unfortunate accident? These replacement circuits will get you re-lawing rogue AI in no time!"
	cost = CARGO_CRATE_VALUE * 12
	access = ACCESS_AI_UPLOAD
	access_view = ACCESS_AI_UPLOAD
	contains = list(/obj/item/circuitboard/computer/aiupload = 1,
					/obj/item/circuitboard/computer/borgupload = 1)
	crate_name = "upload console crate"
	crate_type = /obj/structure/closet/crate/secure/science
	dangerous = TRUE
