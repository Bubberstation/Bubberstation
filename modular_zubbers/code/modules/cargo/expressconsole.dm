/obj/item/circuitboard/computer/cargo/express/interdyne
	name = "Interdyne Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express/interdyne

/obj/machinery/computer/cargo/express/interdyne
	name = "interdyne express supply console"
	desc = "A standard NT express console, hacked by Gorlex industries to use \
	their own experimental \"1100mm Rail Cannon\", made to be extra sturdy to prevent \
	being emagged by the syndicate cadets of the SSV Dauntless."
	circuit = /obj/item/circuitboard/computer/cargo/express/interdyne
	req_access = list(ACCESS_SYNDICATE)

	podType = /obj/structure/closet/supplypod/bluespacepod

	cargo_account = ACCOUNT_INT
