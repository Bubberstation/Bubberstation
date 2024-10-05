/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["open_door"])
		var/obj/machinery/door/airlock/door = locate(href_list["open_door"]) in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock)
		var/mob/living/requester = locate(href_list["user"]) in GLOB.mob_list
		var/action = href_list["action"]

		if(!requester)
			return
		if(!door)
			return
		fulfill_door_request(requester, door, action)

///Allows the AI to interact somewhat with a door if the requester can be tracked by cameras and the AI can normally access it.
/mob/living/silicon/proc/fulfill_door_request(mob/living/requester, obj/machinery/door/airlock/door, action)
	if(!istype(requester))
		return
	if(!istype(door))
		return

	if(!requester.can_track(src))
		to_chat(src, span_notice("Unable to track requester."))
		return

	if(door.aiControlDisabled != AI_WIRE_NORMAL)
		to_chat(src, span_notice("Unable to access airlock"))
		return


	switch(action)
		if("open")
			if(door.locked)
				door.unbolt()
			door.open()
			to_chat(src, "<span class='notice'>You open the [door] for [requester].</span>")
		if("bolt")
			if(!door.locked)
				door.bolt()
				door.visible_message(span_danger("Wow you really pissed [src] off, they bolted the door in your face!"), vision_distance = COMBAT_MESSAGE_RANGE)
		if("shock")
			door.set_electrified(MACHINE_DEFAULT_ELECTRIFY_TIME)
			door.visible_message(span_notice("The door buzzes, [src] has denied your request"), vision_distance = COMBAT_MESSAGE_RANGE)
		if("deny")
			door.visible_message(span_notice("The door buzzes, [src] has denied your request"), vision_distance = COMBAT_MESSAGE_RANGE)
			to_chat(src, "You deny [requester]'s request")
