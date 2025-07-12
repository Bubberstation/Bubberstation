/obj/item/ammo_casing/energy/nanite/inferno/lever
	projectile_type = /obj/projectile/energy/inferno/lever
	select_name = "kill"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/nanite/cryo/lever
	projectile_type = /obj/projectile/energy/cryo/lever
	select_name = "disable"
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/blue
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)

/obj/projectile/energy/inferno/lever
	damage = 25
	armour_penetration = 25
	exposed_wound_bonus = 25

/obj/projectile/energy/cryo/lever
	damage = 25
	armour_penetration = 25
	exposed_wound_bonus = 25
