/obj/machinery/cryopod/tele //lore-friendly cryo thing
	name = "Long-range Central Command teleporter"
	desc = "A special mobility sleeper for storing agents in a disclosed location."
	icon = 'modular_gs/icons/obj/Cryogenic2.dmi'
	icon_state = "telepod-open"
	on_store_message = "has teleported back to Central Command."
	on_store_name = "Teleporter Oversight"

/obj/machinery/cryopod/tele/open_machine(drop = TRUE, density_to_set = FALSE)
	..()
	icon_state = "telepod-open"

/obj/machinery/cryopod/tele/close_machine(atom/movable/target, density_to_set = TRUE)
	..()
	icon_state = "telepod"

/obj/machinery/cryopod
	/// Do we want to inform comms when someone cryos?
	var/alert_comms = TRUE
	var/on_store_message = "has entered long-term storage."
	var/on_store_name = "Cryogenic Oversight"
