//specific_lift_id of biodome's boat tram
#define BOAT_TRAM "tram_boat"
//boat destinations
#define BOAT_TRAM_FORE 1
#define BOAT_TRAM_CENTRAL 2
#define BOAT_TRAM_AFT 3

//These are the landmarks
/obj/effect/landmark/lift_id/boat
	specific_lift_id = BOAT_TRAM

/obj/machinery/computer/tram_controls/boat
	specific_lift_id = BOAT_TRAM

//These are the destinations
/obj/effect/landmark/tram/boat/fore
	name = "Fore Boat Dock"
	specific_lift_id = BOAT_TRAM
	platform_code = BOAT_TRAM_FORE
	tgui_icons = list("Departures" = "plane-departure", "Science" = "flask")

/obj/effect/landmark/tram/boat/middle
	name = "Central Boat Dock"
	specific_lift_id = BOAT_TRAM
	platform_code = BOAT_TRAM_CENTRAL
	tgui_icons = list("Cargo" = "box")

/obj/effect/landmark/tram/boat/aft
	name = "Aft Boat Dock"
	specific_lift_id = BOAT_TRAM
	platform_code = BOAT_TRAM
	tgui_icons = list("Command" = "bullhorn")

//These are the buttons
/obj/machinery/button/tram/boat/fore
	id = BOAT_TRAM_FORE
	lift_id = BOAT_TRAM

/obj/machinery/button/tram/boat/middle
	id = BOAT_TRAM_CENTRAL
	lift_id = BOAT_TRAM

/obj/machinery/button/tram/boat/aft
	id = BOAT_TRAM_AFT
	lift_id = BOAT_TRAM

#undef BOAT_TRAM
#undef BOAT_TRAM_AFT
#undef BOAT_TRAM_CENTRAL
#undef BOAT_TRAM_FORE
