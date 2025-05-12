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

/obj/item/ammo_casing/c46x30mm/flathead
	name = "4.6x30mm flathead bullet casing"
	desc = "A 4.6x30mm flathead bullet casing."
	projectile_type = /obj/projectile/bullet/c46x30mm/flathead
	can_be_printed = TRUE
	advanced_print_req = FALSE
	custom_materials = AMMO_MATS_RIPPER

/obj/item/ammo_casing/c46x30mm/rubber
	name = "4.6x30mm rubber-tipped bullet casing"
	desc = "A 4.6x30mm rubber-tipped bullet casing."
	projectile_type = /obj/projectile/bullet/c46x30mm/rubber
	can_be_printed = TRUE
	advanced_print_req = FALSE
	harmful = FALSE
	custom_materials = AMMO_MATS_BASIC
