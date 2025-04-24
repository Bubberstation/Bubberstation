/obj/item/ammo_casing/shotgun/thundershot
	name = "thunder slug"
	desc = "An advanced shotgun shell that uses stored electrical energy to discharge a massive shock on impact, arcing to nearby targets."
	icon = 'modular_zubbers/icons/obj/ammo.dmi'
	icon_state = "Thshell"
	pellets = 3
	variance = 30
	projectile_type = /obj/projectile/bullet/pellet/shotgun_thundershot

/obj/item/ammo_casing/shotgun/uraniumpenetrator
	name = "depleted uranium slug"
	desc = "A relatively low-tech shell, utilizing the unique properties of Uranium, and possessing \
	very impressive armor penetration capabilities."
	icon = 'modular_zubbers/icons/obj/ammo.dmi'
	icon_state = "dushell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/shotgun_uraniumslug

/obj/item/ammo_casing/shotgun/cryoshot
	name = "cryoshot shell"
	desc = "A state-of-the-art shell which uses the cooling power of Rhigoxane to snap freeze a target, without causing \
	them much harm."
	icon = 'modular_zubbers/icons/obj/ammo.dmi'
	icon_state = "fshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_cryoshot
	pellets = 4
	variance = 35

/obj/item/ammo_casing/shotgun/rip //two pellet slug bc why not
	name = "ripslug shell"
	desc = "An advanced shotgun shell that uses a narrow choke in the shell to split the slug in two.\
	This makes them less able to break through armor, but really hurts everywhere else."
	icon = 'modular_zubbers/icons/obj/ammo.dmi'
	icon_state = "rsshell"
	projectile_type = /obj/projectile/bullet/shotgun/slug/rip
	pellets = 2
	variance = 3 // the tight spread

/obj/item/ammo_casing/shotgun/anarchy
	name = "anarchy shell"
	desc = "An advanced shotgun shell that has low impact damage, wide spread, and loads of pellets that bounce everywhere. Good luck"
	icon = 'modular_zubbers/icons/obj/ammo.dmi'
	icon_state = "anashell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_anarchy
	pellets = 10 // AWOOGA!!
	variance = 50
