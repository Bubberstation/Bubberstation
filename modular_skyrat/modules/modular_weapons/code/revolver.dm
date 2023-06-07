/*
*	REVOLVERS
*	Revolving rifles! We have three versions. An improvised slower firing one, a normal one, and a golden premium one.
*	The gold rifle uses .45, it's only 5 more points of damage unfortunately.
*	Fun hint: A box of .45 bullets functions the same as a speedloader.
*/

/obj/item/gun/ballistic/revolver/rifle
	name = "\improper .38 revolving rifle"
	desc = "A revolving rifle chambered in .38. "
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "revolving-rifle"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38 //This is just a detective's revolver but it's too big for bags..
	pixel_x = -4 // It's centred on a 40x32 pixel spritesheet.
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY // The entire purpose of this is that it's a bulky rifle instead of a revolver.
	slot_flags = ITEM_SLOT_BELT
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_icon_state = "revolving"

/obj/item/gun/ballistic/revolver/rifle/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_IZHEVSK)
/obj/item/gun/ballistic/revolver/rifle/gold
	name = "\improper .45 revolving rifle"
	desc = "A gold trimmed revolving rifle! It fires .45 bullets."
	icon_state = "revolving-rifle-gold"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45	//Gold! We're using .45 because TG's 10mm does 40 damage, this does 30.
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "revolving_gold"

// .45 Cylinder

/obj/item/ammo_box/magazine/internal/cylinder/rev45
	name = "revolver .45 cylinder"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = list(".45")
	max_ammo = 6
