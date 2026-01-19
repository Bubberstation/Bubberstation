/obj/effect/spawner/random/armory/
	spawn_loot_split = TRUE
	spawn_loot_split_pixel_offsets = 4

/obj/effect/spawner/random/armory/barrier_grenades
	name = "barrier grenade spawner"
	icon_state = "barrier_grenade"
	loot = list(/obj/item/grenade/barrier)
	spawn_loot_count = 3

/obj/effect/spawner/random/armory/barrier_grenades/six
	spawn_loot_count = 6

/obj/effect/spawner/random/armory/riot_shield
	icon_state = "riot_shield"
	loot = list(
		/obj/item/shield/riot,
		/obj/item/shield/riot,
		/obj/item/shield/riot,
		/obj/item/melee/breaching_hammer,
		/obj/item/melee/breaching_hammer,
		/obj/item/melee/breaching_hammer
	)
	spawn_all_loot = TRUE

/obj/effect/spawner/random/armory/rubbershot
	loot = list(
		/obj/item/storage/box/rubbershot,
		/obj/item/storage/box/rubbershot,
		/obj/item/storage/box/beanbag,
		/obj/item/storage/box/beanbag,
	)
	spawn_all_loot = TRUE

/obj/effect/spawner/random/armory/disablers
	loot = list(
		/obj/item/gun/energy/disabler
	)
	spawn_loot_count = 4

/obj/effect/spawner/random/armory/laser_gun
	loot = list(
		/obj/item/gun/energy/laser
	)
	spawn_loot_count = 3

/obj/effect/spawner/random/armory/smg
	loot = list(
		/obj/item/gun/ballistic/automatic/wt550/security
	)
	spawn_loot_count = 2


/obj/effect/spawner/random/armory/e_gun
	loot = list(
		/obj/item/gun/energy/e_gun,
		/obj/item/gun/energy/e_gun,
		/obj/item/gun/energy/e_gun,
	)
	spawn_all_loot = TRUE
/obj/effect/spawner/random/armory/shotgun
	loot = list(
		/obj/item/gun/ballistic/shotgun/riot
	)
	spawn_loot_count = 3

/obj/effect/spawner/random/armory/bulletproof_helmet
	loot = list(
		/obj/item/clothing/head/helmet/alt
	)
	spawn_loot_count = 3

/obj/effect/spawner/random/armory/bulletproof_armor
	loot = list(
		/obj/item/clothing/suit/armor/bulletproof
	)
	spawn_loot_count = 3

/obj/effect/spawner/random/armory/riot_helmet
	loot = list(
		/obj/item/clothing/head/helmet/toggleable/riot
	)
	spawn_loot_count = 3

/obj/effect/spawner/random/armory/riot_armor
	loot = list(
		/obj/item/clothing/suit/armor/riot
	)
	spawn_loot_count = 3
