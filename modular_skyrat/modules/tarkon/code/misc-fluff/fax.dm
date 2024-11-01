/obj/machinery/fax/tarkon
	name = "Port Tarkon Fax Machine";
	fax_name = "Tarkon Industries Bridge";

/obj/machinery/fax/tarkon/Initialize(mapload)
	. = ..()
	special_networks["tarkon"] = list("fax_name" = "Tarkon TB.", "fax_id" = "tarkon_command", "color" = "brown", "emag_needed" = 0)
