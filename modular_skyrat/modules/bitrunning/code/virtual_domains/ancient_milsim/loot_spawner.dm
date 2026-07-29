/obj/effect/spawner/random/ancient_milsim
	name = "ancient milsim loot spawner"
	desc = "If you see this, report to devs at (link_expired).com."
	icon_state = "loot"
	spawn_loot_count = 2
	spawn_scatter_radius = 1
	spawn_random_offset = TRUE
	spawn_loot_chance = 20

/obj/effect/spawner/random/ancient_milsim/ranged
	loot = list(
		/obj/item/coin/silver/doubloon = 25, //in-game currency because it was totally not-the-best-kind-of live service
		/obj/item/coin/gold/doubloon = 15,
		/obj/item/ammo_box/magazine/lanca = 10,
		/obj/item/ammo_box/magazine/c35sol_pistol = 10,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 10,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 10,
		/obj/effect/spawner/random/contraband/grenades/dangerous = 5,
		/obj/effect/spawner/random/contraband/narcotics = 5,
		/obj/effect/spawner/random/medical/minor_healing = 4,
		/obj/item/storage/box/colonial_rations = 4,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower = 1,
	)

/obj/effect/spawner/random/ancient_milsim/melee
	loot = list(
		/obj/item/coin/silver/doubloon = 25,
		/obj/item/coin/gold/doubloon = 15,
		/obj/item/ammo_box/magazine/lanca = 10,
		/obj/item/ammo_box/magazine/c35sol_pistol = 10,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 10,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 10,
		/obj/effect/spawner/random/contraband/grenades/dangerous = 5,
		/obj/effect/spawner/random/contraband/narcotics = 5,
		/obj/effect/spawner/random/medical/minor_healing = 4,
		/obj/item/storage/box/colonial_rations = 4,
		/obj/item/melee/energy/sword/saber/purple = 1,
		/obj/item/shield/energy = 1,
	)
