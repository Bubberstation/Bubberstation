/obj/item/gun/ballistic/rifle/rebarxbow
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "rebarxbow"

/obj/item/gun/ballistic/rifle/rebarxbow/syndie
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "rebarxbowsyndie"

/obj/item/gun/ballistic/rifle/stingballer
	name = "\improper S-K Stingball Rifle"
	desc = "A pneumatic rifle designed to rapidly fire stingballs. Holds up to 50 rounds."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "stingballer"
	fire_sound = 'modular_zubbers/sound/weapons/gun/light_gunfire.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/stingballer
	need_bolt_lock_to_interact = TRUE
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	internal_magazine = TRUE
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = 2
	mag_display_ammo = TRUE
	spread = 7.5
	projectile_damage_multiplier = 0.50
	projectile_speed_multiplier = 1.25

/obj/item/gun/ballistic/rifle/stingballer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.125 SECONDS)

/obj/item/gun/ballistic/rifle/stingballer/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 26, offset_y = 12)

/obj/item/gun/ballistic/rifle/stingballer/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 20, \
		overlay_y = 10)
