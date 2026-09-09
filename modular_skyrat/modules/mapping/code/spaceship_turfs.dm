//Re-textures based off the survival pods, without the orange stripe. Now you can re-color them to paint your spaceships!
//(Do faded tones - DONT USE NEON BRIGHT COLORS, I /WILL/ CRY, and your ship will look like literal crap)
//Also make sure you properly var-edit everything hnngh

// Weep, for they have been invalidated by tg's own implementation!

/turf/closed/wall/mineral/plastitanium/darkpod/nodiagonal
	icon_state = "dark_pod_walls-15"
	base_icon_state = "survival_pod_walls"
	smoothing_flags = SMOOTH_BITMASK
	rust_resistance = RUST_RESISTANCE_TITANIUM


/turf/closed/wall/mineral/plastitanium/darkpod/overspace
	icon = MAP_SWITCH('modular_zubbers/icons/turf/walls/dark_pod.dmi', 'modular_skyrat/modules/mapping/icons/unique/spaceships/shipwalls.dmi')
	icon_state = MAP_SWITCH("dark_pod_walls-0", "map-overspace")
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)

/*
/turf/closed/wall/mineral/plastitanium/darkpod/copyTurf(turf/T)
	if(T.type != type)
		T.ChangeTurf(type)
		if(underlays.len)
			T.underlays = underlays
	if(T.icon_state != icon_state)
		T.icon_state = icon_state
	if(T.icon != icon)
		T.icon = icon
	if(color)
		T.atom_colours = atom_colours.Copy()
		T.update_atom_colour()
	if(T.dir != dir)
		T.setDir(dir)
	T.transform = transform
	return T

/turf/closed/wall/mineral/plastitanium/darkpod/copyTurf(turf/T)
	. = ..()
	T.transform = transform
*/

/obj/structure/window/reinforced/shuttle/darkpod
	name = "pod window"
	icon = 'modular_zubbers/icons/obj/smooth_structures/dark_pod_window.dmi'
	icon_state = "dark_pod_window-0"
	base_icon_state = "dark_pod_window"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_SURVIVAL_TITANIUM_POD
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_SURVIVAL_TITANIUM_POD + SMOOTH_GROUP_WALLS
	obj_flags = CAN_BE_HIT

/obj/effect/spawner/structure/window/darkpod
	name = "dark pod window spawner"
	icon_state = "podwindow_spawner"
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/shuttle/darkpod)

/obj/structure/window/reinforced/shuttle/darkpod/tinted
	color = "#808080"
	opacity = TRUE

/obj/structure/window/reinforced/shuttle/darkpod/unanchored
	anchored = FALSE
