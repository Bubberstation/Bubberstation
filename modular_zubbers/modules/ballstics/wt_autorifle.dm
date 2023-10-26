// WT-551 Autorifle

/obj/item/gun/ballistic/automatic/wt550/security
	name = "\improper WT-551 Autorifle"
	desc = "A heavier, bulkier semi-automatic variant of the WT-550, and now with 99% less discombobulation! It's back, baby. Uses 4.6x30mm rounds. Recommended to hold with two hands."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wt551.dmi'
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	w_class = WEIGHT_CLASS_BULKY
	burst_size = 1
	fire_delay = 3
	semi_auto = TRUE
	//20 damage per 0.3 seconds = 66 DPS
	//Reference: Laser Gun 22 damage per 0.4 seconds = 55DPS

/obj/item/gun/ballistic/automatic/wt550/security/flathead //What you get in the armory.
	spawn_magazine_type = /obj/item/ammo_box/magazine/wt550m9/flathead

/obj/item/gun/ballistic/automatic/wt550/security/rubber //What you get from cargo.
	spawn_magazine_type = /obj/item/ammo_box/magazine/wt550m9/rubber

//PROJECTILES
/obj/projectile/bullet/c46x30mm/flathead
	name = "4.6x30mm flathead bullet"

	damage = 20
	stamina = 5 //Knocks the wind out of you.

	wound_bonus = -100 //Cannot wound.
	bare_wound_bonus = 0
	embed_falloff_tile = -4

	weak_against_armour = TRUE
	sharpness = NONE
	shrapnel_type = null
	embedding = null

/obj/projectile/bullet/c46x30mm/rubber
	name = "4.6x30mm rubber-tipped bullet"
	damage = 5
	stamina = 15

	wound_bonus = -100 //Cannot wound.
	bare_wound_bonus = 0
	embed_falloff_tile = -4

	weak_against_armour = TRUE
	sharpness = NONE
	shrapnel_type = null
	embedding = null

	ricochets_max = 3
	ricochet_incidence_leeway = 0
	ricochet_chance = 75
	ricochet_decay_damage = 0.8

.//AMMO CASING
/obj/item/ammo_casing/c46x30mm/flathead
	name = "4.6x30mm flathead bullet casing"
	desc = "A 4.6x30mm bullet casing."
	caliber = CALIBER_46X30MM
	projectile_type = /obj/projectile/bullet/c46x30mm/flathead

/obj/item/ammo_casing/c46x30mm/rubber
	name = "4.6x30mm rubber-tipped bullet casing"
	desc = "A 4.6x30mm bullet casing."
	caliber = CALIBER_46X30MM
	projectile_type = /obj/projectile/bullet/c46x30mm/rubber


//MAGAZINE
/obj/item/ammo_box/magazine/wt550m9/flathead
	name = "wt550 magazine (FlatHead 4.6x30mm)"
	icon_state = "46x30mmt-20"
	base_icon_state = "46x30mmt"
	ammo_type = /obj/item/ammo_casing/c46x30mm/flathead
	caliber = CALIBER_46X30MM
	max_ammo = 20

/obj/item/ammo_box/magazine/wt550m9/rubber
	name = "wt550 magazine (Rubber 4.6x30mm)"
	icon_state = "46x30mmt-20"
	base_icon_state = "46x30mmt"
	ammo_type = /obj/item/ammo_casing/c46x30mm/rubber
	caliber = CALIBER_46X30MM
	max_ammo = 20


//ORDERING
/datum/supply_pack/security/armory/wt551
	name = "WT-551 Autorifle Crate"
	desc = "Contains a pair of WT-551 Autorifles pre-loaded with less-than-lethal rubber-tipped rounds. Additional ammo sold seperately. Backwards-compatible with WT-550 magazines. NanoTrasen reminds you that the other weapon is for a friend, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 8.
	contains = list(/obj/item/gun/ballistic/automatic/wt550/security/rubber = 2)
	crate_name = "wt-550 autorifle crate"

/datum/supply_pack/security/armory/wt550_ammo_rubber
	name = "WT-550/WT-551 Autorifle Ammo Crate (Rubber-Tipped)"
	desc = "Contains 3 magazines with less than lethal rubber-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 4.
	contains = list(/obj/item/ammo_box/magazine/wt550m9/rubber = 3)
	crate_name = "wt-550 magazine crate (rubber-tipped)"

/datum/supply_pack/security/armory/wt550_ammo_flat
	name = "WT-550/WT-551 Autorifle Ammo Crate (Flat-Tipped)"
	desc = "Contains 3 magazines with lethal flat-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 5.
	contains = list(/obj/item/ammo_box/magazine/wt550m9/flathead = 3)
	crate_name = "wt-550 magazine crate (flat-tipped)"

/datum/supply_pack/security/armory/wt550_ammo_regular
	name = "WT-550/WT-551 Autorifle Ammo Crate (Regular)"
	desc = "Contains 3 magazines with lethal flat-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 7.
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 3)
	crate_name = "wt-550 magazine crate (regular)"

//RESEARCHING: TECHWEBS

/datum/techweb_node/wt550_ammo
	id = "wt550_ammo"
	display_name = "Basic WT-550/WT-551 Ammunition"
	description = "They won't know what hit em."
	prereq_ids = list("weaponry")
	design_ids = list(
		"wt550_ammo_rubber",
		"wt550_ammo_flathead"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

/datum/techweb_node/wt550_ammo_advanced
	id = "wt550_ammo_advanced"
	display_name = "Advanced WT-550/WT-551 Ammunition"
	description = "They'll really won't know what hit em."
	prereq_ids = list("adv_weaponry","wt550_ammo")
	design_ids = list(
		"wt550_ammo_normal",
		"wt550_ammo_ap"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)


/datum/techweb_node/wt550_ammo_exotic
	id = "wt550_ammo_exotic"
	display_name = "Illegal WT-550/WT-551 Ammunition"
	description = "They'll REALLY won't know what hit em. Or they will, because they'll be on fire and likely reporting that warcrime to the government in your sector."
	prereq_ids = list("exotic_ammo","syndicate_basic","wt550_ammo_advanced")
	design_ids = list(
		"wt550_ammo_incendiary"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)


//RESEARCHING: DESGINS

/datum/design/wt550_ammo_rubber
	name = "WT-550/WT-551 Magazine (4.6x30mm Rubber-Tipped) (Less-Than_Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains less-than-lethal rubber-tipped ammo."
	id = "wt550_ammo_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6)
	build_path = /obj/item/ammo_box/magazine/wt550m9/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_flat
	name = "WT-550/WT-551 Magazine (4.6x30mm FlatHead) (Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains lethal surplus-tier flathead ammo."
	id = "wt550_ammo_flathead"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8)
	build_path = /obj/item/ammo_box/magazine/wt550m9/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo
	name = "WT-550/WT-551 Magazine (4.6x30mm Regular) (Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains lethal regular ammo."
	id = "wt550_ammo_normal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_ap
	name = "WT-550/WT-551 Magazine (4.6x30mm Armor-Piercing) (Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains lethal armor-piercing ammo. NanoTrasen prefers you didn't use these on your pressurized space station."
	id = "wt550_ammo_ap"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtap
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_incendiary
	name = "WT-550/WT-551 Magazine (4.6x30mm Incendiary) (Extremely Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains very lethal incendiary ammo. Consult your local laws for warcrime status before use."
	id = "wt550_ammo_incendiary"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT , /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtic
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
