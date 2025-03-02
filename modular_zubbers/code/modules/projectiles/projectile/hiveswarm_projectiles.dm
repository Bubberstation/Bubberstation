/obj/item/ammo_casing/hivebomber
	name = "bomber sharpnel"
	desc = "Go scream at a coder if you see this."
	pellets = 6
	variance = 25
	newtonian_force = 0
	projectile_type = /obj/projectile/bullet/shrapnel/hiveswarm

/obj/projectile/bullet/shrapnel/hiveswarm
	range = 10

/obj/projectile/bullet/needle
	name = "hiveswarm needle"
	desc = "Ouch, what the fuck what that?"
	icon_state = "flechette"
	ignored_factions = list(FACTION_HIVESWARM)
	damage = 20
	armour_penetration = 20
	wound_bonus = -10
	bare_wound_bonus = 20

/obj/projectile/beam/emitter/hitscan/harvester
	name = "harvester laser"
	desc = "Not just used for salvage!"
	ignored_factions = list(FACTION_HIVESWARM)
	damage = 20
	bare_wound_bonus = 40
	demolition_mod = 50
