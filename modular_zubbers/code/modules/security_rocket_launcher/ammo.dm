//The broken fluff model
/obj/item/broken_missile/security
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket_broken"

//The ammo itself
/obj/item/ammo_casing/security_missile
	name = "\improper \"VARS\" HE missile"
	desc = "An 69mm High Explosive missile with built-in radar technology. Fire at people and forget, because it's honestly best to forget what happened if you accidentally hit a stray assistant with these."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket"
	base_icon_state = "rocket"

	caliber = CALIBER_69MM
	projectile_type = /obj/projectile/bullet/security_missile
	newtonian_force = 2

	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_casing/security_missile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/security_missile/update_icon_state()
	. = ..()
	icon_state = base_icon_state

//Storage for the ammo. Not an ammo box subtype because we don't want security easy getting restocks.
/obj/item/storage/box/security_missiles
	name = "\improper \"VARS\" HE missile box"
	desc = "A sleek, sturdy box used to hold missiles."
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket_box"
	illustration = null

/obj/item/storage/box/security_missiles/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/security_missile(src)
