/obj/effect/spawner/random/maintsrooms
	name = "random maintsrooms spawn"
	desc = "Spawns a random object, mob, or structure for the maintsrooms awaymission."
	loot = list(
		/turf/closed/wall/r_wall = 31,
		/turf/open/floor/white = 37,
		/obj/structure/table/reinforced = 23,
		/obj/effect/spawner/random/maintsrooms/materials = 5.7,
		/obj/effect/decal/remains/human = 0.5,
		/obj/effect/decal/remains/robot = 0.4,
		/obj/effect/decal/remains/xeno = 0.4,
		/obj/structure/fluff/clockwork/clockgolem_remains = 0.4,
		/obj/item/raw_anomaly_core/random = 2,
	)

/// number count for myself, this is the remaining amount until the sum is 100
/// 0
/obj/effect/spawner/random/maintsrooms/make_item(spawn_loc, type_path_to_make)
	if(ispath(type_path_to_make, /turf) && isturf(spawn_loc))
		var/turf/spawn_turf = spawn_loc
		return spawn_turf.place_on_top(type_path_to_make)
	else
		return ..()

/obj/effect/spawner/random/maintsrooms/no_walls
	name = "random maintsrooms spawn (no walls)"

/obj/effect/spawner/random/maintsrooms/no_walls/New()
	loot[/turf/open/floor/white] = (loot[/turf/open/floor/white] + loot[/turf/closed/wall/r_wall])
	loot -= /turf/closed/wall/r_wall
	return ..()

/obj/effect/spawner/random/maintsrooms/materials
	name = "random maintsrooms spawn"
	desc = "Sub spawner for the maintsroom spawner because there is an upper limit to how many things one spawner can spawn."
	loot = list(
		/obj/item/stack/sheet/mineral/adamantine = 10,
		/obj/item/stack/sheet/hot_ice = 10,
		/obj/item/stack/sheet/hauntium = 10,
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/runed_metal = 10,
		/obj/item/stack/telecrystal = 10,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/hypernoblium_crystal = 5,
		/obj/item/stack/sheet/mineral/abductor = 5,
		/obj/item/stack/sheet/mineral/zaukerite = 5,
		/obj/item/stack/sheet/mineral/runite = 5,
		/obj/item/stack/sheet/mineral/metal_hydrogen = 5,
		/obj/item/stack/sheet/mineral/gold = 5,
		/obj/item/stack/sheet/mineral/diamond = 5,
	)

/obj/effect/spawner/random/maintsrooms/spatial_anoms
	name = "spatial anomaly spawner"
	desc = "most of the time nothing, sometimes a spatial anomaly."
	loot = list(
		/obj/item/stack/sheet/mineral/diamond = 5,
	)

