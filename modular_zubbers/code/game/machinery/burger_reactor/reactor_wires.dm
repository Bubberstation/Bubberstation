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

/datum/wires/rbmk2/emp_pulse()
	return TRUE //Handled already in the RBMK.

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
	. += "The cooling limiter display reads [M.cooling_limiter]%"

/datum/wires/rbmk2/on_pulse(wire)
	var/obj/machinery/power/rbmk2/M = holder
	switch(wire)
		if(WIRE_OVERCLOCK)
			M.overclocked = !M.overclocked
		if(WIRE_ACTIVATE)
			M.toggle_active(usr)
		if(WIRE_DISABLE)
			M.toggle_active(usr,FALSE)
		if(WIRE_THROW)
			M.remove_rod(usr,do_throw=TRUE)
		if(WIRE_LOCKDOWN)
			M.toggle_vents(usr)
		if(WIRE_SAFETY)
			M.toggle_active(usr,FALSE)
		if(WIRE_LIMIT)
			M.cooling_limiter = (M.cooling_limiter + 10) % M.cooling_limiter_max

/datum/wires/rbmk2/on_cut(wire, mend, source)
	var/obj/machinery/power/rbmk2/M = holder
	switch(wire)
		if(WIRE_OVERCLOCK)
			if(mend)
				M.overclocked = FALSE
		if(WIRE_ACTIVATE)
			M.toggle_active(usr,mend)
		if(WIRE_DISABLE)
			if(mend)
				M.toggle_active(usr,FALSE)
		if(WIRE_THROW)
			if(mend)
				M.remove_rod(usr,do_throw=TRUE)
		if(WIRE_LOCKDOWN)
			if(mend)
				M.toggle_vents(usr,FALSE)
		if(WIRE_SAFETY)
			M.safety = mend
			if(!mend)
				var/turf/T = get_turf(M)
				if(usr)
					message_admins("[src] had the safety wire cut by [ADMIN_LOOKUPFLW(usr)] at [ADMIN_VERBOSEJMP(T)].")
					usr.log_message("cut the safety wire of [M]", LOG_GAME)
					M.investigate_log("had the safety wire cut by [key_name(usr)] at [AREACOORD(M)].", INVESTIGATE_ENGINE)
				else
					message_admins("[src] had the safety wire cut at [ADMIN_VERBOSEJMP(T)]")
					log_game("[src] had the safety wire cut at [AREACOORD(T)]")
					M.investigate_log("had the safety wire cut at [AREACOORD(T)]", INVESTIGATE_ENGINE)
		if(WIRE_LIMIT)
			if(mend)
				M.cooling_limiter = 0

/datum/wires/rbmk2/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE
	return ..()
