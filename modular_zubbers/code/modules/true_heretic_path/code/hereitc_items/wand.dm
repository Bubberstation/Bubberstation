/obj/item/gun/magic/wand/fireball/heretic

	name = "wand of heretical fireball"
	desc = "This wand shoots scorching balls of fire that explode into destructive flames."

	school = SCHOOL_EVOCATION
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball/heretic

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	base_icon_state = "wand"
	icon_state = "wand"

	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_icon_state = "wand"


	can_charge = FALSE
	variable_charges = FALSE
	charges = 4
	recharge_rate = 1

/obj/item/ammo_casing/magic/fireball/heretic
	projectile_type = /obj/projectile/magic/fireball/heretic

/obj/projectile/magic/fireball/heretic
	damage = 0
	exp_light = 1