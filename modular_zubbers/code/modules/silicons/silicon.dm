/mob/living/silicon/proc/open_door(mob/living/target, obj/machinery/door/airlock/door)
	if(!istype(target))
		return
	if(!istype(door))
		return

	if(!target.can_track(src))
		to_chat(src, "Unable to track target.")
		return

	if(istype(door))
		switch(alert(src, "Do you want to open the [door] for [target]?", "Doorknob_v2a.exe", "Yes", "No"))
			if("Yes")
				door.open()
				to_chat(src, "<span class='notice'>You open the [door] for [target].</span>")
			else
				to_chat(src, "<span class='warning'>You deny the request.</span>")
