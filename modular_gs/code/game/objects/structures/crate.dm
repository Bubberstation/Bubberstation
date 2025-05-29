//gs13 - solar defence crate
/obj/structure/closet/crate/solarpanel_defence
	name = "solar system defence crate"
	icon_state = "engi_e_crate"

/obj/structure/closet/crate/solarpanel_defence/PopulateContents()
	..()
	new /obj/machinery/satellite/meteor_shield(src)
	new /obj/machinery/satellite/meteor_shield(src)
	new /obj/machinery/satellite/meteor_shield(src)
	new /obj/machinery/satellite/meteor_shield(src)
	new /obj/item/paper/guides/jobs/engi/solar_defence(src)
	new /obj/item/circuitboard/computer/sat_control(src)
