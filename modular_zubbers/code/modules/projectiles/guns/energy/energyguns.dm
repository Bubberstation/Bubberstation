/obj/item/gun/energy/tacticool
	name = "tacticool energy gun"
	desc = "An older edition of a tactical energy gun, clearly having not been maintained very well. The weapon's cell seems to be stressed extremely by it's taser."
	icon_state = "tacegun"
	icon = 'modular_zubbers/icons/obj/guns/tacticalenergygungrip.dmi'
	inhand_icon_state = "energykill3"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/sec/tacticool, /obj/item/ammo_casing/energy/disabler/tacticool, /obj/item/ammo_casing/energy/laser/tacticool)

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
