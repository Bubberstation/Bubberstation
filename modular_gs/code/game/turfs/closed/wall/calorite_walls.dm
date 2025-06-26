/turf/closed/wall/mineral/calorite //GS13
	name = "calorite wall"
	desc = "A wall with calorite plating. Burp."
	icon = 'modular_gs/icons/turf/calorite_wall.dmi'
	icon_state = "calorite_wall-0"
	base_icon_state = "calorite_wall"
	sheet_type = /obj/item/stack/sheet/mineral/calorite
	smoothing_groups = SMOOTH_GROUP_CALORITE_WALL + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_CALORITE_WALL
	var/active = null
	var/last_event = 0

/turf/closed/wall/mineral/calorite/proc/fatten()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				M.adjust_fatness(30, FATTENING_TYPE_ITEM)
			last_event = world.time
			active = null
			return
	return

/turf/closed/wall/mineral/calorite/Bumped(atom/movable/AM)
	fatten()
	..()

/turf/closed/wall/mineral/calorite/attackby(obj/item/W, mob/user, params)
	fatten()
	return ..()

/turf/closed/wall/mineral/calorite/attack_hand(mob/user)
	fatten()
	. = ..()