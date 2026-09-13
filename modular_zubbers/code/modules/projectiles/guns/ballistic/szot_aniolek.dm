// Szot Dynamica's officer revolver, built on the Bobr frame and priced accordingly

/obj/item/ammo_box/magazine/internal/cylinder/aniolek
	name = "\improper .310 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 5

/obj/item/gun/ballistic/revolver/aniolek
	resistance_flags = INDESTRUCTIBLE
	name = "\improper Aniołek .310 Revolver"
	desc = "A five-shot revolver chambered in .310 Strilka, built from the same broad frame as the Bóbr. \
		Expensive, compact, and unusually well finished, the Aniołek is most commonly associated with decorated \
		officers, state troubleshooters, and other people whose refusal to yield is considered an asset rather \
		than a disciplinary problem."
	icon = 'modular_zubbers/icons/obj/szot_aniolek.dmi'
	icon_state = "aniolek"
	greyscale_config = /datum/greyscale_config/szot_dynamica_32
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/aniolek
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	fire_delay = 0.7 DECISECONDS
	projectile_damage_multiplier = 0.55 // 33 a shot
	recoil = 1
	spread = 6
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/ballistic/revolver/aniolek/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/gun_launches_little_guys, 2, 3)

/obj/item/gun/ballistic/revolver/aniolek/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/revolver/aniolek/examine_more(mob/user)
	. = ..()

	. += "The 'Aniołek' began as a private-order refinement of the Bóbr, commissioned by officers who admired \
		the shotgun revolver's durability and reliability but wanted something less crude hanging from a dress \
		uniform. Szot Dynamica shortened the cylinder, tightened the action, and chambered the result in .310 \
		Strilka. The extractor was deliberately left bright against the darkened cylinder, forming a pale ring \
		around its five chambers."

	. += "It was never formally standard issue. Aniołeks were awarded, purchased, inherited, and occasionally \
		requisitioned by people with enough rank, reputation, or sheer force of personality that few cared to \
		ask which. It became associated with officers expected to hold a line, settle an argument, or continue \
		a mission after everyone more reasonable had cut and run."

	. += "An Aniołek at the hip became shorthand for a particular kind of officer: one trusted to keep their \
		head when command lost theirs, to hold when others folded, and to make the right thing happen whether \
		or not procedure had kept up."

	return .

// The QM's Lanca. Same rifle, deeper magazine, and a magazine you cannot buy.

/obj/item/ammo_box/magazine/lanca/extended
	name = "\improper Lanca extended rifle magazine"
	desc = "An overlong magazine for Lanca rifles, holding eight rounds. Surplus dealers swear these were standard issue \
		somewhere, but never say where."
	icon = 'modular_zubbers/icons/obj/szot_extended_mag.dmi'
	icon_state = "lanca_mag_extended"
	base_icon_state = "lanca_mag_extended"
	max_ammo = 8
