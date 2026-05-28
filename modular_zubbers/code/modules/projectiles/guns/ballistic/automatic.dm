/obj/item/gun/ballistic/automatic/wt550
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	return

/obj/item/gun/ballistic/automatic/wt550/security
	name = "\improper WT-551 Autorifle"
	desc = "A heavier, bulkier automatic variant of the WT-550, and now with 99% less discombobulation! Despite what Nanotrasen might tell you, it's identical in performance to the classic. Uses 4.6x30mm rounds. Recommended to hold with two hands."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wt551.dmi'
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	w_class = WEIGHT_CLASS_BULKY
	fire_delay = 3
	//18 damage per 0.3 seconds = 60 DPS
	//Reference: Laser Gun 22 damage per 0.4 seconds = 55DPS

/obj/item/gun/ballistic/automatic/wt550/burst
	name = "\improper WT-550-B Autoburstrifle"
	desc = "Not so much of a rifle, being modified closer to a submachine gun, but still somehow just as bulky. Outfitted with a modified frame and a two-shot burst trigger mechanism along with cutting off the stock. Perform overall better than the average autorifle, but kicks a bit more. Has a threaded barrel for suppressors. Uses 4.6x30mm rounds."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "wt550b"
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 5
	spread = 3
	recoil = 0.3
	projectile_damage_multiplier = 1.1
	burst_delay = 2
	burst_size = 2

/obj/item/gun/ballistic/automatic/wt550/burst/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.5 SECONDS)

/obj/item/gun/ballistic/automatic/wt550/dmr
	name = "\improper WT-550-C Autorifle"
	desc = "A longer range WT-550, assembled using an aftermarket kit and parts. Outfitted with the longest barrel and custom trigger to enhance performance at a distance. Equipped with a custom scope and a threaded barrel for suppressors. Uses 4.6x30mm rounds."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wide_guns.dmi'
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	weapon_weight = WEAPON_HEAVY
	can_suppress = TRUE
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 1.5 // 30 damage base + wounding at half the firerate
	projectile_speed_multiplier = 1.5
	projectile_wound_bonus = 5
	burst_delay = 3
	burst_size = 1

/obj/item/gun/ballistic/automatic/wt550/dmr/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.6 SECONDS)
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/wt550/sawnoff
	name = "\improper sawn-off WT-550"
	desc = "A custom chopped down WT-550. Less of a sawn-off and more of a mostly-gone. The barrel, stock and parts of the frame have been stripped down to reduce weight, causing handling to drop to abysmal levels. Don't even think about dual-wielding these. Uses 4.6x30mm rounds."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "wt550s"
	w_class = WEIGHT_CLASS_NORMAL
	projectile_damage_multiplier = 0.8
	projectile_speed_multiplier = 0.8
	projectile_wound_bonus = -5
	spread = 25
	dual_wield_spread = 50
	recoil = SAWN_OFF_RECOIL
	
/obj/item/gun/ballistic/automatic/wt550/sawnoff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS)
