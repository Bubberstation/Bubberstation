/obj/item/gun/ballistic/toy/foamforce_implant
	name = "Pop-up Donksoft Blaster"
	desc = "A two shot, breech loaded Donksoft blaster that pops out of a panel on your wrist. You wonder if it was worth it."
	icon = 'modular_zubbers/icons/obj/guns/foamforce_implant.dmi' //modified Derringer sprite by the wonderful Niim
	icon_state = "popupdart"
	force = 0
	throwforce = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/foamforce_implant
	fire_sound = 'sound/items/syringeproj.ogg'
	rack_sound_volume = 0
	fire_delay = 3
	clumsy_check = FALSE
	internal_magazine = TRUE
	casing_ejector = FALSE

	item_flags = NONE
	casing_ejector = FALSE
	can_suppress = FALSE
	weapon_weight = WEAPON_LIGHT
	pb_knockback = 0
	cartridge_wording = "dart"
	pinless = TRUE
	gun_flags = TOY_FIREARM_OVERLAY | NOT_A_REAL_GUN
	can_muzzle_flash = FALSE
	bolt_type = BOLT_TYPE_NO_BOLT
