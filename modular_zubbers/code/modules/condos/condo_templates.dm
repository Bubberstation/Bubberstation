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
	mappath = "_maps/bubber/condos/alleyway.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 5

/datum/map_template/condo/apartment
	name = "Condo - Apartment"
	mappath = "_maps/bubber/condos/apartment.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/blueshift_dorms_four
	name = "Condo - \"Blueshift\" Style Dormitory"
	mappath = "_maps/bubber/condos/blueshift_dormsfour.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/// Wowee! It's like I'm a real terrorist!
/// This particular one was cooler with wallening window frames and short stairs.. alas. twas not to be
/datum/map_template/condo/dstwo_condo
	name = "Condo - Authentic DS-2 Theming"
	mappath = "_maps/bubber/condos/dstwo_condo.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 2

/datum/map_template/condo/beach_condo
	name = "Condo - Beachside"
	mappath = "_maps/bubber/condos/beach_condo.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 2

/datum/map_template/condo/gm_condo
	name = "Condo - Suite"
	mappath = "_maps/bubber/condos/gm_condo.dmm"
	landing_zone_x_offset = 4
	landing_zone_y_offset = 2

/// This version's actually slightly different to justify itself; being based off the wallening version.
/datum/map_template/condo/hilberts_hotel
	name = "Condo - Hilbert's Hotel Room"
	mappath = "_maps/bubber/condos/hilbertshotel.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 12

/datum/map_template/condo/lodge_pool
	name = "Condo - Lodge's Pool"
	mappath = "_maps/bubber/condos/lodge_pool.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 1

/datum/map_template/condo/manor_hall
	name = "Condo - Manor Hall"
	mappath = "_maps/bubber/condos/manor_hall.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 3

/datum/map_template/condo/medieval_bog
	name = "Condo - Medieval Bog"
	mappath = "_maps/bubber/condos/medieval_bog.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 3

/datum/map_template/condo/necropolis
	name = "Condo - Necropolis"
	mappath = "_maps/bubber/condos/necropolis.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 11

/datum/map_template/condo/ocean_view
	name = "Condo - Ocean View"
	mappath = "_maps/bubber/condos/ocean_view.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/ouroboros_dorms_four
	name = "Condo - \"Ouroboros\" Style Dormitory"
	mappath = "_maps/bubber/condos/ouroboros_dormssix.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 4

/// The joke was originally that it was just flatgrass. Now it's a little more.
/datum/map_template/condo/planar_soil
	name = "Condo - Planar Soil"
	mappath = "_maps/bubber/condos/planar_soil.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/serenity_cabin_four
	name = "Condo - \"Serenity\" Style Cabin"
	mappath = "_maps/bubber/condos/serenity_cabinfour.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 1

/datum/map_template/condo/snowglobe_dorms_four
	name = "Condo - \"Snowglobe\" Style Dormitory"
	mappath = "_maps/bubber/condos/snowglobe_dormsfour.dmm"
	landing_zone_x_offset = 6
	landing_zone_y_offset = 3

/datum/map_template/condo/station_arrivals
	name = "Condo - Arrivals Checkpoint"
	mappath = "_maps/bubber/condos/station_arrivals.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/datum/map_template/condo/xeno_resin
	name = "Condo - Xenomorph Hive"
	mappath = "_maps/bubber/condos/xeno_resin.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/condo/cabin_woods
	name = "Condo - Cabin In The Woods"
	mappath = "_maps/bubber/condos/cabin_woods.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/condo/ship_bridge
	name = "Condo - Spaceship Bridge"
	mappath = "_maps/bubber/condos/ship_bridge.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/public_library
	name = "Condo - Public Library"
	mappath = "_maps/bubber/condos/public_library.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1

/datum/map_template/condo/mountainside_apartment
	name = "Condo - Mountainside Apartment"
	mappath = "_maps/bubber/condos/apartment_mountainside.dmm"
	landing_zone_x_offset = 14
	landing_zone_y_offset = 4

/datum/map_template/condo/mountainside_fortuneteller
	name = "Condo - Fortune Teller Apartment"
	mappath = "_maps/bubber/condos/apartment_fortuneteller.dmm"
	landing_zone_x_offset = 5
	landing_zone_y_offset = 8

