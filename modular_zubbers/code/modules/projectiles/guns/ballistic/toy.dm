#define LOADING_TIME (2 SECONDS)

/obj/item/gun/ballistic/toy/foamforce_implant
	name = "Pop-up Donksoft Blaster"
	desc = "A two shot, breech loaded Donksoft blaster that pops out of a panel on your wrist. You wonder if it was worth it."
	icon = 'modular_zubbers/icons/obj/guns/popupdart_toy.dmi' //modified Derringer sprite by the wonderful Niim
	icon_state = "popupdart_toy"
	force = 0
	throwforce = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/foamforce_implant
	fire_sound = 'sound/items/syringeproj.ogg'
	rack_sound_volume = 0
	fire_delay = 7
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
	gun_flags = NOT_A_REAL_GUN
	can_muzzle_flash = FALSE
	bolt_type = BOLT_TYPE_NO_BOLT

/obj/item/gun/ballistic/toy/foamforce_implant/attackby(obj/item/A, mob/user, params) // Forced delay on loading, only checks for valid ammo types/boxes though.
	if (is_type_in_list(A, list(/obj/item/ammo_casing/foam_dart,
								/obj/item/ammo_box/foambox)))
		if(!do_after(user, LOADING_TIME, src, IGNORE_USER_LOC_CHANGE)) // We are allowed to move while reloading.
			to_chat(user, span_danger("You fail to insert a dart into [src]!"))
			return TRUE

	. = ..()
#undef LOADING_TIME
