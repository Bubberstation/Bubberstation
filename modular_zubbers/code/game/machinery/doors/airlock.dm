/obj/machinery/door/airlock/try_to_crowbar(obj/item/I, mob/living/user, forced = FALSE)
	if(I?.tool_behaviour == TOOL_CROWBAR && should_try_removing_electronics() && !operating)
		user.visible_message(span_notice("[user] removes the electronics from the airlock assembly."), \
			span_notice("You start to remove electronics from the airlock assembly..."))
		if(I.use_tool(src, user, 40, volume=100))
			deconstruct(TRUE, user)
			return
	if(seal)
		to_chat(user, span_warning("Remove the seal first!"))
		return
	if(locked)
		to_chat(user, span_warning("The airlock's bolts prevent it from being forced!"))
		return
	if(welded)
		to_chat(user, span_warning("It's welded, it won't budge!"))
		return
	if(hasPower())
		if(forced)
			var/check_electrified = isElectrified() //setting this so we can check if the mob got shocked during the do_after below
			if(check_electrified && shock(user,100))
				return //it's like sticking a fork in a power socket

			if(!density)//already open
				return

			if(!prying_so_hard)
				var/time_to_open = 50
				playsound(src, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE) //is it aliens or just the CE being a dick?
				prying_so_hard = TRUE
				if(do_after(user, time_to_open, src))
					if(check_electrified && shock(user,100))
						prying_so_hard = FALSE
						return
					open(BYPASS_DOOR_CHECKS)
					if(istype(I, /obj/item/crowbar/large/doorforcer))
						to_chat (user, span_warning("Forcing the door open with the prybar has caused the tool to break!"))
						qdel(I)
					take_damage(25, BRUTE, 0, 0) // Enough to sometimes spark
					if(density && !open(BYPASS_DOOR_CHECKS))
						to_chat(user, span_warning("Despite your attempts, [src] refuses to open."))
				prying_so_hard = FALSE
				return
		to_chat(user, span_warning("The airlock's motors resist your efforts to force it!"))
		return
