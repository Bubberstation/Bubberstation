<<<<<<< HEAD
/obj/item/gun/ballistic/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	. = ..()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(.)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
=======
// A file for overrides to ballistic weapons that don't have a special Skyrat icon.
/obj/item/gun/ballistic/rifle/lionhunter
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/ballistic/rifle/boltaction/brand_new/prime
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
