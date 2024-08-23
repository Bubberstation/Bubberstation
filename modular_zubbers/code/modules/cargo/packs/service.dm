/datum/supply_pack/service/jukebox
	name = "Jukebox crate"
	desc = "Shift getting too boring? Lighten up the mood with some music from the jukebox!"
	cost = CARGO_CRATE_VALUE * 50
	contains = list(/obj/machinery/jukebox)
	crate_type = /obj/structure/closet/crate/large
	access_view = ACCESS_BAR

/datum/supply_pack/organic/exoticseeds/New()
	. = ..()
	contains += /obj/item/seeds/vaporsac
