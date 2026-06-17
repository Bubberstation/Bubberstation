GLOBAL_LIST_INIT(tarkon_prize_pool, list(
	/obj/item/storage/toolbox/guncase/m44a = 1,
	/obj/item/storage/toolbox/guncase/m44a_shotgun = 1,
	/obj/item/storage/toolbox/guncase/m44a_ugl = 1,
	/obj/item/storage/toolbox/guncase/smartgun = 1,
	/obj/item/storage/toolbox/guncase/goldendeagle = 1,
	/obj/item/storage/toolbox/guncase/tactical_dualies = 1,
	/obj/item/storage/toolbox/guncase/bmsniper = 1,
	/obj/item/storage/toolbox/guncase/sword_and_board/tarkon = 1,
	/obj/item/fireaxe/energy = 1,
	/obj/item/gun/energy/modular_laser_rifle = 1,
))

/obj/item/storage/toolbox/guncase/m44a
	name = "M44A gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/ar/modular/m44a
	extra_to_spawn = /obj/item/ammo_box/magazine/m44a

/obj/item/storage/toolbox/guncase/m44a_shotgun
	name = "M44A Shotgun gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun
	extra_to_spawn = /obj/item/ammo_box/magazine/m44a

/obj/item/storage/toolbox/guncase/m44a_ugl
	name = "M44A gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher
	extra_to_spawn = /obj/item/ammo_box/magazine/m44a

/obj/item/storage/toolbox/guncase/goldendeagle
	name = "Golden Desert Eagle case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/deagle/gold
	extra_to_spawn = /obj/item/ammo_box/magazine/m50

/obj/item/storage/toolbox/guncase/bmsniper
	name = "SA-107 gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket
	extra_to_spawn = /obj/item/ammo_box/magazine/sniper_rounds

/obj/item/storage/toolbox/guncase/smartgun
	name = "MODsuit Smartgun case"
	weapon_to_spawn = /obj/item/mod/module/smartgun
	extra_to_spawn = /obj/item/ammo_box/magazine/smartgun_drum

/obj/item/storage/toolbox/guncase/tactical_dualies
	name = "dual tactical pistols case"
	weapon_to_spawn = /obj/item/gun/energy/e_gun/stun/pistol
	extra_to_spawn = /obj/item/gun/energy/e_gun/stun/pistol

/obj/item/storage/toolbox/guncase/tactical_dualies/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)

/obj/item/storage/toolbox/guncase/sword_and_board/tarkon

/obj/item/storage/toolbox/guncase/sword_and_board/tarkon/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)
