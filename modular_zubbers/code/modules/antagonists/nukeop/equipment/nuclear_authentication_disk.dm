/obj/item/disk/nuclear/secured_process(last_move)

	//If there is no assigned captain, then don't run the event.
	if(!SSJob || !SSJob.assigned_captain)
		return

	. = ..()
