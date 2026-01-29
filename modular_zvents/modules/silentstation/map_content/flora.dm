/obj/structure/flora/tree/massive
	name = "tree"
	desc = "A large tree."
	icon = 'modular_zvents/icons/structures/trees.dmi'
	icon_state = "big_style_1"
	base_icon_state = "big_style"
	density = TRUE
	max_integrity = 250
	pixel_x = -48
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	drag_slowdown = 2.5
	harvest_amount_low = 15
	harvest_amount_high = 25
	harvest_verb = "chop"
	harvest_verb_suffix = "s down"
	delete_on_harvest = TRUE

/obj/structure/flora/tree/massive/style_1
	icon_state = "big_style_1"

/obj/structure/flora/tree/massive/style_2
	icon_state = "big_style_2"

/obj/structure/flora/tree/massive/style_2
	icon_state = "big_style_3"

/obj/structure/flora/tree/massive/style_2
	icon_state = "big_style_4"

/obj/structure/flora/tree/massive/style_random

/obj/structure/flora/tree/massive/style_random/Initialize(mapload)
	. = ..()
	icon_state = base_icon_state + "_" + "[(rand(1, 4))]"

/obj/structure/flora/tree/massive/very_big
	icon = 'modular_zvents/icons/structures/trees_big.dmi'
	icon_state = "style1"

/obj/structure/flora/tree/massive/dead
	name = "dead tree"
	icon_state = "big_dead_style_1"
	base_icon_state = "big_dead"
	max_integrity = 150

/obj/structure/flora/tree/massive/dead/style_1
	icon_state = "big_dead_style_1"

/obj/structure/flora/tree/massive/dead/style_2
	icon_state = "big_dead_style_2"

/obj/structure/flora/tree/massive/dead/style_3
	icon_state = "big_dead_style_3"

/obj/structure/flora/tree/massive/dead/style_random

/obj/structure/flora/tree/massive/dead/style_random/Initialize(mapload)
	. = ..()
	icon_state = base_icon_state + "_" + "[(rand(1, 3))]"
