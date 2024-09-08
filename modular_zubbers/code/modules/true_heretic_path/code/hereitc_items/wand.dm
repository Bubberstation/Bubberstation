/obj/item/gun/magic/wand/fireball/heretic

	name = "prophetic wand"
	desc = "A wand that shoots simple firebolts at a target. The wand recharges itself automatically, but has a low charge capacity as a result."

	school = SCHOOL_EVOCATION
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball/heretic

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	base_icon_state = "wand"
	icon_state = "wand"

	righthand_file = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inhand_right.dmi'
	lefthand_file = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inhand_left.dmi'
	inhand_icon_state = "wand"

	can_charge = FALSE
	variable_charges = FALSE
	max_charges = 4

	var/auto_charge_amount = 1 //Every 2 seconds.

/obj/item/gun/magic/wand/fireball/heretic/try_fire_gun(atom/target, mob/living/user, params)
	. = ..()
	if(. && auto_charge_amount > 0 && charges < max_charges)
		START_PROCESSING(SSobj,src)

/obj/item/gun/magic/wand/fireball/heretic/process(seconds_per_tick)
	charges = min(charges + auto_charge_amount,max_charges)
	if(charges >= max_charges)
		STOP_PROCESSING(SSobj, src)

/obj/item/ammo_casing/magic/fireball/heretic
	projectile_type = /obj/projectile/magic/fireball/heretic

/obj/projectile/magic/fireball/heretic
	damage = 0
	exp_light = 1
