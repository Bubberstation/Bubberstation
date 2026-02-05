// Subtype that mimics more traditional airlocks.
/turf/closed/indestructible/hoteldoor/fakedoor
	name = "Condo Door"
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	icon_state = "fake_door"
	leave_message = "Are you ready to leave the Condo? If all occupants vacate; it'll be reset and anything you leave behind'll be lost!"
	/// What kind of turf should be visually represented under this door?
	var/turf/floor_to_copy = /turf/open/floor/plating

/turf/closed/indestructible/hoteldoor/fakedoor/Initialize(mapload)
	. = ..()
	underlays += mutable_appearance(initial(floor_to_copy.icon), initial(floor_to_copy.icon_state), initial(floor_to_copy.layer), offset_spokesman = src, plane = FLOOR_PLANE)

/turf/closed/indestructible/hoteldoor/fakedoor/public
	icon = /obj/machinery/door/airlock/public::icon
	icon_state = "closed"
	opacity = FALSE
	floor_to_copy = /turf/open/floor/iron

/turf/closed/indestructible/hoteldoor/fakedoor/travel_tile
	name = "Travel Tile"
	icon = 'icons/effects/effects.dmi'
	icon_state = "target_tile"
	floor_to_copy = /turf/open/misc/dirt/jungle
