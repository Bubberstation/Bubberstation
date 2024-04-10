//Upload Circuitboard GPS

/obj/item/circuitboard/computer/aiupload/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Inactive Upload Device")

/obj/item/circuitboard/computer/borgupload/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Inactive Upload Device")
