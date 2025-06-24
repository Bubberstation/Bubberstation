/obj/projectile/bullet/c46x30mm
	name = "4.6x30mm bullet"
	damage = 20
	wound_bonus = -5
	exposed_wound_bonus = 5
	embed_falloff_tile = -4

/obj/projectile/bullet/c46x30mm/ap
	name = "4.6x30mm armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	embed_type = null

/obj/projectile/bullet/incendiary/c46x30mm //Not a typo. /obj/projectile/bullet/incendiary is a type.
	name = "4.6x30mm incendiary bullet"
	damage = 10
	fire_stacks = 1

/obj/projectile/bullet/c46x30mm/flathead
	name = "4.6x30mm flathead bullet"

	damage = 18
	stamina = 5 //Knocks the wind out of you.

	wound_bonus = CANT_WOUND
	exposed_wound_bonus = CANT_WOUND

	weak_against_armour = TRUE
	sharpness = NONE
	shrapnel_type = null
	embed_type = null

/obj/projectile/bullet/c46x30mm/rubber
	name = "4.6x30mm rubber-tipped bullet"
	damage = 5
	stamina = 15

	wound_bonus = CANT_WOUND
	exposed_wound_bonus = CANT_WOUND

	weak_against_armour = TRUE
	sharpness = NONE
	shrapnel_type = null
	embed_type = null

	ricochets_max = 3
	ricochet_incidence_leeway = 0
	ricochet_chance = 75
	ricochet_decay_damage = 0.8
