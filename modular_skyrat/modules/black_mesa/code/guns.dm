/obj/item/gun/ballistic/automatic/laser/marksman // Cheap replacement for a gauss rifle.
	name = "designated marksman rifle"
	desc = "A special laser beam sniper rifle designed by a certain now defunct research facility."
	icon_state = "ctfmarksman"
	inhand_icon_state = "ctfmarksman"
	mag_type = /obj/item/ammo_box/magazine/recharge/marksman
	force = 15
	weapon_weight = WEAPON_HEAVY
	fire_delay = 4 SECONDS
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_fire.ogg'

/obj/item/gun/ballistic/automatic/laser/marksman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/ammo_box/magazine/recharge/marksman
	ammo_type = /obj/item/ammo_casing/caseless/laser/marksman
	max_ammo = 5

/obj/item/ammo_casing/caseless/laser/marksman
	projectile_type = /obj/projectile/beam/marksman

/obj/item/ammo_casing/caseless/laser/marksman/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/delete_on_drop)

/obj/projectile/beam/marksman
	name = "laser beam"
	damage = 70
	armour_penetration = 30
	hitscan = TRUE
	icon_state = "gaussstrong"
	tracer_type = /obj/effect/projectile/tracer/solar
	muzzle_type = /obj/effect/projectile/muzzle/solar
	impact_type = /obj/effect/projectile/impact/solar

/obj/item/gun/ballistic/automatic/mp5
	name = "\improper MP5/40"
	desc = "An old SMG, this one is chambered in 10mm Auto. It has Heckler & Koch etched above the magazine well."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file ='modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	icon_state = "mp5"
	inhand_icon_state = "mp5"
	mag_type = /obj/item/ammo_box/magazine/mp5
	bolt_type = BOLT_TYPE_LOCKING
	can_suppress = TRUE
	fire_delay = 1.25
	spread = 2.5
	mag_display = TRUE
	alt_icons = TRUE
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_magin.ogg'
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_cock.ogg'
	lock_back_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_boltback.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_magout.ogg'
	bolt_drop_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/mp5_boltforward.ogg'
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/mp5_fire.ogg'
	alternative_fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/mp5_fire_suppressed.ogg'
	suppressed_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/mp5_fire_suppressed.ogg'
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	projectile_damage_multiplier = 0.7

/obj/item/gun/ballistic/automatic/mp5/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/mp5
	name = "MP5 magazine (10mm Auto)"
	desc = "Magazines taking 10mm ammunition; it fits in the MP5."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "mp5"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
