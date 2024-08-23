/obj/item/gun/ballistic/automatic/pistol/sec_glock //This is what you give to the Head of Security.
	name = "\improper Silver C-CK 9x25mm"
	desc = "The Compact Criminal Killer, or C-CK9 for short, is a semi-automatic ballistic pistol meant for regulated station defense. This one is silver plated."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "silver"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm
	fire_sound = 'modular_zubbers/sound/weapons/gun/lock/shot.ogg'
	fire_delay = 3
	can_suppress = FALSE
	projectile_damage_multiplier = 0.75

/obj/item/gun/ballistic/automatic/pistol/sec_glock/security //This is what you give to Security Officers.
	name = "\improper C-CK 9x25mm"
	desc = "The Compact Criminal Killer, or C-CK9 for short, is a semi-automatic ballistic pistol meant for regulated station defense. These are normally issued with a special firing pin that only allows firing on code blue or higher."
	icon = 'modular_zubbers/icons/obj/guns/sec_pistol.dmi'
	icon_state = "black"
	pin = /obj/item/firing_pin/alert_level/blue
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/flathead
	fire_delay = 4
	can_suppress = FALSE
	projectile_damage_multiplier = 0.65

/obj/item/gun/ballistic/automatic/pistol/sec_glock/security/rubber //This is what you give to cargo packages.
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/rubber


