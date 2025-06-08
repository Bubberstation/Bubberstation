/area/fatlab //GS13 - move this elsewhere later
	name = "Mysterious Facility"
	icon_state = "centcom"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE

/area/crew_quarters/fitness/sauna
	name = "Saunas"
	icon_state = "dk_yellow"

/area/xenoarch/caloriteresearch_powered
	name = "Research Facility Ruins"
	icon_state = "dk_yellow"
	power_light = TRUE

/area/xenoarch/caloriteresearch_unpowered
	name = "Research Facility Ruins"
	icon_state = "dk_yellow"
	power_light = TRUE

/area/ruin/space/has_grav/fastfood_main
	name = "GATO Restaurant - Main Area"
	has_gravity = TRUE

/area/ruin/space/has_grav/fastfood_employee
	name = "Restaurant Employee Area"
	has_gravity = TRUE

/area/ruin/space/has_grav/feedersden
	name = "Unknown Outpost"
	has_gravity = TRUE

/area/xenoarch
	icon = 'modular_gs/icons/turf/areas.dmi'
	icon_state = "xenogen"
	has_gravity = STANDARD_GRAVITY

/area/xenoarch/arch
	name = "Xenoarchaeology"
	icon_state = "xenoarch"

/area/xenoarch/bot
	name = "Xenoarchaeology Botany"
	icon_state = "xenobot"

/area/xenoarch/eng
	name = "Xenoarchaeology Engineering"
	icon_state = "xenoeng"

/area/xenoarch/gen
	name = "Xenoarchaeology Living Quarters"
	icon_state = "xenogen"

/area/xenoarch/sec
	name = "Xenoarchaeology Security"
	icon_state = "xenosec"

/area/xenoarch/med
	name = "Xenoarchaeology Medical"
	icon_state = "xenomed"

/area/xenoarch/nothinghere
	name = "Nothing Here"
	icon_state = "yellow"
	ambientsounds = SPOOKY


/area/lavaland/demone
	icon = 'modular_gs/icons/turf/areas.dmi'

/area/lavaland/demone/tele
	name= "Demone Teleporter Room"
	icon_state= "demonetp"


/area/lavaland/demone/living
	name= "Demone Living Area"
	icon_state= "demoneliving"

/area/lavaland/demone/kitchen
	name= "Demone Mining Kitchen"
	icon_state= "demonekitchen"

/area/lavaland/demone/minestorage
	name= "Demone Mining Storage"
	icon_state= "demonestorage"

/area/lavaland/demone/factoryoffice
	name= "Factory CEO Office"
	icon_state= "demonceo"

/area/lavaland/demone/lobby
	name= "Factory Lobby"
	icon_state= "demonelobby"

/area/lavaland/demone/reception
	name= "Factory Reception"
	icon_state= "demonereception"

/area/lavaland/demone/factorystorage
	name= "Factory Storage"
	icon_state= "factorystorage"

/area/lavaland/demone/factory
	name= "Factory"
	icon_state= "demonefactory"

/area/lavaland/demone/factorygen
	name= "Factory Generator Room"
	icon_state= "demonegen"

/area/lavaland/demone/villagesilo
	name= "Demone Village Silo"
	icon_state= "demonesilo"

/area/lavaland/demone/villagepsu
	name= "Village Generator Room"
	icon_state= "demonevilpsu"

/area/lavaland/demone/demonevillage
	name= "Village "
	icon_state= "demonevillage"


/obj/structure/sign/logo/donutsign1
	name = "Hella Nice Sign"
	desc = "Made from the hottest planet itself!"
	icon_state = "donut_signBL"

/obj/structure/sign/logo/donutsign2
	name = "Hella Nice Sign"
	desc = "Made from the hottest planet itself!"
	icon_state = "donut_signBR"


/obj/structure/sign/logo/donutsign3
	name = "Hella Nice Sign"
	desc = "Made from the hottest planet itself!"
	icon_state = "donut_signTL"

/obj/structure/sign/logo/donutsign4
	name = "Hella Nice Sign"
	desc = "Made from the hottest planet itself!"
	icon_state = "donut_signTR"


/obj/structure/sign/carts
	name = "CARTS"
	desc = "You are entering a motorized cart area."
	icon_state = "carts"

/area/ruin/powered/gluttony
	icon_state = "dk_yellow"

/area/ruin/powered/beach
	icon_state = "dk_yellow"


/area/ruin/unpowered/syndicate_lava_base/engineering
	name = "Syndicate Lavaland Engineering"

/area/ruin/unpowered/syndicate_lava_base/medbay
	name = "Syndicate Lavaland Medbay"

/area/ruin/unpowered/syndicate_lava_base/arrivals
	name = "Syndicate Lavaland Arrivals"

/area/ruin/unpowered/syndicate_lava_base/bar
	name = "Syndicate Lavaland Bar"

/area/ruin/unpowered/syndicate_lava_base/main
	name = "Syndicate Lavaland Primary Hallway"

/area/ruin/unpowered/syndicate_lava_base/cargo
	name = "Syndicate Lavaland Cargo Bay"

/area/ruin/unpowered/syndicate_lava_base/chemistry
	name = "Syndicate Lavaland Chemistry"

/area/ruin/unpowered/syndicate_lava_base/virology
	name = "Syndicate Lavaland Virology"

/area/ruin/unpowered/syndicate_lava_base/testlab
	name = "Syndicate Lavaland Experimentation Lab"

/area/ruin/unpowered/syndicate_lava_base/dormitories
	name = "Syndicate Lavaland Dormitories"

/area/ruin/unpowered/syndicate_lava_base/telecomms
	name = "Syndicate Lavaland Telecommunications"

/area/ruin/unpowered/syndicate_lava_base/circuits
	name = "Syndicate Lavaland Circuit Lab"

/area/ruin/unpowered/syndicate_lava_base/nanites
	name = "Syndicate Lavaland Nanite Lab"

/area/ruin/unpowered/syndicate_lava_base/outdoors //Putting this area down should prevent fauna from spawning nearby
	name = "Syndicate Lavaland Approach"
	icon_state = "red"
