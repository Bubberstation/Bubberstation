/obj/item/pneumatic_cannon/load_item(obj/item/I, mob/user) //we make this compatable with the master file incase of future updates.
	if(!can_load_item(I, user))
		return FALSE
	if(user)
		if(istype(I, /obj/item/storage/toolbox/emergency/turret/mag_fed))
			to_chat(user, span_warning("You prepare \the [I] to load into \the [src]. This action will block other items from being loaded!"))
			if(!do_after(user, 15)) //adding a warning and a delay so it cant just be invo-juggle-spammed.
				return FALSE
	return ..()

/obj/item/pneumatic_cannon/can_load_item(obj/item/I, mob/user)
	. = ..()
	if(!.)
		return
	if(locate(/obj/item/storage/toolbox/emergency/turret/mag_fed) in src) //If loaded with a turret, stops more from being put in
		if(user)
			to_chat(user, span_warning("\The [I] is blocked from \the [src]'s loader!"))
		return FALSE
	if(istype(I, /obj/item/storage/toolbox/emergency/turret/mag_fed) && length(loadedItems) >= 1)
		if(user)
			to_chat(user, span_warning("\The [I] needs an empty cannon!"))
		return FALSE
