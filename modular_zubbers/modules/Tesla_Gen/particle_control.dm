/obj/machinery/particle_accelerator/control_box
	name = "Particle Accelerator Control Console"
	desc = "This controls the density of the particles."
	icon = 'modular_zubbers/modules/Tesla_Gen/icon/particle_accelerator.dmi'//Yogs PA Sprites
	icon_state = "control_box"
	anchored = FALSE
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 500
	active_power_usage = 5000 // The power usage when at lvl 0
	dir = NORTH
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	var/strength_upper_limit = 2
	var/interface_control = TRUE
	var/list/obj/structure/particle_accelerator/connected_parts
	var/assembled = FALSE
	var/construction_state = PA_CONSTRUCTION_UNSECURED
	var/active = FALSE
	var/strength = 0
	var/powered = FALSE
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	var/area_restricted = TRUE //is this PA locked to area/engine or not?
	var/locked = TRUE //can are_restricted be toggled?
	req_access = list(ACCESS_CE)
	var/mob/living/operator

/obj/machinery/particle_accelerator/control_box/Initialize(mapload)
	. = ..()
	wires = new /datum/wires/particle_accelerator/control_box(src)
	connected_parts = list()

/obj/machinery/particle_accelerator/control_box/Destroy()
	if(active)
		toggle_power()
	for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
		part.master = null
	connected_parts.Cut()
	QDEL_NULL(wires)
	return ..()

/obj/machinery/particle_accelerator/control_box/multitool_act(mob/living/user, obj/item/I)
	..()
	if(construction_state == PA_CONSTRUCTION_PANEL_OPEN)
		wires.interact(user)
		return TRUE

/obj/machinery/particle_accelerator/control_box/proc/update_state()
	if(construction_state < PA_CONSTRUCTION_COMPLETE)
		use_power = NO_POWER_USE
		assembled = FALSE
		active = FALSE
		for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
			part.strength = null
			part.powered = FALSE
			part.update_appearance(UPDATE_ICON)
		connected_parts.Cut()
		return
	if(!part_scan())
		use_power = IDLE_POWER_USE
		active = FALSE
		connected_parts.Cut()

/obj/machinery/particle_accelerator/control_box/update_icon_state()
	. = ..()
	if(active)
		icon_state = "control_boxp[strength]" //yogs- fix sprite not updating
		return
	if(use_power)
		if(assembled)
			icon_state = "control_boxp"
		else
			icon_state = "ucontrol_boxp"
		return
	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED, PA_CONSTRUCTION_UNWIRED)
			icon_state = "control_box"
		if(PA_CONSTRUCTION_PANEL_OPEN)
			icon_state = "control_boxw"
		else
			icon_state = "control_boxc"

/obj/machinery/particle_accelerator/control_box/proc/strength_change()
	for(var/CP in connected_parts)
		var/obj/structure/particle_accelerator/part = CP
		part.strength = strength
		part.update_icon()

/obj/machinery/particle_accelerator/control_box/proc/add_strength(s)
	if(assembled && (strength < strength_upper_limit))
		strength++
		strength_change()

		message_admins("PA Control Computer increased to [strength] by [ADMIN_LOOKUPFLW(usr)] in [ADMIN_VERBOSEJMP(src)]")
		log_game("PA Control Computer increased to [strength] by [key_name(usr)] in [AREACOORD(src)]")
		investigate_log("increased to <font color='red'>[strength]</font> by [key_name(usr)] at [AREACOORD(src)]")

/obj/machinery/particle_accelerator/control_box/proc/remove_strength(s)
	if(assembled && (strength > 0))
		strength--
		strength_change()

		message_admins("PA Control Computer decreased to [strength] by [ADMIN_LOOKUPFLW(usr)] in [ADMIN_VERBOSEJMP(src)]")
		log_game("PA Control Computer decreased to [strength] by [key_name(usr)] in [AREACOORD(src)]")
		investigate_log("decreased to <font color='green'>[strength]</font> by [key_name(usr)] at [AREACOORD(src)]")

/obj/machinery/particle_accelerator/control_box/power_change()
	. = ..()
	if(machine_stat & NOPOWER)
		active = FALSE
		use_power = NO_POWER_USE
	else if(!machine_stat && construction_state == PA_CONSTRUCTION_COMPLETE)
		use_power = IDLE_POWER_USE

