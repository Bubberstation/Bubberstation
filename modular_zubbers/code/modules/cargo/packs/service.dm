/datum/supply_pack/service/jukebox
	name = "Jukebox crate"
	desc = "Shift getting too boring? Lighten up the mood with some music from the jukebox!"
	cost = CARGO_CRATE_VALUE * 50
	contains = list(/obj/machinery/jukebox/no_access)
	crate_type = /obj/structure/closet/crate/large
	access_view = ACCESS_BAR

/datum/supply_pack/organic/exoticseeds/New()
	. = ..()
	contains += /obj/item/seeds/vaporsac

/datum/supply_pack/service/carpet_branded
	name = "Branded Carpet Crate"
	desc = "Here is a group of carpets coming in stacks of fifty guarenteed to add some corporate appreciation to your shift."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/stack/tile/carpet/stellar = 50,
					/obj/item/stack/tile/carpet/donk = 50,
					/obj/item/stack/tile/carpet/executive = 50,
				)
	crate_name = "branded carpet crate"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/goody/service
	group = "Service"

/datum/supply_pack/goody/service/hydro_synth
	contains = list(/obj/item/flatpacked_machine/hydro_synth)
	cost = PAYCHECK_CREW
	auto_name = TRUE
