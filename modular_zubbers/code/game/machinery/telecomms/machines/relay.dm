/obj/machinery/telecomms/relay/preset/shuttle
	id = "Shuttle Relay"
	autolinkers = list("s_relay")
	icon = 'icons/obj/tram/tram_controllers.dmi'
	icon_state = "tram-controller"
	pixel_x = -2
	pixel_y = -3

/obj/machinery/telecomms/relay/preset/shuttle/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	return // no changing this one's configuration

/obj/machinery/telecomms/relay/preset/shuttle/ui_interact(mob/user, datum/tgui/ui)
	return // no changing this one's configuration
