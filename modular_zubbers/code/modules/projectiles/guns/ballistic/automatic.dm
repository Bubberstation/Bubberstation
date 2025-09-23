/obj/item/gun/ballistic/automatic/wt550
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	return

/obj/item/gun/ballistic/automatic/wt550/security
	name = "\improper WT-551 Autorifle"
	desc = "A heavier, bulkier automatic variant of the WT-550, and now with 99% less discombobulation! It's back, baby. Uses 4.6x30mm rounds. Recommended to hold with two hands."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wt551.dmi'
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	w_class = WEIGHT_CLASS_BULKY
	fire_delay = 3
	//18 damage per 0.3 seconds = 60 DPS
	//Reference: Laser Gun 22 damage per 0.4 seconds = 55DPS
