/*
HEY!!! LISTEN!!!
Due to some fuckery with how these templates work; the bottom left turf of your map HAS to touch the rest AND has to be on the same /area/.
*/

/datum/map_template/condo
	/// Offset from the bottom-left turf of your condo. Said turf MUST touch the rest of your condo due to how these templates are loaded; including in /area/.
	var/landing_zone_x_offset
	var/landing_zone_y_offset

/// Keep these alphabetical.

/datum/map_template/condo/alleyway
	name = "Condo - Alleyway"
	mappath = "modular_zubbers/code/modules/condos/_maps/alleyway.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 5

/datum/map_template/condo/apartment
	name = "Condo - Apartment"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/blueshift_dorms_four
	name = "Condo - \"Blueshift\" Style Dormitory"
	mappath = "modular_zubbers/code/modules/condos/_maps/blueshift_dormsfour.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/// Wowee! It's like I'm a real terrorist!
/// This particular one was cooler with wallening window frames and short stairs.. alas. twas not to be
/datum/map_template/condo/dstwo_condo
	name = "Condo - Authentic DS-2 Theming"
	mappath = "modular_zubbers/code/modules/condos/_maps/dstwo_condo.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 2

/datum/map_template/condo/beach_condo
	name = "Condo - Beachside"
	mappath = "modular_zubbers/code/modules/condos/_maps/beach_condo.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 2

/datum/map_template/condo/gm_condo
	name = "Condo - Suite"
	mappath = "modular_zubbers/code/modules/condos/_maps/gm_condo.dmm"
	landing_zone_x_offset = 4
	landing_zone_y_offset = 2

/// This version's actually slightly different to justify itself; being based off the wallening version.
/datum/map_template/condo/hilberts_hotel
	name = "Condo - Hilbert's Hotel Room"
	mappath = "modular_zubbers/code/modules/condos/_maps/hilbertshotel.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 12

/datum/map_template/condo/lodge_pool
	name = "Condo - Lodge's Pool"
	mappath = "modular_zubbers/code/modules/condos/_maps/lodge_pool.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 1

/datum/map_template/condo/manor_hall
	name = "Condo - Manor Hall"
	mappath = "modular_zubbers/code/modules/condos/_maps/manor_hall.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 3

/datum/map_template/condo/medieval_bog
	name = "Condo - Medieval Bog"
	mappath = "modular_zubbers/code/modules/condos/_maps/medieval_bog.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 3

/datum/map_template/condo/necropolis
	name = "Condo - Necropolis"
	mappath = "modular_zubbers/code/modules/condos/_maps/necropolis.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 11

/datum/map_template/condo/ocean_view
	name = "Condo - Ocean View"
	mappath = "modular_zubbers/code/modules/condos/_maps/ocean_view.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/ouroboros_dorms_four
	name = "Condo - \"Ouroboros\" Style Dormitory"
	mappath = "modular_zubbers/code/modules/condos/_maps/ouroboros_dormssix.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 4

/// The joke was originally that it was just flatgrass. Now it's a little more.
/datum/map_template/condo/planar_soil
	name = "Condo - Planar Soil"
	mappath = "modular_zubbers/code/modules/condos/_maps/planar_soil.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/serenity_cabin_four
	name = "Condo - \"Serenity\" Style Cabin"
	mappath = "modular_zubbers/code/modules/condos/_maps/serenity_cabinfour.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 1

/datum/map_template/condo/snowglobe_dorms_four
	name = "Condo - \"Snowglobe\" Style Dormitory"
	mappath = "modular_zubbers/code/modules/condos/_maps/snowglobe_dormsfour.dmm"
	landing_zone_x_offset = 6
	landing_zone_y_offset = 3

/datum/map_template/condo/station_arrivals
	name = "Condo - Arrivals Checkpoint"
	mappath = "modular_zubbers/code/modules/condos/_maps/station_arrivals.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/datum/map_template/condo/xeno_resin
	name = "Condo - Xenomorph Hive"
	mappath = "modular_zubbers/code/modules/condos/_maps/xeno_resin.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/condo/cabin_woods
	name = "Condo - Cabin In The Woods"
	mappath = "modular_zubbers/code/modules/condos/_maps/cabin_woods.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/condo/ship_bridge
	name = "Condo - Spaceship Bridge"
	mappath = "modular_zubbers/code/modules/condos/_maps/ship_bridge.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/public_library
	name = "Condo - Public Library"
	mappath = "modular_zubbers/code/modules/condos/_maps/public_library.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/mountainside_apartment
	name = "Condo - Mountainside Apartment"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_mountainside.dmm"
	landing_zone_x_offset = 14
	landing_zone_y_offset = 4

