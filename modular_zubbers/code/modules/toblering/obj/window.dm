/obj/structure/window
	var/skirting_color

/obj/structure/window/update_overlays(updates)
	. = ..()
	if(fulltile)
		var/image/stripe = image('modular_zubbers/icons/turf/walls/wall_stripe.dmi', "stripe-[smoothing_junction]")
		stripe.appearance_flags = RESET_COLOR
		stripe.color = skirting_color || "#68686e"
		. += stripe

/obj/structure/window/fulltile
	icon = 'modular_zubbers/icons/obj/smooth_structures/window.dmi'
	color = "#AFD3E6"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/plasma/fulltile
	icon = 'modular_zubbers/icons/obj/smooth_structures/window.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#c162ec"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/fulltile
	icon = 'modular_zubbers/icons/obj/smooth_structures/window_reinforced.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#818d97"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/plasma/fulltile
	icon = 'modular_zubbers/icons/obj/smooth_structures/window_reinforced.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#c162ec"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'modular_zubbers/icons/obj/smooth_structures/window_reinforced.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#2f4049"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/shuttle
	icon = 'modular_zubbers/icons/obj/smooth_structures/window_reinforced.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#D0CBD4"
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/plasma/plastitanium
	icon = 'modular_zubbers/icons/obj/smooth_structures/window_reinforced.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#9d98a1"
	smoothing_groups = SMOOTH_GROUP_WINDOW_FULLTILE
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/bronze/fulltile
	icon = 'modular_zubbers/icons/obj/smooth_structures/window.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	color = "#92661A"
	smoothing_groups = SMOOTH_GROUP_WINDOW_FULLTILE
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
