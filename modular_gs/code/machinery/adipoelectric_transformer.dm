GLOBAL_LIST_EMPTY(adipoelectric_transformer)

/obj/machinery/adipoelectric_transformer
	name = "adipoelectric transformer"
	desc = "This device uses calorite technology to store excess current in the wire it's placed on into whoever steps on!"
	icon = 'modular_gs/icons/obj/adipoelectric_transformer.dmi'
	icon_state = "state_off"
	density = FALSE
	use_power = NO_POWER_USE
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/adipoelectric_transformer
	occupant_typecache = list(/mob/living/carbon)
	var/recharge_speed
	var/obj/structure/cable/attached
	var/drain_rate = 1000000
	var/lastprocessed = 0
	var/power_avaliable = 0
	var/conversion_rate = 0.000001
	var/emp_timer = 0
	var/emp_multiplier = 5
	var/datum/powernet/PN

/obj/machinery/adipoelectric_transformer/Initialize(mapload)
	. = ..()
	update_icon()

/obj/machinery/adipoelectric_transformer/RefreshParts()
	recharge_speed = 0
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		recharge_speed += C.rating

/obj/machinery/adipoelectric_transformer/process()
	if(!is_operational())
		return
	if(!attached)
		src.visible_message("<span class='alert'>[src] buzzes. Seems like it's not attached to a working power net.</span>")
		playsound(src, 'sound/machines/buzz-two.ogg', 50)
		return PROCESS_KILL
	PN = attached.powernet
	if(PN)
		power_avaliable = PN.netexcess
		update_icon()
		if(power_avaliable <= 0)
			return
		if(occupant)
			if(power_avaliable > drain_rate)
				lastprocessed = ((power_avaliable - drain_rate) * (conversion_rate / 10)) + 1
			else
				lastprocessed = power_avaliable * conversion_rate
			if(!(world.time >= emp_timer + 600))
				lastprocessed = lastprocessed * emp_multiplier
			occupant:adjust_fatness(lastprocessed * recharge_speed, FATTENING_TYPE_ITEM)
	return TRUE

/obj/machinery/adipoelectric_transformer/relaymove(mob/user)
	if(user.stat)
		return
	open_machine()

/obj/machinery/adipoelectric_transformer/emp_act(severity)
	. = ..()
	if(!(machine_stat & (BROKEN|NOPOWER)))
		if(occupant)
			src.visible_message("<span class='alert'>[src] emits ominous cracking noises!</span>")
			emp_timer = world.time //stuck in for 600 ticks, about 60 seconds

/obj/machinery/adipoelectric_transformer/attackby(obj/item/P, mob/user, params)
	if(state_open)
		if(default_deconstruction_screwdriver(user, "state_open", "state_off", P))
			return

	if(default_pry_open(P))
		return

	if(default_deconstruction_crowbar(P))
		return
	return ..()

/obj/machinery/adipoelectric_transformer/interact(mob/user)
	toggle_open()
	return TRUE

/obj/machinery/adipoelectric_transformer/proc/toggle_open()
	if(state_open)
		close_machine()
	else
		open_machine()
	update_icon()

/obj/machinery/adipoelectric_transformer/open_machine()
	if(!(world.time >= emp_timer + 600))
		return
	. = ..()
	GLOB.adipoelectric_transformer -= src
	STOP_PROCESSING(SSobj, src)

/obj/machinery/adipoelectric_transformer/close_machine()
	. = ..()
	if(LAZYLEN(GLOB.adipoelectric_transformer) < 1 && occupant)
		var/turf/T = loc
		if(isturf(T) && !T.intact)
			attached = locate() in T
		add_fingerprint(occupant)
		GLOB.adipoelectric_transformer += src
		START_PROCESSING(SSobj, src)
	else
		src.visible_message("<span class='alert'>[src] buzzes. There must be another a person going in an no other transformer active in the area.</span>")
		playsound(src, 'sound/machines/buzz-two.ogg', 50)
		open_machine()

/obj/machinery/adipoelectric_transformer/update_icon()
	cut_overlays()
	if(occupant)
		var/image/occupant_overlay
		occupant_overlay = image(occupant.icon, occupant.icon_state)
		occupant_overlay.copy_overlays(occupant)
		occupant_overlay.dir = SOUTH
		occupant_overlay.pixel_y = 10
		add_overlay(occupant_overlay)
		if(power_avaliable <= 0)
			icon_state = "state_off"
		else
			if(!(world.time >= emp_timer + 600))
				icon_state = "state_overdrive"
				add_overlay("particles_overdrive")
			else
				icon_state = "state_on"
				add_overlay("particles_on")
	else
		icon_state = "state_off"

/obj/machinery/adipoelectric_transformer/power_change()
	..()
	update_icon()

/obj/machinery/adipoelectric_transformer/Destroy()
	. = ..()
	GLOB.adipoelectric_transformer -= src

/obj/machinery/adipoelectric_transformer/examine(mob/user)
	. = ..()
	if(is_operational() && attached)
		if(PN)
			if(lastprocessed)
				. += "<span class='notice'>[src]'s last reading on display was <b>[lastprocessed * recharge_speed]</b> adipose units.</span>"
			else
				. += "<span class='notice'>[src] has no last reading.</span>"
		else
			. += "<span class='notice'>[src]'s display states 'ERROR'. There must be something wrong with the power.</b></span>"
	else
		. += "<span class='notice'><b>[src]'s display is currently offline.</b></span>"

/obj/item/circuitboard/machine/adipoelectric_transformer
	name = "Adipoelectric Transformer (Machine Board)"
	build_path = /obj/machinery/adipoelectric_transformer
	req_components = list(
		/obj/item/stock_parts/capacitor = 5,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/mineral/calorite = 1)

/datum/design/board/adipoelectric_transformer
	name = "Machine Design (Adipoelectric Transformer Board)"
	desc = "The circuit board for an Adipoelectric Transformer."
	id = "adipoelectric_transformer"
	build_path = /obj/item/circuitboard/machine/adipoelectric_transformer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING
