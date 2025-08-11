// GS13: Extra wood walls
/turf/closed/wall/mineral/gmushroom
	name = "mushroom wall"
	desc = "A wall with mushroom plating."
	icon = 'modular_gs/icons/turf/walls/gmushroom_wall.dmi'
	icon_state = "gmushroom"
	sheet_type = /obj/item/stack/sheet/mineral/gmushroom
	hardness = 70
	canSmoothWith = list(/turf/closed/wall/mineral/gmushroom, /obj/structure/falsewall/gmushroom, /turf/closed/wall/mineral/gmushroom/nonmetal)

/turf/closed/wall/mineral/gmushroom/attackby(obj/item/W, mob/user)
	if(W.sharpness && W.force)
		var/duration = (48/W.force) * 2 //In seconds, for now.
		if(istype(W, /obj/item/hatchet) || istype(W, /obj/item/fireaxe))
			duration /= 4 //Much better with hatchets and axes.
		if(do_after(user, duration*10, target=src)) //Into deciseconds.
			dismantle_wall(FALSE,FALSE)
			return
	return ..()

/turf/closed/wall/mineral/gmushroom/nonmetal
	desc = "A solidly mushroom wall. It's a bit weaker than a wall made with metal."
	hardness = 50
	canSmoothWith = list(/turf/closed/wall/mineral/gmushroom, /obj/structure/falsewall/gmushroom, /turf/closed/wall/mineral/gmushroom/nonmetal)

/turf/closed/wall/mineral/plaswood
	name = "plaswood wall"
	desc = "A wall with plaswood plating."
	icon = 'modular_gs/icons/turf/walls/plaswood_wall.dmi'
	icon_state = "plaswood"
	sheet_type = /obj/item/stack/sheet/mineral/plaswood
	hardness = 90
	canSmoothWith = list(/turf/closed/wall/mineral/plaswood, /obj/structure/falsewall/plaswood, /turf/closed/wall/mineral/plaswood/nonmetal)

/turf/closed/wall/mineral/plaswood/attackby(obj/item/W, mob/user)
	if(W.sharpness && W.force)
		var/duration = (48/W.force) * 2 //In seconds, for now.
		if(istype(W, /obj/item/hatchet) || istype(W, /obj/item/fireaxe))
			duration /= 4 //Much better with hatchets and axes.
		if(do_after(user, duration*10, target=src)) //Into deciseconds.
			dismantle_wall(FALSE,FALSE)
			return
	return ..()

/turf/closed/wall/mineral/plaswood/nonmetal
	desc = "A solidly plaswood wall. It's a bit weaker than a wall made with metal."
	girder_type = /obj/structure/barricade/plaswood
	hardness = 70
	canSmoothWith = list(/turf/closed/wall/mineral/plaswood, /obj/structure/falsewall/plaswood, /turf/closed/wall/mineral/plaswood/nonmetal)

/turf/closed/wall/mineral/shadoww
	name = "shadow wall"
	desc = "A wall with shadow wood plating."
	icon = 'modular_gs/icons/turf/walls/shadoww_wall.dmi'
	icon_state = "shadoww"
	sheet_type = /obj/item/stack/sheet/mineral/shadoww
	hardness = 70
	canSmoothWith = list(/turf/closed/wall/mineral/shadoww, /obj/structure/falsewall/shadoww, /turf/closed/wall/mineral/shadoww/nonmetal)

/turf/closed/wall/mineral/shadoww/attackby(obj/item/W, mob/user)
	if(W.sharpness && W.force)
		var/duration = (48/W.force) * 2 //In seconds, for now.
		if(istype(W, /obj/item/hatchet) || istype(W, /obj/item/fireaxe))
			duration /= 4 //Much better with hatchets and axes.
		if(do_after(user, duration*10, target=src)) //Into deciseconds.
			dismantle_wall(FALSE,FALSE)
			return
	return ..()

/turf/closed/wall/mineral/shadoww/nonmetal
	desc = "A solidly shadow wall. It's a bit weaker than a wall made with metal."
	girder_type = /obj/structure/barricade/shadoww
	hardness = 50
	canSmoothWith = list(/turf/closed/wall/mineral/shadoww, /obj/structure/falsewall/shadoww, /turf/closed/wall/mineral/shadoww/nonmetal)
