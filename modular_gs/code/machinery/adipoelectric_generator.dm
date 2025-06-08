/obj/machinery/power/adipoelectric_generator
	name = "adipoelectric generator"
	desc = "This device uses calorite technology to transform excess blubber into power!"
	icon = 'modular_gs/icons/obj/adipoelectric_transformer.dmi'
	icon_state = "state_off"
	density = FALSE
	anchored = FALSE
	use_power = NO_POWER_USE
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/power/adipoelectric_generator
	occupant_typecache = list(/mob/living/carbon)
	var/laser_modifier
	var/max_fat
	var/obj/structure/cable/attached
	var/conversion_rate = 10000
	var/emp_timer = 0
	var/active = FALSE

/obj/machinery/power/adipoelectric_generator/Initialize(mapload)
	. = ..()
	if(anchored)
		connect_to_network()
	update_icon()

/obj/machinery/power/adipoelectric_generator/RefreshParts()
	laser_modifier = 0
	max_fat = 0
	for(var/obj/item/stock_parts/micro_laser/C in component_parts)
		laser_modifier += C.rating
	for(var/obj/item/stock_parts/matter_bin/C in component_parts)
		max_fat += C.rating * 2

/obj/machinery/power/adipoelectric_generator/process()
	if(!occupant)
		src.visible_message("<span class='alert'>The [src] buzzes. It needs someone inside.</span>")
		playsound(src, 'sound/machines/buzz-two.ogg', 50)
		return PROCESS_KILL
	if(occupant:fatness_real > 0 && powernet && anchored && (emp_timer < world.time))
		active = TRUE
		add_avail(conversion_rate * laser_modifier * max_fat)
		occupant:adjust_fatness(-max_fat, FATTENING_TYPE_ITEM)
	else
		active = FALSE
	update_icon()

/obj/machinery/power/adipoelectric_generator/relaymove(mob/user)
	if(user.stat)
		return
	open_machine()

/obj/machinery/power/adipoelectric_generator/emp_act(severity)
	. = ..()
	if(!(machine_stat & (BROKEN|NOPOWER)))
		emp_timer = world.time + 600
		if(occupant)
			src.visible_message("<span class='alert'>The [src] buzzes and expels anyone inside!.</span>")
			open_machine()

/obj/machinery/power/adipoelectric_generator/attackby(obj/item/P, mob/user, params)
	if(state_open)
		if(default_deconstruction_screwdriver(user, "state_open", "state_off", P))
			return

	if(default_pry_open(P))
		return

	if(default_deconstruction_crowbar(P))
		return

	if(P.tool_behaviour == TOOL_WRENCH && !active)
		if(!anchored && !isinspace())
			connect_to_network()
			to_chat(user, "<span class='notice'>You secure the generator to the floor.</span>")
			anchored = TRUE
			dir = SOUTH
		else if(anchored)
			disconnect_from_network()
			to_chat(user, "<span class='notice'>You unsecure the generator from the floor.</span>")
			anchored = FALSE
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
		return

	return ..()

/obj/machinery/power/adipoelectric_generator/interact(mob/user)
	toggle_open()
	return TRUE

/obj/machinery/power/adipoelectric_generator/proc/toggle_open()
	if(state_open)
		close_machine()
	else
		open_machine()
	update_icon()

/obj/machinery/power/adipoelectric_generator/open_machine()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/power/adipoelectric_generator/close_machine()
	. = ..()
	if(occupant && anchored && !panel_open)
		add_fingerprint(occupant)
		START_PROCESSING(SSobj, src)
	else
		src.visible_message("<span class='alert'>[src] needs to be anchored to a working wire and have a person going inside!</span>")
		open_machine()

/obj/machinery/power/adipoelectric_generator/update_icon()
	cut_overlays()
	if(panel_open)
		icon_state = "state_open"
		return
	if(occupant)
		var/image/occupant_overlay
		occupant_overlay = image(occupant.icon, occupant.icon_state)
		occupant_overlay.copy_overlays(occupant)
		occupant_overlay.dir = SOUTH
		occupant_overlay.pixel_y = 10
		add_overlay(occupant_overlay)
		if(!active)
			icon_state = "state_off"
		else
			icon_state = "state_on"
	else
		icon_state = "state_off"

/obj/machinery/power/adipoelectric_generator/power_change()
	..()
	update_icon()

/obj/machinery/power/adipoelectric_generator/Destroy()
	. = ..()

/obj/machinery/power/adipoelectric_generator/examine(mob/user)
	. = ..()
	if(is_operational())
		. += "<span class='notice'>[src]'s show it can produce <b>[conversion_rate * laser_modifier]W</b> per adipose unit, taking in <b>[max_fat]</b> max each time.</span>"
	else
		. += "<span class='notice'><b>[src]'s display is currently offline.</b></span>"

/obj/item/circuitboard/machine/power/adipoelectric_generator
	name = "Adipoelectric Generator (Machine Board)"
	build_path = /obj/machinery/power/adipoelectric_generator
	req_components = list(
		/obj/item/stock_parts/micro_laser = 5,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2)
	needs_anchored = FALSE

/datum/design/board/adipoelectric_generator
	name = "Machine Design (Adipoelectric Generator Board)"
	desc = "The circuit board for an Adipoelectric Generator."
	id = "adipoelectric_generator"
	build_path = /obj/item/circuitboard/machine/power/adipoelectric_generator
	category = list("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING
