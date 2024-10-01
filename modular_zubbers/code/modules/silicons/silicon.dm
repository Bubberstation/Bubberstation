///Allows the AI to interact somewhat with a door if the requester can be tracked by cameras and the AI can normally access it.
/mob/living/silicon/proc/fulfill_door_request(mob/living/requester, obj/machinery/door/airlock/door)
	if(!istype(requester))
		return
	if(!istype(door))
		return

	if(!requester.can_track(src))
		to_chat(src, "Unable to track requester.")
		return

	if(door.aiControlDisabled != AI_WIRE_NORMAL)
		to_chat(src, "Unable to access airlock")


	var/list/actions = list(
		"Open door",
		"Bolt door",
		"Shock door",
		"Deny request",
	)
	var/choice = tgui_input_list(src, "How would you like to fulfill the request?", "Action Selection", actions)
	switch(choice)
		if("Open door")
			if(door.locked)
				door.unbolt()
			door.open()
			to_chat(src, "<span class='notice'>You open the [door] for [requester].</span>")
		if("Bolt door")
			if(!door.locked)
				door.bolt()
			to_chat(requester, "Wow you really pissed [src] off, they bolted the door in your face!")
		if("Shock door")
			door.set_electrified(MACHINE_DEFAULT_ELECTRIFY_TIME)
			to_chat(requester, "[src] has denied your request")
		if("Deny request")
			to_chat(requester, "[src] has denied your request")
			to_chat(src, "You deny [requester]'s request")
