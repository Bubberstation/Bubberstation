/obj/machinery/light_switch
	icon = 'modular_skyrat/modules/aesthetics/lightswitch/icons/lightswitch.dmi'

/obj/machinery/light_switch/interact(mob/user)
	. = ..()
	playsound(src, 'modular_skyrat/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 100, 1)

#ifndef UNIT_TESTS
/obj/machinery/light_switch/post_machine_initialize()
	. = ..()
	if(prob(50) && area.lightswitch) //50% chance for area to start with lights off.
		set_lights(FALSE)
#endif

/obj/machinery/light_switch/default_on

/obj/machinery/light_switch/default_on/post_machine_initialize()
	. = ..()
	set_lights(TRUE)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light_switch/default_on, 26)
