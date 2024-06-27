/obj/machinery/computer/camera_advanced/base_construction/broadcast
	name = "set construction console"
	circuit = /obj/item/circuitboard/computer/base_construction/broadcast
	allowed_area = /area/station/service/studio/stage
	internal_rcd = /obj/item/construction/rcd/internal/broadcast

/obj/machinery/computer/camera_advanced/base_construction/broadcast/Initialize(mapload)
	internal_rcd = new(src)
	return ..()

/obj/machinery/computer/camera_advanced/base_construction/broadcast/restock_materials()
	internal_rcd.matter = internal_rcd.max_matter

/obj/machinery/computer/camera_advanced/base_construction/broadcast/populate_actions_list()
	actions += new /datum/action/innate/construction/configure_mode(src) //Action for switching the RCD's build modes
	actions += new /datum/action/innate/construction/build(src) //Action for using the RCD
