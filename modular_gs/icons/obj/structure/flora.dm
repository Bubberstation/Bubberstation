/obj/structure/ashtree/ashstump
	name = "Ashtree stump"
	desc = "Return to ashes."
	icon = 'modular_gs/icons/obj/flora/ashtree.dmi'
	icon_state = "ashtree_stump"
	density = FALSE
	pixel_x = -16

/obj/structure/flora/ashtree/ashtreee
	name = "Ashtree"
	desc = "A small native lavaland tree."
	icon = 'modular_gs/icons/obj/flora/ashtree.dmi'
	icon_state = "ashtree_1"
	var/list/icon_states = list("ashtree_1", "ashtree_2")

/obj/structure/flora/ashtree/ashtreee/Initialize()
	. = ..()

	if(islist(icon_states && icon_states.len))
		icon_state = pick(icon_states)

//
/obj/structure/flora/gmushroom
	name = "Giant mushroom"
	desc = "An impressive overgrown mushroom."
	max_integrity = 80
	density = TRUE
	pixel_x = -16
	layer = FLY_LAYER
	var/log_amount = 10

/obj/structure/flora/gmushroom/attackby(obj/item/W, mob/user, params)
	if(log_amount && (!(flags_1 & NO_DEBRIS_AFTER_DECONSTRUCTION)))
		if(W.sharpness && W.force > 0)
			if(W.hitsound)
				playsound(get_turf(src), W.hitsound, 100, 0, 0)
			user.visible_message("<span class='notice'>[user] begins to cut down [src] with [W].</span>","<span class='notice'>You begin to cut down [src] with [W].</span>", "You hear the sound of sawing.")
			if(do_after(user, 1000/W.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
				user.visible_message("<span class='notice'>[user] fells [src] with the [W].</span>","<span class='notice'>You fell [src] with the [W].</span>", "You hear the sound of a tree falling.")
				playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100 , 0, 0)
				for(var/i=1 to log_amount)
					new /obj/item/grown/log/gmushroom(get_turf(src))

				var/obj/structure/gmushroom/gmushroomstump/S = new(loc)
				S.name = "[name] stump"

				qdel(src)

	else
		return ..()

/obj/structure/gmushroom/gmushroomstump
	name = "Giant mushroom stump"
	desc = "It will grow back. Maybe. One day."
	icon = 'modular_gs/icons/obj/flora/gmushroom.dmi'
	icon_state = "gmushroom_stump"
	density = FALSE
	pixel_x = -16

/obj/structure/flora/gmushroom/gggmushroom
	name = "Giant mushroom"
	desc = "An impressive overgrown mushroom."
	icon = 'modular_gs/icons/obj/flora/gmushroom.dmi'
	icon_state = "gmushroom_1"
	var/list/icon_states = list("gmushroom_1", "gmushroom_2")

/obj/structure/flora/gmushroom/gggmushroom/Initialize()
	. = ..()

	if(islist(icon_states && icon_states.len))
		icon_state = pick(icon_states)


/obj/structure/flora/shadowtree
	name = "Shadow tree"
	desc = "A native lavaland tree, with a remarkable purple color."
	icon = 'modular_gs/icons/obj/flora/shadowtree.dmi'
	max_integrity = 80
	density = TRUE
	pixel_x = -16
	layer = FLY_LAYER
	var/log_amount = 10

/obj/structure/flora/shadowtree/attackby(obj/item/W, mob/user, params)
	if(log_amount && (!(flags_1 & NO_DEBRIS_AFTER_DECONSTRUCTION)))
		if(W.sharpness && W.force > 0)
			if(W.hitsound)
				playsound(get_turf(src), W.hitsound, 100, 0, 0)
			user.visible_message("<span class='notice'>[user] begins to cut down [src] with [W].</span>","<span class='notice'>You begin to cut down [src] with [W].</span>", "You hear the sound of sawing.")
			if(do_after(user, 1000/W.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
				user.visible_message("<span class='notice'>[user] fells [src] with the [W].</span>","<span class='notice'>You fell [src] with the [W].</span>", "You hear the sound of a tree falling.")
				playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100 , 0, 0)
				for(var/i=1 to log_amount)
					new /obj/item/grown/log/shadowtree(get_turf(src))

				var/obj/structure/shadowtree/shadowtreestump/S = new(loc)
				S.name = "[name] stump"

				qdel(src)

	else
		return ..()

/obj/structure/shadowtree/shadowtreestump
	name = "Shadow tree stump"
	desc = "Hidden in the shadowns."
	icon = 'modular_gs/icons/obj/flora/shadowtree.dmi'
	icon_state = "shadowtree_stump"
	density = FALSE
	pixel_x = -16

/obj/structure/flora/shadowtree/shadowtreee
	name = "Shadow tree"
	desc = "A native Lavaland tree, with a remarkable purple color."
	icon = 'modular_gs/icons/obj/flora/shadowtree.dmi'
	icon_state = "shadowtree_1"
	var/list/icon_states = list("shadowtree_1", "shadowtree_2")

/obj/structure/flora/shadowtree/shadowtreee/Initialize()
	. = ..()

	if(islist(icon_states && icon_states.len))
		icon_state = pick(icon_states)

//
/obj/structure/flora/plasmatree
	name = "Plasma tree"
	desc = "A tree that has absorved plasma from the ground, making its wood strong like metal."
	max_integrity = 100
	density = TRUE
	pixel_x = -16
	layer = FLY_LAYER
	var/log_amount = 10

/obj/structure/flora/plasmatree/attackby(obj/item/W, mob/user, params)
	if(log_amount && (!(flags_1 & NO_DEBRIS_AFTER_DECONSTRUCTION)))
		if(W.sharpness && W.force > 0)
			if(W.hitsound)
				playsound(get_turf(src), W.hitsound, 100, 0, 0)
			user.visible_message("<span class='notice'>[user] begins to cut down [src] with [W].</span>","<span class='notice'>You begin to cut down [src] with [W].</span>", "You hear the sound of sawing.")
			if(do_after(user, 1000/W.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
				user.visible_message("<span class='notice'>[user] fells [src] with the [W].</span>","<span class='notice'>You fell [src] with the [W].</span>", "You hear the sound of a tree falling.")
				playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100 , 0, 0)
				for(var/i=1 to log_amount)
					new /obj/item/grown/log/plasmatree(get_turf(src))

				var/obj/structure/plasmatree/plasmatreestump/S = new(loc)
				S.name = "[name] stump"

				qdel(src)

	else
		return ..()

/obj/structure/plasmatree/plasmatreestump
	name = "Plasma tree stump"
	desc = "Pointy and sharp."
	icon = 'modular_gs/icons/obj/flora/plasmatree.dmi'
	icon_state = "plasmatree_stump"
	density = FALSE
	pixel_x = -16

/obj/structure/flora/plasmatree/plasmatreee
	name = "Plasma tree"
	desc = "A tree that has absorved plasma from the ground, making its wood strong like metal."
	icon = 'modular_gs/icons/obj/flora/plasmatree.dmi'
	icon_state = "plasmatree_1"
	var/list/icon_states = list("plasmatree_1", "plasmatree_2")

/obj/structure/flora/plasmatree/plasmatreee/Initialize()
	. = ..()

	if(islist(icon_states && icon_states.len))
		icon_state = pick(icon_states)


/obj/structure/flora/crystal
	name = "crystal"
	desc = "You shouldnt see this!"
	gender = PLURAL //trans rights
	max_integrity = 30

/obj/structure/flora/crystal/small
	name = "small crystals"
	icon = 'modular_gs/icons/obj/flora/layeniasmall.dmi'
	light_range = 2
	light_power = 0.25
	light_color = LIGHT_COLOR_BLUE

//Small crystal clusters
/obj/structure/flora/crystal/small/pile
	name = "small crystals"
	desc = "A pile of small crystals"
	icon_state = "crystals"

/obj/structure/flora/crystal/small/pile/Initialize()
	if(icon_state == "crystals")
		icon_state = "crystals[rand(1, 4)]"
	. = ..()

//Small crystal growths
/obj/structure/flora/crystal/small/growth
	name = "small crystals"
	desc = "A growth of small crystals"
	icon_state = "crystalgrowth"

/obj/structure/flora/crystal/small/growth/Initialize()
	if(icon_state == "crystalgrowth")
		icon_state = "crystalgrowth[rand(1, 4)]"
	. = ..()

/obj/structure/flora/crystal/medium
	name = "medium crystals"
	icon = 'modular_gs/icons/obj/flora/layeniamedium.dmi'
	pixel_x = -16
	pixel_y = -3
	layer = ABOVE_ALL_MOB_LAYER
	light_range = 4
	light_power = 0.75
	light_color = LIGHT_COLOR_BLUE

//Medium crystal growths
/obj/structure/flora/crystal/medium/growth
	name = "medium crystals"
	desc = "A growth of medium crystals"
	icon_state = "crystalgrowth"

/obj/structure/flora/crystal/medium/growth/Initialize()
	if(icon_state == "crystalgrowth")
		icon_state = "crystalgrowth[rand(1, 3)]"
	. = ..()

//lavaland grass
/obj/structure/flora/redgrass
	name = "tall grass"
	desc = "A patch of overgrown red grass."
	icon = 'modular_gs/icons/obj/lavaland/redgrass.dmi'
	gender = PLURAL	//"this is grass" not "this is a grass"

/obj/structure/flora/redgrass/redg
	icon_state = "tallgrass1bb"

/obj/structure/flora/redgrass/redg/Initialize()
	icon_state = "tallgrass[rand(1, 4)]bb"
	. = ..()

/obj/structure/flora/tree/desertdead
	icon = 'modular_gs/icons/obj/flora/desertdead.dmi'
	desc = "A dead tree in the middle of the desert."
	icon_state = "desertdead_1"
	var/list/icon_states = list ("desertdead_1", "desertdead_2", "desertdead_3")

/obj/structure/flora/tree/desertdead/Initialize()
	. = ..()

	if(islist(icon_states && icon_states.len))
		icon_state = pick(icon_states)
