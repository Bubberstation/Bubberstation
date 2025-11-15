#define GHC_MISC "Misc"
#define GHC_APARTMENT "Apartment"
#define GHC_BEACH "Beach"
#define GHC_STATION "Station"
#define GHC_WINTER "Winter"
#define GHC_SPECIAL "Special"

/datum/map_template/ghost_cafe_rooms
	var/category = GHC_MISC //Room categorizing

/datum/map_template/ghost_cafe_rooms/apartment
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/beach_condo
	category = GHC_BEACH

/datum/map_template/ghost_cafe_rooms/stationside
	category = GHC_STATION

/datum/map_template/ghost_cafe_rooms/library
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/cultcave
	category = GHC_SPECIAL

/datum/map_template/ghost_cafe_rooms/winterwoods
	category = GHC_WINTER

/datum/map_template/ghost_cafe_rooms/evacuationstation
	category = GHC_SPECIAL

/datum/map_template/ghost_cafe_rooms/prisoninfdorm
	category = GHC_SPECIAL

/datum/map_template/ghost_cafe_rooms/corporateoffice
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/recwing
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/grotto
	category = GHC_SPECIAL

/datum/map_template/ghost_cafe_rooms/grotto2
	category = GHC_SPECIAL

// Bubber's custom room templates

/datum/map_template/ghost_cafe_rooms/apartment_city
	name = "City Apartment"
	mappath = "_maps/bubber/templates/apartment_city.dmm"
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/apartment_jungle
	name = "Jungle Paradise"
	mappath = "_maps/bubber/templates/apartment_jungle.dmm"
	category = GHC_BEACH

/datum/map_template/ghost_cafe_rooms/apartment_snow
	name = "Snowy Cabin"
	mappath = "_maps/bubber/templates/apartment_winter.dmm"
	category = GHC_WINTER

/datum/map_template/ghost_cafe_rooms/apartment_lavaland
	name = "Survival Capsule"
	mappath = "_maps/bubber/templates/apartment_capsule.dmm"
	category = GHC_MISC

/datum/map_template/ghost_cafe_rooms/apartment_2
	name = "Apartment 2"
	mappath = "_maps/bubber/templates/apartment_2.dmm"
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/apartment_3
	name = "Apartment 3"
	mappath = "_maps/bubber/templates/apartment_3.dmm"
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/apartment_bar
	name = "Bar Lounge"
	mappath = "_maps/bubber/templates/apartment_bar.dmm"
	category = GHC_APARTMENT

/datum/map_template/ghost_cafe_rooms/apartment_forest
	name = "Forest Picnic"
	mappath = "_maps/bubber/templates/apartment_forest.dmm"
	category = GHC_BEACH

/datum/map_template/ghost_cafe_rooms/apartment_garden
	name = "Garden"
	mappath = "_maps/bubber/templates/apartment_garden.dmm"
	category = GHC_MISC

/datum/map_template/ghost_cafe_rooms/apartment_prison_cell
	name = "Top Security Prison"
	mappath = "_maps/bubber/templates/apartment_prison.dmm"
	category = GHC_SPECIAL

/datum/map_template/ghost_cafe_rooms/apartment_sauna
	name = "Sauna"
	mappath = "_maps/bubber/templates/apartment_sauna.dmm"
	category = GHC_MISC

#undef GHC_MISC
#undef GHC_APARTMENT
#undef GHC_BEACH
#undef GHC_STATION
#undef GHC_WINTER
#undef GHC_SPECIAL
