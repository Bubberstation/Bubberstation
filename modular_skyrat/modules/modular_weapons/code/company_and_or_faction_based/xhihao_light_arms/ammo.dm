/*
*	.310 Strilka
*/

/obj/item/ammo_casing/strilka310/ap
	name = ".310 Strilka armor-piercing bullet casing"
	desc = "A .310 armor-piercing bullet casing. Note, does not actually contain a casing.\
	<br><br>\
	<i>ARMOR-PIERCING: Improved armor-piercing capabilities, in return for less outright damage.</i>"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/ammo.dmi'
	icon_state = "310-casing-ap"

	projectile_type = /obj/projectile/bullet/strilka310/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/projectile/bullet/strilka310/ap
	name = ".310 armor-piercing bullet"
	damage = 50
	armour_penetration = 60
