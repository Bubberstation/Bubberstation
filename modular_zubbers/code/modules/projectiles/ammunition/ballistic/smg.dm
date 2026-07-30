/obj/item/ammo_casing/c46x30mm
	name = "4.6x30mm bullet casing"
	desc = "A 4.6x30mm bullet casing."
	can_be_printed = TRUE
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_BASIC

/obj/item/ammo_casing/c46x30mm/ap
	name = "4.6x30mm armor-piercing bullet casing"
	desc = "A 4.6x30mm armor-piercing bullet casing."
	can_be_printed = TRUE
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_AP

/obj/item/ammo_casing/c46x30mm/inc
	name = "4.6x30mm incendiary bullet casing"
	desc = "A 4.6x30mm incendiary bullet casing."
	can_be_printed = FALSE
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/c46x30mm/compressed
	name = "compressed 4.6x30mm bullet casing"
	desc = "A compressed 4.6x30mm bullet casing."
	projectile_type = /obj/projectile/bullet/c46x30mm/compressed
	can_be_printed = TRUE
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_HOMING

/obj/item/ammo_casing/caseless/c22hl/ntmp5
	projectile_type = /obj/projectile/bullet/c22hl/ntmp5

/obj/projectile/bullet/c22hl/ntmp5
	stamina = 16

/obj/item/ammo_casing/caseless/c22ls/ntmp5
	projectile_type = /obj/projectile/bullet/c22ls/ntmp5

/obj/projectile/bullet/c22ls/ntmp5
	damage = 14

/obj/item/ammo_casing/c45/reaper
	projectile_type = /obj/projectile/bullet/c45/lesser_reaper
