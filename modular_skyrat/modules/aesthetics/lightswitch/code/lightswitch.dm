/obj/machinery/light_switch
	icon = 'modular_skyrat/modules/aesthetics/lightswitch/icons/lightswitch.dmi'

/obj/machinery/light_switch/interact(mob/user)
	. = ..()
	playsound(src, 'modular_skyrat/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 100, 1)

/* /obj/machinery/light_switch/LateInitialize() // BUBBER EDIT REMOVAL BEGIN - CI and aesthetics related.
	. = ..()
	if(prob(50) && area.lightswitch) //50% chance for area to start with lights off.
		turn_off() */ // BUBBER EDIT REMOVAL END

/obj/machinery/light_switch/proc/turn_off()
	if(!area.lightswitch)
		return
	area.lightswitch = FALSE
	area.update_icon()

	for(var/obj/machinery/light_switch/light_switch in area)
		light_switch.update_icon()

	area.power_change()
