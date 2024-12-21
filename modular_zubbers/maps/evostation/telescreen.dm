/obj/machinery/computer/security/telescreen/service
	name = "service monitoring telescreen"
	network = list(CAMERANET_NETWORK_SERVICE)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/service, 32)

/obj/machinery/computer/security/telescreen/command
	name = "command camera access"
	network = list(CAMERANET_NETWORK_COMMAND)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/command, 32)

/obj/machinery/computer/security/telescreen/engineering
	name = "command camera access"
	network = list(CAMERANET_NETWORK_ENGINE, CAMERANET_NETWORK_TELECOMMS, CAMERANET_NETWORK_ENGINEERING)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/engineering, 32)
