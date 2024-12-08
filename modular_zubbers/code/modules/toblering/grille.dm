/obj/structure/grille
	icon = 'modular_zubbers/icons/obj/smooth_structures/grille.dmi'
	icon_state = "grille-0"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLE)
	canSmoothWith = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_GRILLE
	color = "#545454"

/obj/structure/grille/update_icon_state()
	. = ..()
	if(broken)
		icon_state = "brokengrille"

/obj/structure/grille/set_smoothed_icon_state(new_junction)
	if(broken)
		icon_state = "brokengrille"
	return ..()
