//Stuff for the quantum hub
/area/ruin/space/has_grav/powered/quantum_hub
	name = "Quantum Pad Hub"
	icon_state = "purple"

/obj/item/storage/box/quantum_pad_parts
	name = "box of quantum pad parts"
	desc = "Contains a all the parts you'd need to make a quantum pad."
	icon_state = "syndiebox"

/obj/item/storage/box/quantum_pad_parts/PopulateContents()
	new /obj/item/circuitboard/machine/quantumpad(src)
	new /obj/item/stack/ore/bluespace_crystal(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/manipulator/femto(src)
	new /obj/item/stack/cable_coil(src, 15)
	new /obj/item/stack/sheet/metal/twenty(src)

/area/ruin/unpowered/caloriteshrine
	name = "Calorite Shrine"
	icon_state = "away"

/area/ruin/powered/snackstore
	name = "Snack Store"
	icon_state = "away"

/area/ruin/powered/candyland/inside
	name = "Candy Land"
	icon_state = "away"

/area/ruin/powered/candyland/outside
	name = "Candy Land"
	icon_state = "away"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/ruin/powered/candycaveLower/inside
	name = "Candy Cave"
	icon_state = "away"


//fatventure gateway map
/area/awaymission/fatventure
	name = "Unknown Area"
	icon_state = "awaycontent1"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/awaymission/fatventure/outside
	name = "Unknown Area - Outside"
	icon_state = "awaycontent25"

/area/awaymission/fatventure/inside
	name = "Unknown Area - Inside"
	icon_state = "awaycontent2"
	// requires_power = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED

/obj/effect/light_emitter/light //made this light emitter for adventure maps where you have to naturally switch between dynamic and nondynamic light
	set_luminosity = 4
	set_cap = 2.5
	light_color = LIGHT_COLOR_TUNGSTEN

/turf/closed/indestructible/junglemineral
	name = "tough rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"
