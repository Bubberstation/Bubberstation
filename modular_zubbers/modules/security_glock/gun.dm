/obj/item/gun/ballistic/automatic/pistol/sec_glock //This is what ou give to the Head of Security.
	name = "\improper Silver MOCK-9mm"
	desc = "A security-issue 9mm pistol meant for self-defense. This one is silver plated."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "silver"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm
	fire_sound = 'modular_zubbers/sound/weapons/gun/lock/shot.ogg'
	fire_delay = 2
	can_suppress = FALSE
	projectile_damage_multiplier = 0.8

/obj/item/gun/ballistic/automatic/pistol/sec_glock/security //This is what you give to Security Officers.
	name = "\improper Black MOCK-9mm"
	desc = "A security-issue 9mm pistol meant for self-defense. These are normally issued with a special firing pin that only allows firing on code blue or higher. Nanotrasen reminds you that you should not refer to this as \"Black Man Cock\" or any other inappropriate names as it may make you take this firearm less seriously."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "black"
	pin = /obj/item/firing_pin/alert_level
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/flathead
	fire_delay = 3
	can_suppress = FALSE
	projectile_damage_multiplier = 0.7

/obj/item/gun/ballistic/automatic/pistol/sec_glock/security/rubber //This is what you give to cargo packages.
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/rubber
