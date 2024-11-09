/obj/item/gun/ballistic/derringer
	name = "\improper Yinbi Derringer"
	desc = "A very compact twin-barreled pistol, chambered in .310 strilka. \
		Despite using a rifle cartridge, the short barrels leave a lot to be desired for ballistic performance."
	icon_state = "dshotgun"
	inhand_icon_state = "shotgun_db"
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	force = 5
	projectile_damage_multiplier = 0.67 //Drops damage to "40" from 60, for base .310 strikla
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/derringer
	hidden_chambered = TRUE
	rack_sound_volume = 0
	fire_delay = 3
	internal_magazine = TRUE
	casing_ejector = FALSE
	bolt_type = BOLT_TYPE_NO_BOLT

/obj/item/gun/ballistic/derringer/process_fire() //It's a derringer, damage drops off rather quickly so it's not used as a cheap pocket rifle.
	if(chambered.loaded_projectile)
		chambered.loaded_projectile.damage_falloff_tile = -5

	. = ..()

/obj/item/gun/ballistic/derringer/examine_more(mob/user)
	. = ..()

	. += "The Yinbi Derringer was originally marketed as a companion sidearm to the Sakhno rifle, \
		allowing the user to have a easy to carry and conceal self-defence weapon without having to \
		keep several calibers of ammo on hand. While initial sales were promising, the poor ranged \
		performance ultimately lead to production halting for this model. Most of the remaining stock \
		was liquidated, and they are now found at rather affordable prices on the secondary market."

	return .

/*
	///How much we want to drop damage per tile as it travels through the air
	var/damage_falloff_tile
	///How much we want to drop stamina damage (defined by the stamina variable) per tile as it travels through the air
	var/stamina_falloff_tile
	///How much we want to drop both wound_bonus and bare_wound_bonus (to a minimum of 0 for the latter) per tile, for falloff purposes
	var/wound_falloff_tile
	///How much we want to drop the embed_chance value, if we can embed, per tile, for falloff purposes
	var/embed_falloff_tile
*/
