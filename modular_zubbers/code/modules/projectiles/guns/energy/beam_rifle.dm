/obj/projectile/beam/event_horizon
	damage = 110
	armour_penetration = 35
	dismemberment = 99 \\have you prayed today?
	var/obj_damage = 50
	var/mecha_damage = 40

/obj/projectile/beam/event_horizon/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isobj(target) && (blocked != 100))
		var/obj/thing_to_break = target
		var/damage_to_deal = object_damage
		if(ismecha(thing_to_break) && mecha_damage)
			damage_to_deal += mecha_damage
		if(damage_to_deal)
			thing_to_break.take_damage(damage_to_deal, BRUTE, ENERGY, FALSE)
	return ..()
