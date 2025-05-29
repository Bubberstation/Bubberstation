/obj/item/gun/energy/kinetic_accelerator/crossbow/feeder
	name = "feeder's mini energy crossbow"
	desc = "a modified version of the standard mini energy crossbow, designed to fatten up a target while incapacitating them."
	icon_state = "crossbow_halloween"
	item_state = "crossbow"
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/fattening)

/obj/item/ammo_casing/energy/bolt/fattening
	projectile_type = /obj/item/projectile/energy/bolt/fattening

/obj/item/projectile/energy/bolt/fattening
	damage = 0

/obj/item/projectile/energy/bolt/fattening/Initialize(mapload)
	. = ..()

/obj/item/projectile/energy/bolt/fattening/on_hit(atom/target, blocked)
	. = ..()
	var/mob/living/carbon/target_mob = target
	if(!istype(target_mob) || (blocked == 100))
		return

	target_mob.reagents.add_reagent(/datum/reagent/consumable/lipoifier, 2)

	
