// Casing and projectile for the plasma thrower

/obj/item/ammo_casing/energy/laser/plasma_glob
	projectile_type = /obj/projectile/beam/laser/plasma_glob
	fire_sound = 'modular_zubbers/sound/weapons/incinerate.ogg'

/obj/item/ammo_casing/energy/laser/plasma_glob/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/beam/laser/plasma_glob
	name = "plasma globule"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "plasma_glob"
	damage = 10
	speed = 0.6
	exposed_wound_bonus = 55 // Lasers have a wound bonus of 40, this is a bit higher
	wound_bonus = -50 // However we do not very much against armor
	pass_flags = PASSTABLE | PASSGRILLE // His ass does NOT pass through glass!
	weak_against_armour = TRUE

/obj/projectile/beam/laser/plasma_glob/supercharged
	name = "overcharged plasma globule"
	icon_state = "plasma_glob_super"
	weak_against_armour = FALSE
