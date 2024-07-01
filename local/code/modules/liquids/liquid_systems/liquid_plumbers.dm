// Stops at 30 height - perfect for automatically refilling pools and other water fixtures. SHOG TODO: Standardize liquid heights into defines (or use ""::"?)
/obj/machinery/plumbing/floor_pump/output/on/supply/waist_deep
	height_regulator = 30

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/plumbing/floor_pump/output/on/supply/waist_deep, 0)

/obj/machinery/plumbing/filter/water_filter/right_output
	left = list()
	right = list(/datum/reagent/water)
	english_left = list()
	english_right = list("Water")