/datum/map_template/condo/mountainside_fortuneteller
	name = "Condo - Fortune Teller Apartment"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_fortuneteller.dmm"
	landing_zone_x_offset = 5
	landing_zone_y_offset = 8

/datum/map_template/condo/mountainside_skyscraper
	name = "Condo - Skyscraper"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_skyscraper.dmm"
	landing_zone_x_offset = 17
	landing_zone_y_offset = 3

/datum/map_template/condo/mountainside_dragonlair
	name = "Condo - Dragon's Lair"
	mappath = "modular_zubbers/code/modules/condos/_maps/apartment_dragonslair.dmm"
	landing_zone_x_offset = 5
	landing_zone_y_offset = 11

/datum/map_template/condo/deepspace_ship
	name = "Condo - Deepspace Ship"
	mappath = "modular_zubbers/code/modules/condos/_maps/ship_apartment.dmm"
	landing_zone_x_offset = 9
	landing_zone_y_offset = 2

/datum/map_template/condo/deepspace_pod
	name = "Condo - Deepspace Pod"
	mappath = "modular_zubbers/code/modules/condos/_maps/deepspace_pod.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 2

// Bubber Maps start here

/datum/map_template/condo/corpo
	name = "Condo - Corporate Office (Nanotrasen)"
	mappath = "modular_zubbers/code/modules/condos/_maps/corporateoffice.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 9

/datum/map_template/condo/corposyndi
	name = "Condo - Corporate Office (Syndicate)"
	mappath = "modular_zubbers/code/modules/condos/_maps/syndieoffice.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 9

/datum/map_template/condo/cultcave
	name = "Condo - Cult Cave"
	mappath = "modular_zubbers/code/modules/condos/_maps/cultcave.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 13

/datum/map_template/condo/engineering
	name = "Condo - Engineering Department"
	mappath = "modular_zubbers/code/modules/condos/_maps/engineering.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 10

/datum/map_template/condo/eva
	name = "Condo - Space Walk"
	mappath = "modular_zubbers/code/modules/condos/_maps/eva.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/foxbar
	name = "Condo - Foxy Boxes"
	mappath = "modular_zubbers/code/modules/condos/_maps/foxbar.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/grotto
	name = "Condo - Grotto (Day)"
	mappath = "modular_zubbers/code/modules/condos/_maps/grotto.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/grottoalt
	name = "Condo - Grotto (Night)"
	mappath = "modular_zubbers/code/modules/condos/_maps/grottoalt.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/nightclub //You gotta come to my cosuin's club, it's called Stepford
	name = "Condo - Cousin's Club"
	mappath = "modular_zubbers/code/modules/condos/_maps/nightclub.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/oasis
	name = "Condo - Oasis (Day)"
	mappath = "modular_zubbers/code/modules/condos/_maps/oasis.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/oasisalt
	name = "Condo - Oasis (Night)"
	mappath = "modular_zubbers/code/modules/condos/_maps/oasisalt.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/poole
	name = "Condo - Hotel Pool"
	mappath = "modular_zubbers/code/modules/condos/_maps/pool.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/bubberlibrary
	name = "Condo - Private Library"
	mappath = "modular_zubbers/code/modules/condos/_maps/library.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/prison
	name = "Condo - Brixton Prison"
	mappath = "modular_zubbers/code/modules/condos/_maps/prisoninfdorm.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/datum/map_template/condo/hospital
	name = "Condo - Hospital Ward"
	mappath = "modular_zubbers/code/modules/condos/_maps/recovery.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/stationside
	name = "Condo - Station Slice"
	mappath = "modular_zubbers/code/modules/condos/_maps/stationside.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 3

/datum/map_template/condo/synopcenter
	name = "Condo - Syndicate Operations Hub"
	mappath = "modular_zubbers/code/modules/condos/_maps/synopcenter.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/winterwoods
	name = "Condo - Snowy Wilderness"
	mappath = "modular_zubbers/code/modules/condos/_maps/winterwoods.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 6

/datum/map_template/condo/evacstat
	name = "Condo - Evacuating Station"
	mappath = "evacuationstation.dmm"
	landing_zone_x_offset = 15
	landing_zone_y_offset = 8

//PORTED FROM IRIS
/datum/map_template/condo/fast_food
	name = "Condo - Diner Restaurant"
	mappath = "modular_zubbers/code/modules/condos/_maps/fast_food.dmm"
	landing_zone_x_offset = 8
	landing_zone_y_offset = 2

/datum/map_template/condo/kinodertoten
	name = "Condo - Movie Theater"
	mappath = "modular_zubbers/code/modules/condos/_maps/cinema.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 4
