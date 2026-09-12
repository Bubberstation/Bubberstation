/obj/item/gun/energy/tacticool
	name = "tacticool energy gun"
	desc = "An older edition of a tactical energy gun, clearly having not been maintained very well. The weapon's cell seems to be stressed extremely by it's taser."
	icon_state = "tacegun"
	icon = 'modular_zubbers/icons/obj/guns/tacticalenergygungrip.dmi'
	inhand_icon_state = "energykill3"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/sec/tacticool, /obj/item/ammo_casing/energy/disabler/tacticool, /obj/item/ammo_casing/energy/laser/tacticool)
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ammo_casing/energy/disabler/tacticool
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)
/obj/item/ammo_casing/energy/electrode/sec/tacticool
	e_cost = LASER_SHOTS(2, STANDARD_CELL_CHARGE)
/obj/item/ammo_casing/energy/laser/tacticool
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)

/obj/item/gun/energy/tacticool/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 10)

/obj/item/gun/energy/e_gun/nuclear_smg
	name = "advanced energy smg"
	desc = "A self-charging dual-mode rapid-fire energy weapon created as a disgusting hybrid of a laser carbine, a disabler smg and an advanced energy gun. \
			Modifications to the micro reactor have caused allowed a more stable, but less efficient generation of power. Comes with two settings: disable and kill."
	icon = 'modular_zubbers/icons/obj/weapons/guns/energy.dmi'
	icon_state = "nuclear_smg"
	inhand_icon_state = "nucgun"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/smg, /obj/item/ammo_casing/energy/lasergun/carbine_old)
	spread = 2
	ammo_x_offset = 1
	projectile_damage_multiplier = 1.0
	projectile_speed_multiplier = 1.2
	selfcharge = 1
	charge_delay = 7.5
	self_charge_amount = STANDARD_ENERGY_GUN_SELF_CHARGE_RATE / 2
	can_charge = TRUE
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT
	)

/obj/item/gun/energy/e_gun/nuclear_smg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS, allow_akimbo = FALSE)

/obj/item/gun/energy/e_gun/nuclear_smg/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 17, \
		overlay_y = 8)
