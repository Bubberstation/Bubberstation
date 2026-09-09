/obj/projectile/beam/event_horizon
	damage = 110
	armour_penetration = 30
	demolition_mod = 2

/obj/projectile/beam/event_horizon/on_hit(atom/target, blocked = 0, pierce_hit) //breaks walls like a pulse rifle
	. = ..()
	if (!QDELETED(target) && (isturf(target) || isstructure(target)))
		if(isobj(target))
			SSexplosions.med_mov_atom += target
		else
			SSexplosions.medturf += target
	return ..()
