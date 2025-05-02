/obj/item/weldingtool/Initialize(mapload)
	. = ..()
	RegisterSignal(reagents,
		COMSIG_REAGENTS_HOLDER_UPDATED,
		PROC_REF(update_ammo_hud))

/obj/item/weldingtool/set_welding(new_value)
	. = ..()
	update_ammo_hud()

/obj/item/weldingtool/proc/update_ammo_hud()
	SIGNAL_HANDLER

	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
