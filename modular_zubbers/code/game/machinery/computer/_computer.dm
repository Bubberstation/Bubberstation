/obj/machinery/computer
	impact_sound = SFX_BULLET_IMPACT_GLASS
	///Determines if the computer can connect to other computers (no arcades, etc.)
	var/connectable = TRUE

	var/clicksound = "keyboard"
	var/clickvol = 40
	var/next_clicksound

/obj/machinery/computer/interact(mob/user, special_state)
	. = ..()
	if(clicksound && world.time > next_clicksound && isliving(user))
		next_clicksound = world.time + 5
		playsound(src, get_sfx_skyrat(clicksound), clickvol)

/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(connectable)
		AddElement(/datum/element/connectable_computer)

/obj/machinery/computer/Destroy(force)
	// we need to do it like this because if we remove the element before ..() is called,
	// this is still a computer so other computers still connect to it
	// and if we do it after, without storing the loc, the computer is in nullspace,
	// so other computers don't get notified
	var/old_loc = loc
	. = ..()
	RemoveElement(/datum/element/connectable_computer, old_loc)

/obj/machinery/modular_computer/Initialize(mapload)
	. = ..()

	// Modular consoles all have the same case.
	AddElement(/datum/element/connectable_computer)

/obj/machinery/modular_computer/Destroy()
	var/old_loc = loc
	. = ..()
	RemoveElement(/datum/element/connectable_computer, old_loc)