/obj/machinery/particle_accelerator/control_box/process()
	if(active)
		//a part is missing!
		if(connected_parts.len < 6)
			investigate_log("lost a connected part; It <font color='red'>powered down</font>.")
			toggle_power()
			update_icon()
			return
		//emit some particles
		for(var/obj/structure/particle_accelerator/particle_emitter/PE in connected_parts)
			PE.emit_particle(strength)

/obj/machinery/particle_accelerator/control_box/proc/part_scan()
	var/ldir = turn(dir,-90)
	var/rdir = turn(dir,90)
	var/odir = turn(dir,180)
	var/turf/T = loc

	assembled = FALSE
	critical_machine = FALSE

	var/obj/structure/particle_accelerator/fuel_chamber/F = locate() in orange(1,src)
	if(!F)
		return FALSE

	setDir(F.dir)
	connected_parts.Cut()

	T = get_step(T,rdir)
	if(!check_part(T, /obj/structure/particle_accelerator/fuel_chamber))
		return FALSE
	T = get_step(T,odir)
	if(!check_part(T, /obj/structure/particle_accelerator/end_cap))
		return FALSE
	T = get_step(T,dir)
	T = get_step(T,dir)
	if(!check_part(T, /obj/structure/particle_accelerator/power_box))
		return FALSE
	T = get_step(T,dir)
	if(!check_part(T, /obj/structure/particle_accelerator/particle_emitter/center))
		return FALSE
	T = get_step(T,ldir)
	if(!check_part(T, /obj/structure/particle_accelerator/particle_emitter/left))
		return FALSE
	T = get_step(T,rdir)
	T = get_step(T,rdir)
	if(!check_part(T, /obj/structure/particle_accelerator/particle_emitter/right))
		return FALSE

	assembled = TRUE
	critical_machine = TRUE	//Only counts if the PA is actually assembled.
	return TRUE

/obj/machinery/particle_accelerator/control_box/proc/check_part(turf/T, type)
	var/obj/structure/particle_accelerator/PA = locate(/obj/structure/particle_accelerator) in T
	if(istype(PA, type) && (PA.construction_state == PA_CONSTRUCTION_COMPLETE))
		if(PA.connect_master(src))
			connected_parts.Add(PA)
			return TRUE
	return FALSE


/obj/machinery/particle_accelerator/control_box/proc/toggle_power()
	active = !active
	investigate_log("turned [active?"<font color='green'>ON</font>":"<font color='red'>OFF</font>"] by [usr ? key_name(usr) : "outside forces"] at [AREACOORD(src)]")
	message_admins("PA Control Computer turned [active ?"ON":"OFF"] by [usr ? ADMIN_LOOKUPFLW(usr) : "outside forces"] in [ADMIN_VERBOSEJMP(src)]")
	log_game("PA Control Computer turned [active ?"ON":"OFF"] by [usr ? "[key_name(usr)]" : "outside forces"] at [AREACOORD(src)]")
	if(active)
		use_power = ACTIVE_POWER_USE
		for(var/CP in connected_parts)
			var/obj/structure/particle_accelerator/part = CP
			part.strength = strength
			part.powered = TRUE
			part.update_icon()
	else
		use_power = IDLE_POWER_USE
		for(var/CP in connected_parts)
			var/obj/structure/particle_accelerator/part = CP
			part.strength = null
			part.powered = FALSE
			part.update_icon()
	return TRUE


/obj/machinery/particle_accelerator/control_box/examine(mob/user)
	. = ..()
	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED)
			. += "Looks like it's not attached to the flooring."
		if(PA_CONSTRUCTION_UNWIRED)
			. += "It is missing some cables."
		if(PA_CONSTRUCTION_PANEL_OPEN)
			. += "The panel is open."

/obj/machinery/particle_accelerator/control_box/set_anchored(anchorvalue)
	. = ..()
	if(isnull(.))
		return
	construction_state = anchorvalue ? PA_CONSTRUCTION_UNWIRED : PA_CONSTRUCTION_UNSECURED
	update_state()
	update_icon()


