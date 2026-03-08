/obj/item/ammo_casing/caseless/c22hl
	caliber = ENERGY
	projectile_type = /obj/projectile/bullet/c22hl

/obj/projectile/bullet/c22hl //.22 HL
	name = "hardlight beam"
	icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "disabler_bullet"
	armor_flag = ENERGY
	damage = 1 //ouch ouch my skin ouchie
	damage_type = BURN
	sharpness = NONE
	shrapnel_type = null
	stamina = 20

/obj/item/ammo_casing/caseless/c22ls
	caliber = LASER
	projectile_type = /obj/projectile/bullet/c22ls

/obj/projectile/bullet/c22ls //.22LS
	name = "laser beam"
	icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "disabler_bullet"
	armor_flag = LASER
	damage = 18
	damage_type = BURN
	color = "#ff0000"
	wound_bonus = -15
	exposed_wound_bonus = 5

/obj/item/ntusp_conversion_kit
	name = "NT-USP magazine conversion kit"
	desc = "A standard conversion kit for use in converting NT-USP magazines to be more lethal or less lethal."
	icon = 'modular_zubbers/icons/obj/weapons/guns/usp_modkit.dmi'
	icon_state = "modkit_ntusp"
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/recharge/ntusp/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_danger("[A] makes a whirring sound as it modifies \the [src]'s lens to fabricate more lethal rounds."))
		new /obj/item/ammo_box/magazine/recharge/ntusp/laser/empty(get_turf(src)) // you thought you were getting free bullets?
		qdel(src)
	else
		return ..()

/obj/item/ammo_box/magazine/recharge/ntusp/laser/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_notice("[A] makes a whirring sound as it modifies \the [src]'s lens to fabricate less lethal rounds."))
		new /obj/item/ammo_box/magazine/recharge/ntusp/empty(get_turf(src))
		qdel(src)
	else
		return ..()

/obj/item/gun/ballistic/automatic/pistol/ntusp/update_icon()
	icon_state = initial(icon_state)
	if(istype(magazine, /obj/item/ammo_box/magazine/recharge/ntusp/laser))
		icon_state = "ntusp-l"
	..()