/datum/map_template/condo/mountainside_skyscraper
	name = "Condo - Skyscraper"
	mappath = "_maps/bubber/condos/apartment_skyscraper.dmm"
	landing_zone_x_offset = 17
	landing_zone_y_offset = 3

/datum/map_template/condo/mountainside_dragonlair
	name = "Condo - Dragon's Lair"
	mappath = "_maps/bubber/condos/apartment_dragonslair.dmm"
	landing_zone_x_offset = 5
	landing_zone_y_offset = 11

/datum/map_template/condo/deepspace_ship
	name = "Condo - Deepspace Ship"
	mappath = "_maps/bubber/condos/ship_apartment.dmm"
	landing_zone_x_offset = 9
	landing_zone_y_offset = 2

/datum/map_template/condo/deepspace_pod
	name = "Condo - Deepspace Pod"
	mappath = "_maps/bubber/condos/deepspace_pod.dmm"
	landing_zone_x_offset = 1
	landing_zone_y_offset = 2

// Bubber Maps start here

/datum/map_template/condo/corpo
	name = "Condo - Corporate Office (Nanotrasen)"
	mappath = "_maps/bubber/condos/corporateoffice.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 9

/datum/map_template/condo/corposyndi
	name = "Condo - Corporate Office (Syndicate)"
	mappath = "_maps/bubber/condos/syndieoffice.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 9

/datum/map_template/condo/cultcave
	name = "Condo - Cult Cave"
	mappath = "_maps/bubber/condos/cultcave.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 13

/datum/map_template/condo/engineering
	name = "Condo - Engineering Department"
	mappath = "_maps/bubber/condos/engineering.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 10

/datum/map_template/condo/eva
	name = "Condo - Space Walk"
	mappath = "_maps/bubber/condos/eva.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/foxbar
	name = "Condo - Foxy Boxes"
	mappath = "_maps/bubber/condos/foxbar.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/grotto
	name = "Condo - Grotto (Day)"
	mappath = "_maps/bubber/condos/grotto.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/grottoalt
	name = "Condo - Grotto (Night)"
	mappath = "_maps/bubber/condos/grottoalt.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/nightclub //You gotta come to my cosuin's club, it's called Stepford
	name = "Condo - Cousin's Club"
	mappath = "_maps/bubber/condos/nightclub.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/oasis
	name = "Condo - Oasis (Day)"
	mappath = "_maps/bubber/condos/oasis.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/oasisalt
	name = "Condo - Oasis (Night)"
	mappath = "_maps/bubber/condos/oasisalt.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/poole
	name = "Condo - Hotel Pool"
	mappath = "_maps/bubber/condos/pool.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/bubberlibrary
	name = "Condo - Private Library"
	mappath = "_maps/bubber/condos/library.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/prison
	name = "Condo - Brixton Prison"
	mappath = "_maps/bubber/condos/prisoninfdorm.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 2

/datum/map_template/condo/hospital
	name = "Condo - Hospital Ward"
	mappath = "_maps/bubber/condos/recovery.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/condo/stationside
	name = "Condo - Station Slice"
	mappath = "_maps/bubber/condos/stationside.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 3

/datum/map_template/condo/synopcenter
	name = "Condo - Syndicate Operations Hub"
	mappath = "_maps/bubber/condos/synopcenter.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

/datum/map_template/condo/winterwoods
	name = "Condo - Snowy Wilderness"
	mappath = "_maps/bubber/condos/winterwoods.dmm"
	landing_zone_x_offset = 3
	landing_zone_y_offset = 6

/datum/map_template/condo/evacstat
	name = "Condo - Evacuating Station"
	mappath = "_maps/bubber/condos/evacuationstation.dmm"
	landing_zone_x_offset = 15
	landing_zone_y_offset = 8

/datum/map_template/condo/arcade
	name = "Condo - New-age Arcade"
	mappath = "_maps/bubber/condos/arcade.dmm"
	landing_zone_x_offset = 14
	landing_zone_y_offset = 8

//PORTED FROM IRIS
/datum/map_template/condo/fast_food
	name = "Condo - Diner Restaurant"
	mappath = "_maps/bubber/condos/fast_food.dmm"
	landing_zone_x_offset = 8
	landing_zone_y_offset = 2

/datum/map_template/condo/kinodertoten
	name = "Condo - Movie Theater"
	mappath = "_maps/bubber/condos/cinema.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 4
