//Coilgun Driver Magazine or whatever the fuck you wanna call it im done with this shit
/obj/item/ammo_box/magazine/cacoilgun
	name = "coilgun magazine (5.7mm)"
	desc = "A 5.7mm coilgun ammunition box magazine, a bit wide though."
	ammo_type = /obj/item/ammo_casing/cacoil
	caliber = CALIBER_COIL
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "cmg"
	max_ammo = 20
	multitype = FALSE
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	base_icon_state = "cmg"
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = /obj/item/ammo_casing/cacoil
	ammo_band_icon = "+cmgmag_ammo_band"
	ammo_band_color = null

/obj/item/ammo_box/magazine/cacoilgun/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][ammo_count() ? "-ammo" : ""]"

/obj/item/ammo_box/magazine/cacoilgun/fp
	name = "coilgun magazine (5.7mm Fragmenting)"
	desc = parent_type::desc + " Contains highly lethal low penetration projectile that splits into smaller metal shrapnel upon impacting a target."
	ammo_type = /obj/item/ammo_casing/cacoil/fp
	ammo_band_color = "#ff05de"

/obj/item/ammo_box/magazine/cacoilgun/fp/hornet
	name = "coilgun magazine (5.7mm Hornet Nest)"
	ammo_type = /obj/item/ammo_casing/cacoil/fp/hornet
	ammo_band_color = "#bd0ed4"

/obj/item/ammo_box/magazine/cacoilgun/match
	name = "coilgun magazine (5.7mm Match)"
	desc = parent_type::desc + "The induction on this projectile causes it to be accelerated at a slower speed, however, it is more prone to bouncing off of objects."
	ammo_type = /obj/item/ammo_casing/cacoil/match
	ammo_band_color = "#ff0000a8"

//Handgun Magazine

/obj/item/ammo_box/magazine/m45a5
	name = "\improper m45a5 magazine (Rose)"
	desc = "A magazine for the m45a5 chambered in .460 Rowland, holds ten rounds. Warning, contains expanding head that deform on contact, may cause excessive bleeding."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "rowlandmodular"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c460rowland
	caliber = CALIBER_460ROWLAND
	max_ammo = 10

/obj/item/ammo_box/magazine/m45a5/ap
	name = "\improper m45a5 magazine (Armour Piercing)"
	desc = "A magazine for the m45a5 chambered in .460 Rowland, holds ten rounds. Warning, contains lead core intended to defeat body armour."

/obj/item/ammo_box/magazine/m45a5/starts_empty
	start_empty = TRUE

//Cylinder (not speedloader)

/obj/item/ammo_box/magazine/internal/cylinder/c457
	caliber = CALIBER_457GOVT
	ammo_type = /obj/item/ammo_casing/c457govt
