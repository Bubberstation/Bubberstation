/turf/closed/mineral/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	initial_gas_mix = MOONSTATION_ATMOS

/turf/closed/mineral/gibtonite/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS

/turf/closed/mineral/bscrystal/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS

/turf/closed/mineral/gold/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS

/turf/closed/mineral/strange_rock/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS

/turf/closed/mineral/random/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS
	proximity_based = FALSE

/turf/closed/mineral/random/lunar/mineral_chances()
	return list(
		/obj/item/stack/ore/diamond = 4,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/silver = 24,
		/obj/item/stack/ore/titanium = 22,
	)

/turf/closed/mineral/random/labormineral/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS
	proximity_based = FALSE

/turf/closed/mineral/random/labormineral/lunar/mineral_chances()
	return list(
		/obj/item/boulder/gulag_expanded = 166,
		/turf/closed/mineral/gibtonite/lunar_cave = 2,
		)

/turf/closed/mineral/random/high_chance/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS
	proximity_based = FALSE

/turf/closed/mineral/random/high_chance/lunar/mineral_chances()
	return list(
		/obj/item/stack/ore/bluespace_crystal = 20,
		/obj/item/stack/ore/diamond = 30,
		/obj/item/stack/ore/gold = 45,
		/obj/item/stack/ore/plasma = 50,
		/obj/item/stack/ore/silver = 50,
		/obj/item/stack/ore/titanium = 45,
		/obj/item/stack/ore/uranium = 35
	)


/turf/closed/mineral/random/low_chance/lunar
	icon = MAP_SWITCH('modular_zubbers/icons/turf/lunar_rock_wall.dmi', 'modular_zubbers/icons/turf/lunar_rock_wall_icon.dmi')
	icon_state = "rock_wall-15"
	base_icon_state = "rock_wall"
	color = null
	turf_type = /turf/open/misc/moonstation_rock
	baseturfs = /turf/open/misc/moonstation_rock
	defer_change = TRUE
	initial_gas_mix = MOONSTATION_ATMOS
	proximity_based = FALSE

/turf/closed/mineral/random/low_chance/lunar/mineral_chances()
	return list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/plasma = 15,
		/obj/item/stack/ore/silver = 6,
		/obj/item/stack/ore/titanium = 4,
		/obj/item/stack/ore/uranium = 2
	)