/obj/machinery/particle_accelerator/control_box/attackby(obj/item/W, mob/user, params)
	var/did_something = FALSE

	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED)
			if(W.tool_behaviour == TOOL_WRENCH && !isinspace())
				W.play_tool_sound(src, 75)
				anchored = TRUE
				user.visible_message("[user.name] secures the [name] to the floor.", \
					"You secure the external bolts.")
				construction_state = PA_CONSTRUCTION_UNWIRED
				did_something = TRUE
		if(PA_CONSTRUCTION_UNWIRED)
			if(W.tool_behaviour == TOOL_WRENCH)
				W.play_tool_sound(src, 75)
				anchored = FALSE
				user.visible_message("[user.name] detaches the [name] from the floor.", \
					"You remove the external bolts.")
				construction_state = PA_CONSTRUCTION_UNSECURED
				did_something = TRUE
			else if(istype(W, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/CC = W
				if(CC.use(1))
					user.visible_message("[user.name] adds wires to the [name].", \
						"You add some wires.")
					construction_state = PA_CONSTRUCTION_PANEL_OPEN
					did_something = TRUE
		if(PA_CONSTRUCTION_PANEL_OPEN)
			if(W.tool_behaviour == TOOL_WIRECUTTER)//TODO:Shock user if its on?
				user.visible_message("[user.name] removes some wires from the [name].", \
					"You remove some wires.")
				construction_state = PA_CONSTRUCTION_UNWIRED
				did_something = TRUE
			else if(W.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message("[user.name] closes the [name]'s access panel.", \
					"You close the access panel.")
				construction_state = PA_CONSTRUCTION_COMPLETE
				did_something = TRUE
		if(PA_CONSTRUCTION_COMPLETE)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message("[user.name] opens the [name]'s access panel.", \
					"You open the access panel.")
				construction_state = PA_CONSTRUCTION_PANEL_OPEN
				did_something = TRUE

	if(did_something)
		user.changeNext_move(CLICK_CD_MELEE)
		update_state()
		update_appearance(UPDATE_ICON)
		return

	..()

/obj/machinery/particle_accelerator/control_box/blob_act(obj/structure/blob/B)
	if(prob(50))
		qdel(src)

/obj/machinery/particle_accelerator/control_box/interact(mob/user)
	if(construction_state == PA_CONSTRUCTION_PANEL_OPEN)
		wires.interact(user)
	else
		..()

/obj/machinery/particle_accelerator/control_box/proc/is_interactive(mob/user)
	if(!interface_control)
		to_chat(user, span_alert("ERROR: Request timed out. Check wire contacts."))
		return FALSE
	if(construction_state != PA_CONSTRUCTION_COMPLETE)
		return FALSE
	return TRUE

/obj/machinery/particle_accelerator/control_box/ui_status(mob/user)
	if(is_interactive(user))
		return ..()
	if(operator == user)
		operator = null
	return UI_CLOSE

/obj/machinery/particle_accelerator/control_box/ui_interact(mob/user, datum/tgui/ui)
	operator = user
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ParticleAccelerator", name)
		ui.open()

/obj/machinery/particle_accelerator/control_box/ui_data(mob/user)
	var/list/data = list()
	data["assembled"] = assembled
	data["power"] = active
	data["strength"] = strength
	data["locked"] = locked
	data["area_restricted"] = area_restricted
	return data

/obj/machinery/particle_accelerator/control_box/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("power")
			if(wires.is_cut(WIRE_POWER))
				return
			toggle_power()
			. = TRUE
		if("scan")
			part_scan()
			. = TRUE
		if("add_strength")
			if(wires.is_cut(WIRE_STRENGTH))
				return
			add_strength()
			. = TRUE
		if("remove_strength")
			if(wires.is_cut(WIRE_STRENGTH))
				return
			remove_strength()
			. = TRUE
		if("toggle_lock")
			if(!operator)
				return
			if(!allowed(operator))
				to_chat(operator, span_danger("Access denied."))
				return
			if(obj_flags & EMAGGED)
				to_chat(operator,"The locking mechanism glitches out.")
				locked = FALSE //sanity check
				return
			locked = !locked
			to_chat(operator, "You [locked ? "enable" : "disable"] the toggle lock.")
			. = TRUE
		if("toggle_arearestriction")
			if(!operator)
				return
			if(obj_flags & EMAGGED)
				to_chat(operator,"The area restriction mechanism glitches out.")
				area_restricted = FALSE //sanity check
				return
			if(locked)
				to_chat(operator, "The toggle is locked!")
				return
			area_restricted = !area_restricted
			to_chat(operator, "You [locked ? "enable" : "disable"] the area restriction.");
			. = TRUE

	update_appearance(UPDATE_ICON)

/obj/machinery/particle_accelerator/control_box/charlie //for charlie station
	locked = FALSE
	area_restricted = FALSE

#undef PA_CONSTRUCTION_UNSECURED
#undef PA_CONSTRUCTION_UNWIRED
#undef PA_CONSTRUCTION_PANEL_OPEN
#undef PA_CONSTRUCTION_COMPLETE
