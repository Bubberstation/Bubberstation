/obj/machinery/cell_charger/click_alt(mob/user)
	. = ..()
	if(. || !charging)
		return
	to_chat(user, span_notice("You activate the quick release as the cell pops out!"))
	removecell(charging.forceMove(drop_location()))
	return CLICK_ACTION_SUCCESS

/obj/machinery/cell_charger/examine(mob/user)
	. = ..()
	. += span_notice("Alt click it to engage the ejection lever!")
