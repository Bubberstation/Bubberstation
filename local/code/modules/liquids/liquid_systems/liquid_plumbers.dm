// Stops at 30 height - perfect for automatically refilling pools and other water fixtures. SHOG TODO: Standardize liquid heights into defines (or use ""::"?)
/obj/machinery/plumbing/floor_pump/output/on/supply/waist_deep
	height_regulator = 30

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/plumbing/floor_pump/output/on/supply/waist_deep, 0)

/obj/machinery/plumbing/filter/water_filter/right_output
	left = list()
	right = list(/datum/reagent/water)
	english_left = list()
	english_right = list("Water")

// Helpers for maps
/obj/machinery/duct/supply
	color = COLOR_CYAN
	duct_color = COLOR_CYAN
	duct_layer = FOURTH_DUCT_LAYER
	pixel_x = 5
	pixel_y = 5

/obj/machinery/duct/supply/Initialize(mapload)
	pixel_x = 0
	pixel_y = 0
	. = ..()

/obj/machinery/duct/waste
	color = COLOR_BROWN
	duct_color = COLOR_BROWN
	duct_layer = SECOND_DUCT_LAYER
	pixel_x = -5
	pixel_y = -5

/obj/machinery/duct/waste/Initialize(mapload)
	pixel_x = 0
	pixel_y = 0
	. = ..()
