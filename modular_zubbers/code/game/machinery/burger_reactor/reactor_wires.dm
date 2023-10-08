/datum/wires/rbmk2
	holder_type = /obj/machinery/power/rbmk2
	proper_name = "RB-MK2"

/datum/wires/rbmk2/New(atom/holder)
	wires = list(
		WIRE_OVERCLOCK,
		WIRE_ACTIVATE,
		WIRE_DISABLE,
		WIRE_THROW,
		WIRE_LOCKDOWN,
		WIRE_SAFETY,
		WIRE_LIMIT
	)
	add_duds(2)
	. = ..()

/datum/wires/rbmk2/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/power/rbmk2/M = holder
	return M.panel_open

/datum/wires/rbmk2/get_status()
	var/obj/machinery/power/rbmk2/M = holder
	. = list()
	. += "The overclock light is [M.overclocked ? "blinking blue" : "off"]."
	. += "The power light is [M.active ? "yellow" : "off"]."
	. += "The occupancy light is [M.stored_rod ? "orange" : "off"]."
	. += "The vent light is [M.venting ? "green" : "flashing red"]."
	. += "The safety light is [M.safety ? "blue" : "flashing yellow"]."
	. += "The heat transfer limiter digitial display reads [25 + M.limit]%"

/datum/wires/rbmk2/on_pulse(wire)
	var/obj/machinery/power/rbmk2/M = holder
	switch(wire)
		if(WIRE_OVERCLOCK)
			M.overclocked = !M.overclocked
		if(WIRE_ACTIVATE)
			M.toggle()
		if(WIRE_DISABLE)
			M.toggle(FALSE)
		if(WIRE_THROW)
			M.remove_rod()
		if(WIRE_LOCKDOWN)
			M.venting = !M.venting
		if(WIRE_SAFETY)
			M.toggle(FALSE)
		if(WIRE_LIMIT)
			M.limit = (M.limit + 5) % M.limit_max

/datum/wires/rbmk2/on_cut(wire, mend, source)
	var/obj/machinery/power/rbmk2/M = holder
	switch(wire)
		if(WIRE_OVERCLOCK)
			if(mend)
				M.overclocked = FALSE
		if(WIRE_ACTIVATE)
			M.toggle(mend)
		if(WIRE_DISABLE)
			if(mend)
				M.toggle(FALSE)
		if(WIRE_THROW)
			if(mend)
				M.remove_rod()
		if(WIRE_LOCKDOWN)
			if(mend)
				M.venting = FALSE
		if(WIRE_SAFETY)
			M.safety = mend
		if(WIRE_LIMIT)
			if(mend)
				M.limit = 0