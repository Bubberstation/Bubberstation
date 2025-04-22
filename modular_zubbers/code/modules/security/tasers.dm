//This file is a collection of everything that bubber did to balance tasers. If it has to do with taser balance on bubber, it's probably here.

/obj/projectile/energy/electrode/sec
	tase_stamina = 40

/datum/movespeed_modifier/tasing_someone
	multiplicative_slowdown = 3

/obj/item/gun/energy/e_gun/advtaser
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/electrode/sec)
