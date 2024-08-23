//Automatic Camera Generation
//Mappers rejoice


//Mining Cameras
/obj/machinery/camera/autoname/mine
	network = list("ss13","mine")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/mine, 0)

//Science cameras.
/obj/machinery/camera/autoname/science
	network = list("ss13","rd")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/science, 0)

/obj/machinery/camera/autoname/toxins
	network = list("ss13","toxins","rd")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/toxins, 0)

/obj/machinery/camera/autoname/bombsite
	network = list("toxins","ordnance","rd")
	use_power = NO_POWER_USE //Test site is an unpowered area
	resistance_flags = INDESTRUCTIBLE
	light_range = 10
	start_active = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/bombsite, 0)

/obj/machinery/camera/autoname/xenobiology
	network = list("ss13","xeno","rd")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/xenobiology, 0)

// Security Cameras
/obj/machinery/camera/autoname/security
	network = list("ss13","security")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/security, 0)

/obj/machinery/camera/autoname/armory
	name = "motion-sensitive security camera"
	network = list("ss13","security","armory")
	start_active = TRUE

/obj/machinery/camera/autoname/armory/Initialize(mapload)
	. = ..()
	upgradeMotion()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/armory, 0)

/obj/machinery/camera/autoname/labor
	network = list("ss13","labor")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/labor, 0)

/obj/machinery/camera/autoname/prison
	network = list("ss13","security","prison")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/prison, 0)

/obj/machinery/camera/autoname/vault
	name = "motion-sensitive security camera"
	network = list("vault")
	start_active = TRUE

/obj/machinery/camera/autoname/vault/Initialize(mapload)
	. = ..()
	upgradeMotion()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/vault, 0)

/obj/machinery/camera/autoname/interrogation
	network = list("ss13","interrogation")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/interrogation, 0)

//AI Cameras
/obj/machinery/camera/autoname/minisat
	network = list("minisat")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/minisat, 0)

/obj/machinery/camera/autoname/aicore
	name = "motion-sensitive security camera"
	network = list("aicore")
	start_active = TRUE

/obj/machinery/camera/autoname/aicore/Initialize(mapload)
	. = ..()
	upgradeMotion()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/aicore, 0)

/obj/machinery/camera/autoname/aiupload
	name = "motion-sensitive security camera"
	network = list("aiupload")
	start_active = TRUE

/obj/machinery/camera/autoname/aiupload/Initialize(mapload)
	. = ..()
	upgradeMotion()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/aiupload, 0)


//Engineering Cameras

/obj/machinery/camera/autoname/engineering
	network = list("ss13","engine")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/engineering, 0)

/obj/machinery/camera/autoname/turbine
	network = list("ss13","engine","turbine")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/turbine, 0)

/obj/machinery/camera/autoname/rbmk
	network = list("ss13","engine","rbmk")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/autoname/rbmk, 0)



