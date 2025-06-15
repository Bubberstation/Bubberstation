#define WIRE_UNLINK "Unlink"
#define WIRE_TEST "Test"
#define WIRE_LINK "Link"

/datum/wires/rbmk2_sniffer
	holder_type = /obj/machinery/rbmk2_sniffer
	proper_name = "RB-MK2 Sniffer"

/datum/wires/rbmk2_sniffer/New(atom/holder)
	wires = list(
		WIRE_SIGNAL,
		WIRE_PROCEED,
		WIRE_LINK,
		WIRE_UNLINK,
		WIRE_TEST
	)
	. = ..()

/datum/wires/rbmk2_sniffer/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/rbmk2_sniffer/M = holder
	return M.panel_open

/datum/wires/rbmk2_sniffer/get_status()
	var/obj/machinery/rbmk2_sniffer/M = holder
	. = list()
	. += "The radio light is [M.radio_enabled ? "blinking red" : "off"]."
	if(M.link_confirm)
		. += "The LED display is displaying \"LINK CONFIRM?\"."
	else if(M.unlink_confirm)
		. += "The LED display is displaying \"UNLINK CONFIRM?\"."
	else
		. += "The LED display is displaying nothing."

/datum/wires/rbmk2_sniffer/on_pulse(wire)
	var/obj/machinery/rbmk2_sniffer/M = holder
	switch(wire)
		if(WIRE_LINK)
			if(M.unlink_confirm || M.link_confirm)
				M.unlink_confirm = FALSE
				M.link_confirm = FALSE
			else
				M.link_confirm = TRUE
		if(WIRE_UNLINK)
			if(M.unlink_confirm || M.link_confirm)
				M.unlink_confirm = FALSE
				M.link_confirm = FALSE
			else
				M.unlink_confirm = TRUE
		if(WIRE_PROCEED)
			if(M.unlink_confirm)
				var/unlink_amount = 0
				for(var/obj/machinery/power/rbmk2/reactor as anything in M.linked_reactors)
					unlink_amount += M.unlink_reactor(null,reactor)
			if(M.link_confirm)
				var/link_amount = 0
				for(var/obj/machinery/power/rbmk2/reactor in range(10,M))
					link_amount += M.link_reactor(null,reactor)
			M.link_confirm = FALSE
			M.unlink_confirm = FALSE
		if(WIRE_TEST)
			M.alert_radio("This is a test message. Do not panic.",alert_emergency_channel=M.test_wire_switch,bypass_cooldown=TRUE)
			M.test_wire_switch = !M.test_wire_switch



/datum/wires/rbmk2_sniffer/on_cut(wire, mend, source)
	var/obj/machinery/rbmk2_sniffer/M = holder
	switch(wire)
		if(WIRE_SIGNAL)
			M.radio_enabled = mend
		if(WIRE_LINK)
			M.link_confirm = FALSE
		if(WIRE_UNLINK)
			M.unlink_confirm = FALSE
		if(WIRE_PROCEED)
			M.link_confirm = FALSE
			M.unlink_confirm = FALSE

/datum/wires/rbmk2_sniffer/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE
	return ..()

#undef WIRE_LINK
#undef WIRE_UNLINK
#undef WIRE_TEST
