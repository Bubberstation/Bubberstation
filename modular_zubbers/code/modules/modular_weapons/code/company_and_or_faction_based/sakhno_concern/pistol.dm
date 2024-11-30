#define PERCENT_DMG_DROP (-0.1) //How much damage is lost per tile, as a negative percentage of damage at time of firing.
#define LOADING_TIME (0.75 SECONDS) //How long it takes to load a cartridge, to prevent instant loading and firing again.

/obj/item/gun/ballistic/derringer
	name = "\improper Yinbi Derringer"
	desc = "A very compact twin-barreled pistol, chambered in .310 strilka. \
		Despite using a rifle cartridge, the short barrels leave a lot to \
		be desired for ballistic performance and suffer from immense dropoff."
	icon = 'modular_zubbers/code/modules/modular_weapons/icons/sakhno_concern_guns32x.dmi'
	icon_state = "derringer"
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	projectile_damage_multiplier = 0.75 //Drops damage to "45" from 60, for base .310 strikla
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/derringer
	fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 65
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	rack_sound_volume = 0
	fire_delay = 3
	internal_magazine = TRUE
	casing_ejector = FALSE
	bolt_type = BOLT_TYPE_NO_BOLT

/obj/item/gun/ballistic/derringer/process_fire() //It's a derringer, damage drops off rather quickly so it's not used as a cheap pocket rifle.
	if(chambered.loaded_projectile)
		var/projectileDamage = chambered.loaded_projectile.damage
		var/projectileStamina = chambered.loaded_projectile.stamina
		//Damage fall-off is 10% of the projectile's total damage at firing, including the multiplier penalty. This allows it to travel slightly further than a screen's length.
		chambered.loaded_projectile.damage_falloff_tile = ((projectileDamage * projectile_damage_multiplier) * PERCENT_DMG_DROP)
		chambered.loaded_projectile.stamina_falloff_tile = ((projectileStamina * projectile_damage_multiplier) * PERCENT_DMG_DROP)

	. = ..()

/obj/item/gun/ballistic/derringer/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAKHNO)

/obj/item/gun/ballistic/derringer/examine_more(mob/user)
	. = ..()

	. += "The Yinbi Derringer was originally marketed as a companion sidearm to the Sakhno rifle, \
		allowing the user to have a easy to carry and conceal self-defence weapon without having to \
		keep several calibers of ammo on hand. While initial sales were promising, the poor ranged \
		performance ultimately lead to production halting for this model. Most of the remaining stock \
		was liquidated, and they are now found at rather affordable prices on the secondary market. \
		Unlike the rifles they were partnered with, they have held up much better over the years."

	return .

/obj/item/gun/ballistic/derringer/attackby(obj/item/A, mob/user, params) // Forced delay on loading derringer, only checks for valid ammo types/boxes though.
	if (is_type_in_list(A, list(/obj/item/ammo_casing/strilka310,
								/obj/item/ammo_box/c310_cargo_box,
								/obj/item/ammo_box/strilka310)))
		if(!do_after(user, LOADING_TIME, src, IGNORE_USER_LOC_CHANGE)) // We are allowed to move while reloading.
			to_chat(user, span_danger("You fail to chamber a round into [src]!"))
			return TRUE

	. = ..()

#undef LOADING_TIME
#undef PERCENT_DMG_DROP
