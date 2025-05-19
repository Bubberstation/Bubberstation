/obj/item/ammo_box/magazine/m9mm/security
	name = "pistol magazine (9mm Security)"
	desc = "A 9mm handgun magazine, suitable for the Service Pistol."
	ammo_type = /obj/item/ammo_casing/c9mm/security
	max_ammo = 10

/obj/item/ammo_box/magazine/m9mm/security/rocket
	name = "pistol magazine (9mm Security)"
	desc = "A 9mm handgun magazine, suitable for the Service Pistol."
	ammo_type = /obj/item/ammo_casing/c9mm/security
	max_ammo = 8

/obj/item/ammo_box/magazine/m9mm/security/rocket/throw_impact(mob/living/hit_mob, datum/thrownthing/throwingdatum)
	. = ..()
	if(!QDELETED(hit_mob))
		hit_mob.Knockdown(2 SECONDS)
		hit_mob.adjustBruteLoss(40)
	qdel()
